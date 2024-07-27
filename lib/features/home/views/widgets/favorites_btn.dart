import 'package:flutter/material.dart';

class FavoritesBtn extends StatelessWidget {
  final VoidCallback onTap;

  const FavoritesBtn({super.key, required this.onTap});

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
      ),
    );
  }
}
