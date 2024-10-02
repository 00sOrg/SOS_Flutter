import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_animated_scale.dart';

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
    return CustomAnimatedScaleDown(
      duration: 110,
      scaleValue: 0.96,
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: ShapeDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, 0), // 중앙에서 시작
            radius: 1.6, // 그라데이션 반경 설정
            colors: [AppColors.white, AppColors.blue],
          ),
          shape: const OvalBorder(),
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 3), // 그림자 위치
              blurRadius: 5, // 그림자 퍼짐
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.lightBlue.withOpacity(0.7), // 테두리 색상
              width: 2.0, // 테두리 두께
            ),
          ),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
