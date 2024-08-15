import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';

class ImageSection extends StatelessWidget {
  final Post post; // Use the Post class generated by freezed

  const ImageSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return post.media != null && post.media!.isNotEmpty
        ? Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(post.media!),
                fit: BoxFit.cover,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}