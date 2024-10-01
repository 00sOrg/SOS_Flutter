import 'dart:developer';
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
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class RescueViewModel extends StateNotifier<List<Friend>> {
  final RescueRepository rescueRepository;
  final FriendsRepository friendsRepository;

  RescueViewModel(this.friendsRepository, this.rescueRepository) : super([]) {
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

  void handleFriendHelp({
    required int id,
    required String name,
  }) {
    log('HANDLE FRIEND HELP: $name');
  }

  void handleFriendAdd(BuildContext context) {
    log("HANDLE ADD FRIEND");
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

    final success = await rescueRepository.requestHelp(lat, lon);
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

  void askFriendHelpModal({
    required BuildContext context,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext modalContext) {
        return SettingModal(
          title: '도움 요청',
          content: '내 주변에 도움을 요청하시겠습니까?',
          leftBtn: '취소',
          rightBtn: '삭제',
          onRightBtnPressed: () {
            Navigator.of(modalContext).pop();
            handleNearbyAlert(context);
          },
        );
      },
    );
  }

  final String dummyName = '더미네임F';
  final String dummySex = '성별별~';

  void handleEmergencyAlert() async {
    await getCurrentPosition();

    if (_currentPosition == null) {
      debugPrint("위치 정보가 없음");
      return;
    }

    final lat = _currentPosition!.latitude;
    final lon = _currentPosition!.longitude;

    String message = '''
  [SOS] 긴급 상황입니다! 긴급 구조를 요청합니다.
  구조 요청자 정보:
  이름: $dummyName
  성별: $dummySex
  위치: 위도 $lat, 경도 $lon
  ''';

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
  return RescueViewModel(friendsRepository, rescueRepository);
});
