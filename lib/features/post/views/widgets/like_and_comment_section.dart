import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/shared/widgets/custom_animated_scale.dart';

class LikeAndCommentSection extends ConsumerWidget {
  final Post post;

  const LikeAndCommentSection({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAnimatedScaleUp(
              duration: 120,
              onTap: () async {
                await ref
                    .read(postViewModelProvider(post.postId).notifier)
                    .toggleLike(post.postId);

                ref.refresh(postByIdProvider(post.postId));
              },
              child: Image.asset(
                post.isLiked
                    ? 'assets/icons/post/Heart1.png'
                    : 'assets/icons/post/Heart2.png',
                width: 25,
                height: 25,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${post.likesCount}',
              style: const TextStyle(fontSize: 13, height: 1.2),
            ),
          ],
        ),
        const SizedBox(width: 14),
        // const Icon(Icons.comment),
        Image.asset(
          'assets/icons/post/Chat.png',
          width: 27,
          height: 27,
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
