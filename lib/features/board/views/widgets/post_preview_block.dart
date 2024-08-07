import 'package:flutter/material.dart';

class PostPreviewBlock extends StatelessWidget {
  final String post;

  const PostPreviewBlock({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF3F3F3),
            width: 1.0,
          ),
        ),
      ),
      child: Text(post),
    );
  }
}
