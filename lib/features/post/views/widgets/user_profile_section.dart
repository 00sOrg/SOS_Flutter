import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';

class UserProfileSection extends StatelessWidget {
  final Post post;

  const UserProfileSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2), // 테두리 두께 설정
          decoration: BoxDecoration(
            shape: BoxShape.circle, // 원형 모양 유지
            border: Border.all(
              color: AppColors.lightBlue, // 테두리 색상 설정 (파란색)
              width: 3, // 테두리 두께 설정 (2짜리)
            ),
          ),
          child: post.userProfilePictureURL != null &&
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
        ),
        const SizedBox(width: 10.0),
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
