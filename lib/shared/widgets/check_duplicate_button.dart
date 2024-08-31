import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class CheckDuplicateButton extends StatelessWidget {
  final VoidCallback onTap;

  const CheckDuplicateButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blue, width: 1),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Text(
          '중복확인',
          style: TextStyle(
            color: AppColors.blue,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
