import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_animated_scale.dart';


class FriendHelpBtn extends StatelessWidget {
  final double radius;
  final Friend friend;
  final VoidCallback onTap;

  const FriendHelpBtn({
    super.key,
    required this.friend,
    required this.onTap,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedScaleDown(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppColors.finalGray,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2.5, 2.5),
              color: AppColors.textGray.withOpacity(0.5),
              blurRadius: 3.8,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 13), // 24,9,24,13
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 32.w,
              backgroundImage: (friend.profilePicture != null &&
                      friend.profilePicture!.isNotEmpty)
                  ? NetworkImage(friend.profilePicture!)
                  : const AssetImage('assets/images/default_profile.png')
                      as ImageProvider,
            ),
            Text(
              '''${friend.modifiedNickname}\n 주변 도움 요청''',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.black,
                fontSize: 15,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
