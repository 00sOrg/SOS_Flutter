import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/alarm_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/home/views/side_sheet/alarm_template.dart';
import 'package:sos/shared/models/alarm.dart';
import 'package:sos/shared/styles/global_styles.dart';

class AlarmList extends ConsumerWidget {
  final List<Alarm> alarms;

  const AlarmList({
    super.key,
    required this.alarms,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.separated(
        itemCount: alarms.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final alarm = alarms[index];
          return AlarmTemplate(
            alarm: alarm,
            onTap: () async {
              debugPrint('Alarm tapped: ${alarm} ');

              if (alarm.isRead) {
                return;
              }

              final alarmType = getAlarmType(alarm.notificationType);

              switch (alarmType) {
                case AlarmType.FAVORITE_REQUEST:
                  ref
                      .read(alarmViewModelProvider.notifier)
                      .handleFriendRequest(context, alarm);
                  break;
                case AlarmType.NEARBY_EVENT:
                  // Nearby event logic
                  break;
                case AlarmType.HELP_REQUEST:
                  // Help request logic
                  break;
                case AlarmType.FAVORITE_NEARBY_EVENT:
                  // Favorite nearby event logic
                  break;
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 26.0, right: 26),
            width: 212.w,
            height: 0.5,
            color: AppColors.lineGray, // Gray separator
          );
        },
      ),
    );
  }
}

AlarmType getAlarmType(String notificationType) {
  switch (notificationType) {
    case 'FAVORITE_REQUEST':
      return AlarmType.FAVORITE_REQUEST;
    case 'NEARBY_EVENT':
      return AlarmType.NEARBY_EVENT;
    case 'HELP_REQUEST':
      return AlarmType.HELP_REQUEST;
    case 'FAVORITE_NEARBY_EVENT':
      return AlarmType.FAVORITE_NEARBY_EVENT;
    default:
      throw Exception('Unknown AlarmType: $notificationType');
  }
}
