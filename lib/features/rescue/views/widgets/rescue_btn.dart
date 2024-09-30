import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 108,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              color: AppColors.black.withOpacity(0.25),
              blurRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            height: 1.2,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
