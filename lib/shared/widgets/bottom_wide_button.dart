import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BottomWideButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BottomWideButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.blue, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(15),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
