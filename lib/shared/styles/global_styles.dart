import 'package:flutter/material.dart';

class AppColors {
  static const Color blue = Color(0xFF0066FF);
  static const Color lineGray = Color(0xFFE9E9E9);
  static const Color textGray = Color(0xFFB6B6B6);
  static const Color red = Color(0xFFFF0000);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}

class AppTexts {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFF000000),
    height: 1.2,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Color(0xFF000000),
    height: 1.2,
  );
}

class AppBorders {
  static final OutlineInputBorder defaultBlueBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFF0066FF), width: 3),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder thinGrayBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFE9E9E9), width: 1),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder thinBlackBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFA9A9A9), width: 1),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFED4337), width: 1),
    borderRadius: BorderRadius.circular(10),
  );
}
