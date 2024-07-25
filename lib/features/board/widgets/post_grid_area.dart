import 'package:flutter/material.dart';
import 'package:nearhere/features/board/widgets/post_item.dart';
import 'package:nearhere/shared/models/post.dart';

class PostGridArea extends StatelessWidget {
  final List<Post> posts;

  const PostGridArea({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    final reversedPosts = List<Post>.from(posts.reversed);

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
