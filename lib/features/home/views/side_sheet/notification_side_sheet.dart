import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/home/viewmodels/alarm_viewmodel.dart';
import 'package:sos/features/home/viewmodels/user_viewmodel.dart';
import 'package:sos/features/home/views/side_sheet/alarm_list.dart';
import 'package:sos/shared/styles/global_styles.dart';

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
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            child: Container(
              width: 262,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (user != null)
                          Text(
                            '${user.nickname}님',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
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

                  Center(
                    child: Container(
                      width: 212.w,
                      color: Colors.grey.withOpacity(0.5), // 회색 구분선
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // 알림 리스트
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
