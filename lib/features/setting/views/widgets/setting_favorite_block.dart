import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingFavoriteBlock extends StatelessWidget {
  final int id;
  final String content;
  final VoidCallback onSlide;

  const SettingFavoriteBlock({
    super.key,
    required this.id,
    required this.content,
    required this.onSlide,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 20;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Dismissible(
        key: Key(id.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onSlide();
        },
        background: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: AppColors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            // color: const Color(0xFFF3F3F3),
            color: Colors.green,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Text(
            content,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
