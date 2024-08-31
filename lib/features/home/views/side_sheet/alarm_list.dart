import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/alarm_viewmodel.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class AlarmTemplate extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onTap;

  const AlarmTemplate({
    super.key,
    required this.alarm,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // 투명하게 설정하여 배경색이 유지되도록 함
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
              vertical: 2.0, horizontal: 15.0), // 상하, 좌우에 5px 패딩
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), // 모서리 둥글게
            color: alarm.isRead
                ? Colors.white
                : const Color(0xFFD5DFEF), // 읽은 상태에 따라 배경색 변경
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // 패딩 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarm.content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3), // content와 date 사이의 간격
                Text(
                  formatTimeAgo(alarm.date),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlarmList extends StatefulWidget {
  final List<Alarm> alarms;
  final WidgetRef ref;

  const AlarmList({
    super.key,
    required this.alarms,
    required this.ref,
  });

  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.alarms.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final alarm = widget.alarms[index];
          return AlarmTemplate(
            alarm: alarm,
            onTap: () {
              setState(() {
                alarm.isRead = true; // 알림이 읽혔다고 표시
              });

              // Alarm의 타입에 따라 다른 동작을 할 수 있음
              if (alarm.type == AlarmType.friendRequest) {
                // 알림 타입이 친구 요청인 경우 알림 창 표시
                widget.ref
                    .read(alarmViewModelProvider.notifier)
                    .handleFriendRequest(context, index);
              } else if (alarm.type == AlarmType.nearbyEvent) {
                // 주변 사건 처리 로직
              } else if (alarm.type == AlarmType.userActivity) {
                // 사용자 활동 관련 처리 로직
              }

              // 눌렸을 때 반응을 위한 로그 또는 다른 처리
              print('Alarm tapped: ${alarm.content}');
            },
          );
        },
      ),
    );
  }
}
