import 'package:flutter/material.dart';

class BorderStyles {
  static final OutlineInputBorder defaultBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFD6D6D6), width: 1),
    borderRadius: BorderRadius.circular(8),
  );

    static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFED4337), width: 1),
    borderRadius: BorderRadius.circular(8),
  );
}