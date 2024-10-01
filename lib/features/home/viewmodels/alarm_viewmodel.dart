import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/repositories/alarm_repository.dart';
import 'package:sos/features/home/views/side_sheet/favorite_alert_modal.dart';
import 'package:sos/shared/models/alarm.dart';
import 'package:sos/shared/providers/friend_repository_provider.dart';
import 'package:sos/shared/repositories/friends_repository.dart';

enum AlarmType {
  FAVORITE_REQUEST,
  NEARBY_EVENT,
  HELP_REQUEST,
  FAVORITE_NEARBY_EVENT,
}

class AlarmViewModel extends StateNotifier<List<Alarm>> {
  final FriendsRepository friendsRepository;
  final AlarmRepository alarmRepository;

  AlarmViewModel(this.friendsRepository, this.alarmRepository) : super([]) {
    fetchAlarms();
  }

  Future<void> fetchAlarms() async {
    final fetchedAlarms = await alarmRepository.getAlarms();
    state = fetchedAlarms;
  }

  Future<void> markAsRead(int notificationId) async {
    final success = await alarmRepository.patchReadAlarm(notificationId);

    if (success) {
      // Re-fetch the updated alarms list after marking as read
      final updatedAlarms = await alarmRepository.getAlarms();
      state = updatedAlarms;
    }
  }

  // 친구 거절하면 친구 테이블 및 알림 테이블에서 삭제 됨 (markAsRead 안해도 됨)
  Future<void> acceptFriendRequest(int friendId) async {
    await friendsRepository.acceptFriendRequest(friendId);

    final updatedAlarms = await alarmRepository.getAlarms();
    state = updatedAlarms;
  }

  // 친구 수락하면 알림 테이블에서 삭제 됨 (markAsRead 안해도 됨)
  Future<void> rejectFriendRequest(int friendId) async {
    await friendsRepository.rejectFriendRequest(friendId);

    final updatedAlarms = await alarmRepository.getAlarms();
    state = updatedAlarms;
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
            await rejectFriendRequest(alarm.referenceId);
            Navigator.of(context).pop();
          },
          onRightBtnPressed: () async {
            await acceptFriendRequest(alarm.referenceId);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

final alarmRepositoryProvider = Provider<AlarmRepository>((ref) {
  return AlarmRepository();
});

final alarmViewModelProvider =
    StateNotifierProvider<AlarmViewModel, List<Alarm>>((ref) {
  final friendsRepository = ref.read(friendsRepositoryProvider);
  final alarmRepository = ref.read(alarmRepositoryProvider);
  return AlarmViewModel(friendsRepository, alarmRepository);
});
