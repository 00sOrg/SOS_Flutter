import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class LikeAndCommentSection extends ConsumerWidget {
  final Post post;

  const LikeAndCommentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await ref
                .read(postViewModelProvider(post.postId).notifier)
                .toggleLike(post.postId);
        
            ref.refresh(postByIdProvider(post.postId));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: post.isLiked ? AppColors.red : AppColors.textGray,
              ),
              const SizedBox(width: 4),
              Text(
                '${post.likesCount}',
                style: const TextStyle(fontSize: 13, height: 1.2),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // const Icon(Icons.comment),
        const Text(
          '💬',
          style: TextStyle(fontSize: 19),
        ),
        const SizedBox(width: 4),
        Text(
          '${post.commentsCount}',
          style: const TextStyle(fontSize: 13, height: 1.2),
        ),
      ],
    );
  }
}
