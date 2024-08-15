import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';

class LikeAndCommentSection extends StatelessWidget {
  final Post post; // Use the Post class generated by freezed

  const LikeAndCommentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite_border),
        const SizedBox(width: 8.0),
        Text('${post.likesCount}'), // 좋아요 수
        const SizedBox(width: 16.0),
        const Icon(Icons.comment),
        const SizedBox(width: 8.0),
        Text('${post.commentsCount}'), // 댓글 수
      ],
    );
  }
}
