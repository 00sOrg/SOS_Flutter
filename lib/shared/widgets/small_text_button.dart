import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SmallTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? buttonColor;
  final double? width;
  final double? height;

  const SmallTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor = AppColors.white,
    this.buttonColor = AppColors.blue,
    this.width = 78,
    this.height = 27,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
