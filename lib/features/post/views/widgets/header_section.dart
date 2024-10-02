import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/format_date_time.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class HeaderSection extends StatelessWidget {
  final Post post;

  const HeaderSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title!,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              post.roadAddress ?? '',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              '${formatDateTime(post.createdAt!)} (${formatTimeAgo(post.createdAt!)})',
              style: const TextStyle(
                color: AppColors.textGray,
                fontSize: 11,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
