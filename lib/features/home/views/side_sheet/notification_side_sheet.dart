import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/alarm_viewmodel.dart';
import 'package:sos/features/home/viewmodels/user_viewmodel.dart';
import 'package:sos/features/home/views/side_sheet/alarm_list.dart';

class NotificationSideSheet extends ConsumerStatefulWidget {
  const NotificationSideSheet({super.key});

  @override
  _NotificationSideSheetState createState() => _NotificationSideSheetState();
}

class _NotificationSideSheetState extends ConsumerState<NotificationSideSheet> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userViewModelProvider);
    final alarms = ref.watch(alarmViewModelProvider);

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(), // 바깥 영역을 누르면 닫기
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          right: _isVisible ? 0 : -262,
          top: 0,
          bottom: 0,
          child: Material(
            elevation: 16,
            child: Container(
              width: 262,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (user != null)
                          Text(
                            '${user.nickname} 님',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Apple SD Gothic Neo',
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        else
                          const Text('사용자 이름 불러오는 중...'),
                        const Icon(Icons.notifications),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  AlarmList(alarms: alarms, ref: ref), // 알림 리스트 표시
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showNotificationSideSheet(BuildContext context, WidgetRef ref) {
  ref.read(userViewModelProvider.notifier).loadUserInfo();

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: NotificationSideSheet(),
        ),
      );
    },
  );
}