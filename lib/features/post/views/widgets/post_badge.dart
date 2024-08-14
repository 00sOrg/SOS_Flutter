import 'package:flutter/material.dart';

class PostBadge extends StatelessWidget {
  final String text;
  final Color color;

  const PostBadge({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
