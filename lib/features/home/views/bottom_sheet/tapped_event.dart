import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class TappedEvent extends ConsumerWidget {
  final Post post;
  final ScrollController scrollController;

  const TappedEvent({
    Key? key,
    required this.post,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.all(16.0),
      children: [
        // 게시글 제목
        Text(
          post.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // 게시글 작성자와 작성 시간
        Row(
          children: [
            Text(
              post.postId.toString(),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatTimeAgo(post.createdAt),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 게시글 내용
        Text(
          post.content!,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
