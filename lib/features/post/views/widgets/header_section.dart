import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.userProfilePictureURL != null &&
                post.userProfilePictureURL!.isNotEmpty
            ? CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(post.userProfilePictureURL!),
              )
            : CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.lineGray,
                child: SvgPicture.asset(
                  'assets/icons/default_profile_icon.svg',
                  width: 20, // Adjust the size of the icon
                  height: 20,
                ),
              ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              post.roadAddress ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${formatDateTime(post.createdAt)} (${formatTimeAgo(post.createdAt)})',
              style: const TextStyle(
                color: Colors.black,
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
