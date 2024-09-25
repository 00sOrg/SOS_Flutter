import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HeaderBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;

  const HeaderBtn({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: ShapeDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0), // 중앙에서 시작
            radius: 1, // 그라데이션 반경 설정
            colors: [AppColors.white, AppColors.blue],
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
