import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';

class UserProfileSection extends StatelessWidget {
  final Post post;

  const UserProfileSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                child: Image.asset(
                  'assets/images/default_profile.png',
                  width: 30,
                ),
              ),
        const SizedBox(width: 8.0),
        Text(
          post.userNickname ?? 'Unknown User',
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontFamily: 'Apple SD Gothic Neo',
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
