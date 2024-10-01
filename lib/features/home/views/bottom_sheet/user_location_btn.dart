import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class UserLocationBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;

  const UserLocationBtn({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: ShapeDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0), // 중앙에서 시작
            radius: 1.0, // 그라데이션 반경 설정
            colors: [
              AppColors.white,
              AppColors.lineGray,
            ],
          ),
          shape: OvalBorder(),
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
