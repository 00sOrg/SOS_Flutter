import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/models/post.dart';

class PostBadge extends StatelessWidget {
  final Post post;

  const PostBadge({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // Determine the svg asset based on the post's data
    String? svgAsset;

    // Condition for Hot! badge
    if (post.likesCount > 100) {
      svgAsset = 'assets/icons/post/HOT.svg';
    }
    // Condition for 실시간!! badge
    else if (_isRecentPost(post.createdAt)) {
      svgAsset = 'assets/icons/post/LIVE.svg';
    }

    // If neither condition is met, return an empty container
    if (svgAsset == null) {
      return const SizedBox
          .shrink(); // Empty space, won't take up any space in the layout
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: SvgPicture.asset(
        svgAsset,
        height: 22.38.h, // Adjust the size as needed
        width: 57.w,
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
