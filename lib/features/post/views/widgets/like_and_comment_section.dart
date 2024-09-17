import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';

class LikeAndCommentSection extends ConsumerWidget {
  final Post post;

  const LikeAndCommentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLiked = post.isLiked; // Track if the post is liked or not

    return Row(
      children: [
        GestureDetector(
          onTap: () =>
              ref.read(postViewModelProvider.notifier).toggleLike(post.postId),
          child: Row(
            children: [
              Icon(Icons.favorite, color: isLiked ? Colors.red : Colors.grey),
              const SizedBox(width: 4.0),
              Text('${post.likesCount}'), // Show the likes count
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        const Icon(Icons.comment),
        const SizedBox(width: 4.0),
        Text('${post.commentsCount}'), // Show the comments count
      ],
    );
  }
}
