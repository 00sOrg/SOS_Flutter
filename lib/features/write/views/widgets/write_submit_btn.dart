import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_animated_scale.dart';

class WriteSubmitBtn extends StatelessWidget {
  final VoidCallback onTap;

  const WriteSubmitBtn({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedScaleDown(
      onTap: onTap,
      scaleValue: 0.99,
      duration: 90,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          '등록하기',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
