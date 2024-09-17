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
            children: [
              Icon(Icons.favorite,
                  color: post.isLiked ? AppColors.red : AppColors.textGray),
              const SizedBox(width: 4.0),
              Text('${post.likesCount}'),
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
