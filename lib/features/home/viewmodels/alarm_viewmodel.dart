import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AlarmType { friendRequest, nearbyEvent, userActivity }

class Alarm {
  final String content;
  final DateTime date;
  final AlarmType type;
  bool isRead;

  Alarm({
    required this.content,
    required this.date,
    required this.type,
    this.isRead = false,
  });
}

class AlarmViewModel extends StateNotifier<List<Alarm>> {
  AlarmViewModel() : super([]) {
    _loadInitialAlarms();
  }

  void _loadInitialAlarms() {
    state = [
      Alarm(
        content: '사용자 A가 친구 요청을 보냈습니다.',
        date: DateTime.now().subtract(const Duration(minutes: 30)),
        type: AlarmType.friendRequest,
      ),
      Alarm(
        content: '근처에서 이벤트가 발생했습니다.',
        date: DateTime.now().subtract(const Duration(hours: 1)),
        type: AlarmType.nearbyEvent,
      ),
      Alarm(
        content: '관심 있는 사용자가 새로운 글을 게시했습니다.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        type: AlarmType.userActivity,
      ),
      Alarm(
        content: '관심 있는 사용자가 새로운 글을 게시했습니다. 관심 있는 사용자가 새로운 글을 게시했습니다. ',
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: AlarmType.userActivity,
      ),
    ];
  }

  void markAsRead(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  void handleFriendRequest(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('친구 요청'),
          content: Text('사용자를 관심 사용자로 추가하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 수락 로직 구현
                markAsRead(index); // 알림을 읽음으로 처리하고 목록에서 제거
              },
              child: Text('수락'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // 거절 로직 구현
                markAsRead(index); // 알림을 읽음으로 처리하고 목록에서 제거
              },
              child: Text('거절'),
            ),
          ],
        );
      },
    );
  }
}

final alarmViewModelProvider =
    StateNotifierProvider<AlarmViewModel, List<Alarm>>((ref) {
  return AlarmViewModel();
});
