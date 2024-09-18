import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/styles/global_styles.dart';

class FriendHelpBtn extends StatelessWidget {
  final Friend friend;
  final VoidCallback onTap;

  const FriendHelpBtn({
    super.key,
    required this.friend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.finalGray,
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              color: AppColors.black.withOpacity(0.20), // .25
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 13), // 24,9,24,13
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 32.w,
              child: (friend.profilePicture != null &&
                      friend.profilePicture!.isNotEmpty)
                  ? ClipOval(
                      child: Image.network(
                        friend.profilePicture!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/images/default_profile.png',
                      width: 76,
                    ),
            ),
            Text(
              '''${friend.modifiedNickname}\n 주변 도움 요청''',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                // fontSize: 14,
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
