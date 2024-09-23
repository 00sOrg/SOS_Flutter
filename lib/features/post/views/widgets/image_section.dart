import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';

class ImageSection extends StatelessWidget {
  final Post post;

  const ImageSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return post.mediaURL != null && post.mediaURL!.isNotEmpty
        ? Image.network(
            post.mediaURL!,
            fit: BoxFit.contain,
            width: double.infinity,
          )
        : const SizedBox.shrink();
  }
}
