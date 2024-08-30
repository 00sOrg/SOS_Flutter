import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLength;
  final bool obscureText;

  const LoginTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.maxLength,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: AppColors.textGray,
            height: 1.25,
          ),
          border: AppBorders.defaultBlueBorder,
          enabledBorder: AppBorders.defaultBlueBorder,
          focusedBorder: AppBorders.defaultBlueBorder,
          counterText: "",
        ),
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.black,
          height: 1.25,
        ),
      ),
    );
  }
}
