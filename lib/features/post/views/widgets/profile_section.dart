import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/format_date_time.dart';

class ProfileSection extends StatelessWidget {
  final Post post;

  const ProfileSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.0,
          // Assuming post has a profileImageUrl or similar field
          backgroundImage: post.media != null && post.media!.isNotEmpty
              ? NetworkImage(post.media!)
              : null, // Provide a fallback or placeholder if needed
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${formatDateTime(post.createdAt)} · ${post.city}, ${post.gu}', // Adjust this to match your actual data
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
