import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

SnackBar customSnackBar({
  required String text,
  Color? backgroundColor,
  int? duration,
  bool? showCloseIcon,
}) {
  return SnackBar(
    content: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    backgroundColor: backgroundColor ?? AppColors.red.withOpacity(0.88),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.fromLTRB(20, 20, 20, 6),
    clipBehavior: Clip.none,
    elevation: 4,
    duration: const Duration(milliseconds: 3000),
    showCloseIcon: true,
  );
}
