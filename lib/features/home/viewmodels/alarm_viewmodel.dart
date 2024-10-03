import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/repositories/alarm_repository.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/views/side_sheet/favorite_alert_modal.dart';
import 'package:sos/features/post/repositories/post_repository.dart';
import 'package:sos/shared/models/alarm.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/providers/user_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';
import 'package:sos/shared/repositories/user_repository.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class AlarmViewModel extends StateNotifier<List<Alarm>> {
  final FriendsRepository friendsRepository;
  final AlarmRepository alarmRepository;
  final PostRepository postRepository;
  final UserRepository userRepository;

  AlarmViewModel(
    this.friendsRepository,
    this.alarmRepository,
    this.postRepository,
    this.userRepository,
  ) : super([]) {
    fetchAlarms();
  }

  Future<void> fetchAlarms() async {
    final fetchedAlarms = await alarmRepository.getAlarms();
    state = fetchedAlarms;
  }

  Future<void> markAsRead(int notificationId) async {
    final success = await alarmRepository.patchAlarmRead(notificationId);

    if (success) {
      // Re-fetch the updated alarms list after marking as read
      final updatedAlarms = await alarmRepository.getAlarms();
      state = updatedAlarms;
    }
  }

  // 친구 거절하면 친구 테이블 및 알림 테이블에서 삭제 됨 (markAsRead 안해도 됨)
  Future<void> acceptFriendRequest(BuildContext context, int friendId) async {
    await friendsRepository.acceptFriendRequest(friendId);

    final updatedAlarms = await alarmRepository.getAlarms();
    state = updatedAlarms;

    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        text: '지인 등록 요청을 수락했습니다.',
        backgroundColor: AppColors.blue,
      ),
    );
  }

  // 친구 수락하면 알림 테이블에서 삭제 됨 (markAsRead 안해도 됨)
  Future<void> rejectFriendRequest(BuildContext context, int friendId) async {
    await friendsRepository.rejectFriendRequest(friendId);

    final updatedAlarms = await alarmRepository.getAlarms();
    state = updatedAlarms;

    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        text: '지인 등록 요청을 거절했습니다.',
        backgroundColor: AppColors.red,
      ),
    );
  }

  void handleFriendRequest(BuildContext context, Alarm alarm) {
    showDialog(
      context: context,
      builder: (context) {
        return SettingModal(
          title: '관심 사용자 요청',
          content: alarm.notificationMessage, // Use alarm data
          leftBtn: '거절',
          rightBtn: '수락',
          onLeftBtnPressed: () async {
            await rejectFriendRequest(context, alarm.referenceId);
            Navigator.of(context).pop();
          },
          onRightBtnPressed: () async {
            await acceptFriendRequest(context, alarm.referenceId);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> handleNearbyEvent(
      BuildContext context, WidgetRef ref, Alarm alarm) async {
    await markAsRead(alarm.notificationId);
    final post = await postRepository.getPostOverviewById(alarm.referenceId);

    // 알림 창을 닫은 뒤 해당 위치로 지도 이동
    Navigator.of(context).pop();
    final NaverMapController? mapController = ref.read(mapControllerProvider);
    if (mapController != null) {
      // 알림에 따라 해당 위치로 지도 이동
      await mapController.updateCamera(
        NCameraUpdate.scrollAndZoomTo(
          target: NLatLng(post.latitude!, post.longitude!),
          zoom: 15,
        ),
      );
    } else {
      // NaverMapController가 null일 경우 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          text: '지도 컨트롤러를 초기화할 수 없습니다.',
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> handleHelpRequest(
      BuildContext context, WidgetRef ref, Alarm alarm) async {
    await markAsRead(alarm.notificationId);
    final user = await userRepository.getUserById(alarm.referenceId);

    // 친구 위치로 지도 이동
    Navigator.of(context).pop();
    final NaverMapController? mapController = ref.read(mapControllerProvider);
    if (mapController != null) {
      await mapController.updateCamera(
        NCameraUpdate.scrollAndZoomTo(
          target: NLatLng(user.latitude!, user.longitude!),
          zoom: 15,
        ),
      );
    } else {
      // NaverMapController가 null일 경우 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          text: '지도 컨트롤러를 초기화할 수 없습니다.',
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> handleFavoriteNearbyEvent(
      BuildContext context, WidgetRef ref, Alarm alarm) async {
    await markAsRead(alarm.notificationId);
    final user = await userRepository.getUserById(alarm.referenceId);

    // 친구 위치로 지도 이동
    Navigator.of(context).pop();
    final NaverMapController? mapController = ref.read(mapControllerProvider);
    if (mapController != null) {
      await mapController.updateCamera(
        NCameraUpdate.scrollAndZoomTo(
          target: NLatLng(user.latitude!, user.longitude!),
          zoom: 15,
        ),
      );
    } else {
      // NaverMapController가 null일 경우 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          text: '지도 컨트롤러를 초기화할 수 없습니다.',
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  return AlarmRepository();
});

final alarmViewModelProvider =
    StateNotifierProvider<AlarmViewModel, List<Alarm>>((ref) {
  final alarmRepository = ref.read(alarmRepositoryProvider);
  final friendsRepository = ref.read(friendsRepositoryProvider);
  final postRepository = ref.read(postRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  return AlarmViewModel(
    friendsRepository,
    alarmRepository,
    postRepository,
    userRepository,
  );
});
