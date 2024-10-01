import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/rescue/repositories/rescue_repository.dart';
import 'package:sos/features/setting/views/widgets/setting_modal.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';
import 'package:sos/shared/services/geolocator_service.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/log_util.dart';
import 'package:sos/shared/viewmodels/user_viewmodel.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  final RescueRepository rescueRepository;
  final FriendsRepository friendsRepository;
  final UserViewModel userViewModel;

  RescueViewModel(
    this.friendsRepository,
    this.rescueRepository,
    this.userViewModel,
  ) : super([]) {
    fetchFriends();
  }

  Position? _currentPosition;

  Future<void> getCurrentPosition() async {
    try {
      _currentPosition = await GeolocatorService.getCurrentPosition();
      debugPrint('Current Position: $_currentPosition');
    } catch (e) {
      LogUtil.e("위치 가져오기 실패: $e");
    }
  }

  Future<void> fetchFriends() async {
    final friends = await friendsRepository.getFriendsList();
    // isAccepted == true인 사용자만
    state = friends.where((friend) => friend.isAccepted!).toList();
  }

  Future<void> handleFriendHelp({
    required BuildContext context,
    required int id,
    required String name,
  }) async {
    try {
      bool success = await rescueRepository.requestFriendHelp(id);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            text: '$name 근처에 도움 요청을 보냈습니다',
            backgroundColor: AppColors.blue,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(text: '도움 요청 전송에 실패했습니다.'),
        );
      }
    } catch (e) {
      LogUtil.e('handleFriendHelp 에러: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: '도움 요청 중 문제가 발생했습니다'),
      );
    }
  }

  void askFriendHelpModal({
    required BuildContext context,
    required int id,
    required String name,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext modalContext) {
        return SettingModal(
          title: '도움 요청',
          content: '$name 주변에 도움을 요청하시겠습니까?',
          leftBtn: '취소',
          rightBtn: '확인',
          onRightBtnPressed: () {
            Navigator.of(modalContext).pop();
            handleFriendHelp(
              context: context,
              id: id,
              name: name,
            );
          },
        );
      },
    );
  }

  void handleFriendAdd(BuildContext context) {
    GoRouter.of(context).push('/setting-favorite-search');
  }

  void handleNearbyAlert(BuildContext context) async {
    await getCurrentPosition();

    if (_currentPosition == null) {
      debugPrint("위치 정보 없음");
      return;
    }

    final lat = _currentPosition!.latitude;
    final lon = _currentPosition!.longitude;

    final success = await rescueRepository.requestNearbyHelp(lat, lon);

    if (success) {
      debugPrint('내 주변 도움 요청 성공');
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          text: '도움을 요청했습니다',
          backgroundColor: AppColors.blue,
        ),
      );
    } else {
      debugPrint('내 주변 도움 요청 실패');
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: '도움 요청을 실패했습니다'),
      );
    }
  }

  void handleEmergencyAlert() async {
    await getCurrentPosition();
    await userViewModel.loadUserInfo();
    final user = userViewModel.state;

    final height = user.height;
    final weight = user.weight;
    final bloodType = user.bloodType;
    final disease = user.disease;
    final medication = user.medication;

    if (_currentPosition == null) {
      debugPrint("위치 정보가 없음");
      return;
    }

    final lat = _currentPosition!.latitude;
    final lon = _currentPosition!.longitude;

    String message = '''
  [SOS] 긴급 상황입니다! 긴급 구조를 요청합니다.
  구조 요청자 정보: ${user.name} / ${user.sex} 
  위치: 위도 $lat, 경도 $lon
  ''';

    if (height != null && height.isNotEmpty) {
      message += '신장: $height\n';
    }
    if (weight != null && weight.isNotEmpty) {
      message += '체중: $weight\n';
    }
    if (bloodType != null && bloodType.isNotEmpty) {
      message += '혈액형: $bloodType\n';
    }
    if (disease != null && disease.isNotEmpty) {
      message += '질병: $disease\n';
    }
    if (medication != null && medication.isNotEmpty) {
      message += '복용 중인 약물: $medication\n';
    }
    debugPrint(message);

    List<String> recipents = ['119', '112'];

    try {
      String result = await sendSMS(
        message: message,
        recipients: recipents,
      ).catchError((onError) {
        debugPrint("SMS 전송 오류: $onError");
        return 'SMS 전송 오류';
      });

      debugPrint("SMS 전송: $result");
    } catch (e) {
      debugPrint("SMS 전송 실패: $e");
    }
  }
}

final rescueViewModelProvider =
    StateNotifierProvider<RescueViewModel, List<Friend>>((ref) {
  final friendsRepository = ref.read(friendsRepositoryProvider);
  final rescueRepository = ref.read(rescueRepositoryProvider);
  final userViewModel = ref.read(userViewModelProvider.notifier);
  return RescueViewModel(friendsRepository, rescueRepository, userViewModel);
});
