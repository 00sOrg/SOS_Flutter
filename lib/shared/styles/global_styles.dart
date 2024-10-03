import 'package:flutter/material.dart';

class AppColors {
  // static const Color blue = Color(0xFF0066FF);
  static const Color blue = Color(0xFF518DE8);
  static const Color lightBlue = Color(0xFF8FBCFF);
  static const Color lineGray = Color(0xFFE9E9E9);
  static const Color textGray = Color(0xFFB6B6B6);
  static const Color finalGray = Color(0xFFF3F3F3);
  static const Color red = Color(0xFFFF0000);
  static const Color black = Color(0xFF1B1B1B);
  static const Color white = Color(0xFFFFFFFF);
}

class AppTexts {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    height: 1.2,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
    height: 1.2,
  );
}

class AppBorders {
  static final OutlineInputBorder thickBlueBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.blue, width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder thickGrayBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFB6B6B6), width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder thickLightBlueBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.lightBlue, width: 2),
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

  static final OutlineInputBorder thinErrorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFED4337), width: 1),
    borderRadius: BorderRadius.circular(10),
  );
}

Color getTagColor(String eventType) {
  switch (eventType) {
    case 'FIRE':
      return const Color(0xFFFF3535);
    case 'TYPHOON':
      return const Color(0xFFAA3DC2);
    case 'FLOOD':
      return const Color(0xFF0046AE);
    case 'WAR':
      return const Color(0xFF16AE0B);
    case 'EARTHQUAKE':
      return const Color(0xFFF28C2C);
    case 'CAR_ACCIDENT':
      return const Color(0xFF00A392);
    default:
      return const Color(0xFF6398E9);
  }
}

Color getTagColor2(String eventType) {
  switch (eventType) {
    case 'FIRE':
      return const Color.fromARGB(255, 255, 113, 113);
    case 'TYPHOON':
      return const Color.fromARGB(255, 210, 120, 230);
    case 'FLOOD':
      return const Color.fromARGB(255, 119, 168, 241);
    case 'WAR':
      return const Color.fromARGB(255, 147, 236, 140);
    case 'EARTHQUAKE':
      return const Color.fromARGB(255, 241, 180, 123);
    case 'CAR_ACCIDENT':
      return const Color.fromARGB(255, 71, 209, 196);
    default:
      return const Color.fromARGB(255, 157, 193, 246);
  }
}
