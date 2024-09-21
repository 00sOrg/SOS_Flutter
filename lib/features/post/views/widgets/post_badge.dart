import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/models/post.dart';

class PostBadge extends StatelessWidget {
  final Post post;

  const PostBadge({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // List to hold the badges that need to be displayed
    List<String> badges = [];

    // Condition for Hot! badge
    if (post.likesCount > 100) {
      badges.add('assets/icons/post/HOT.svg');
    }
    // Condition for 실시간!! badge
    if (_isRecentPost(post.createdAt!)) {
      badges.add('assets/icons/post/LIVE.svg');
    }

    // If no badges, return an empty container
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    // Display all badges in a row
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: badges
            .map((badge) => Padding(
                  padding: EdgeInsets.only(right: 8.w), // Space between badges
                  child: SvgPicture.asset(
                    badge,
                    height: 22.38.h,
                    width: 57.w,
                  ),
                ))
            .toList(),
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
