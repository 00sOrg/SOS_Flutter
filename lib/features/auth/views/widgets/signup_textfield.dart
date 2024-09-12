import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SignupTextfield extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final int maxLength;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final int maxLines;
  final int minLines;

  const SignupTextfield({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.maxLength,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        onChanged: onChanged,
        autocorrect: false,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        minLines: minLines,
        cursorColor: AppColors.blue,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTexts.bodyStyle.copyWith(color: AppColors.textGray),
          border: AppBorders.thinGrayBorder,
          enabledBorder: AppBorders.thinGrayBorder,
          focusedBorder: AppBorders.thinGrayBorder,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          counterText: "",
        ),
        style: AppTexts.bodyStyle,
      ),
    );
  }
}
