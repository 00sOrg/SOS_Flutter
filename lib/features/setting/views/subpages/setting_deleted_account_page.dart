import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingDeletedAccountPage extends StatefulWidget {
  const SettingDeletedAccountPage({super.key});

  @override
  State<SettingDeletedAccountPage> createState() =>
      _SettingDeletedAccountPageState();
}

class _SettingDeletedAccountPageState extends State<SettingDeletedAccountPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        GoRouter.of(context).go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
          'assets/images/circle_check.svg',
          width: 114.w,
        ),
          const SizedBox(height: 43, width: double.infinity),
          const Text('계정 삭제 완료', style: AppTexts.titleStyle),
          const SizedBox(height: 26),
          const Text(
            '계정을 안전하게 삭제했습니다.',
            style: AppTexts.bodyStyle,
          )
        ],
      ),
    );
  }
}
