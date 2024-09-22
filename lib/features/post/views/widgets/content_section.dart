import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';

class ContentSection extends StatelessWidget {
  final Post post;

  const ContentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Check if the content is null or empty
    if (post.content == null || post.content!.isEmpty) {
      return const SizedBox.shrink(); // If empty, return an empty widget
    }

    return Container(
      alignment: Alignment.topLeft,
      child: SizedBox(
        child: Text(
          textAlign: TextAlign.justify,
          post.content!,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
