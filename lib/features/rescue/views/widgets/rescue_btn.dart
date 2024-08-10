import 'dart:ffi';

import 'package:flutter/material.dart';

class RescueBtn extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onTap;

  const RescueBtn({
    super.key,
    required this.text,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double rad = 10;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(rad),
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(rad),
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
