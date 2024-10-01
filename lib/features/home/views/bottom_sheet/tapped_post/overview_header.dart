import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/format_date_time.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class OverviewHeader extends StatelessWidget {
  final String? profilePictureURL;
  final String title;
  final String roadAddress;
  final DateTime createdAt;

  const OverviewHeader({
    super.key,
    this.profilePictureURL,
    required this.title,
    required this.roadAddress,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        profilePictureURL != null && profilePictureURL!.isNotEmpty
            ? CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(profilePictureURL!),
              )
            : CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.lineGray,
                child: Image.asset(
                  'assets/images/default_profile.png',
                  width: 30,
                ),
              ),
        const SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 1.0),
            Text(
              roadAddress,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 1.0),
            Text(
              '${formatDateTime(createdAt)} (${formatTimeAgo(createdAt)})',
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
