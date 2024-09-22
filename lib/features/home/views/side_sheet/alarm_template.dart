import 'package:flutter/material.dart';
import 'package:sos/shared/models/alarm.dart';
import 'package:sos/shared/styles/global_styles.dart';
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
          margin: const EdgeInsets.only(left: 20.0, top: 2.0, bottom: 2.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0), // 왼쪽 상단 모서리 둥글게
              bottomLeft: Radius.circular(10.0), // 왼쪽 하단 모서리 둥글게
            ),
            color: alarm.isRead ? Colors.white : AppColors.blue,
            boxShadow: [
              alarm.isRead
                  ? BoxShadow(color: Colors.transparent)
                  : BoxShadow(
                      color: Colors.black.withOpacity(0.3), // 그림자 색상 및 투명도
                      spreadRadius: 0.2, // 그림자 퍼짐 정도
                      blurRadius: 6, // 그림자의 흐릿함 정도
                      offset: Offset(2, 4), // 그림자의 위치 (x, y 좌표)
                    ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 20, top: 10.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alarm.notificationMessage,
                  maxLines: 2, // 최대 두 줄로 제한
                  overflow: TextOverflow.ellipsis, // 텍스트가 넘치면 '...'로 표시
                  style: TextStyle(
                    color: alarm.isRead ? AppColors.black : AppColors.white,
                    fontSize: 14,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3), // content와 date 사이의 간격
                Text(
                  formatTimeAgo(alarm.createdAt),
                  style: TextStyle(
                    color: alarm.isRead
                        ? AppColors.textGray
                        : const Color.fromARGB(165, 255, 255, 255),
                    fontSize: 10,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                    height: 1.0,
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
