import 'package:flutter/material.dart';
import 'package:sos/features/x_archive/deprecated_board/views/widgets/post_item.dart';
import 'package:sos/shared/models/x_post.dart';

class PostGridArea extends StatelessWidget {
  final List<XPost> posts;

  const PostGridArea({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    final reversedPosts = List<XPost>.from(posts.reversed);

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 6.1 / 7,
        ),
        itemCount: reversedPosts.length,
        itemBuilder: (context, idx) => PostItem(post: reversedPosts[idx]),
      ),
    );
  }
}
