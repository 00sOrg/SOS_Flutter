import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/format_date_time.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class HeaderSection extends StatelessWidget {
  final Post post;

  const HeaderSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 18,
          // Assuming post has a profileImageUrl or similar field
          backgroundImage: post.mediaUrl != null && post.mediaUrl!.isNotEmpty
              ? NetworkImage(post.mediaUrl!)
              : null, // Provide a fallback or placeholder if needed
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              post.roadAddress ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${formatDateTime(post.createdAt)} (${formatTimeAgo(post.createdAt)})',
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
