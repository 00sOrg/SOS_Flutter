import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';

class PostBadge extends StatelessWidget {
  final Post post;

  const PostBadge({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Determine the text and color based on the post's data
    String? text;
    Color? color;

    // Condition for Hot! badge
    if (post.likesCount > 100) {
      // Adjust the threshold as needed
      text = 'Hot!';
      color = Colors.red;
    }
    // Condition for 실시간!! badge
    else if (_isRecentPost(post.createdAt)) {
      text = '실시간!!';
      color = Colors.blue;
    }

    // If neither condition is met, return an empty container
    if (text == null || color == null) {
      return SizedBox
          .shrink(); // Empty space, won't take up any space in the layout
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  // Helper function to check if the post is recent
  bool _isRecentPost(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    // 1시간 이내의 게시물
    return difference.inHours < 1;
  }
}
