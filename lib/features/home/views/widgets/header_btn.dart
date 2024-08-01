import 'package:flutter/material.dart';

class HeaderBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;

  const HeaderBtn({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF0066FF).withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon
        ),
      ),
    );
  }
}
