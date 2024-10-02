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
          gradient: LinearGradient(
            colors: [
              Colors.grey[300]!,
              AppColors.finalGray,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            // 그림자 추가 (입체감 주는 효과)
            BoxShadow(
              offset: const Offset(4, 4), // 그림자 위치
              color: Colors.black.withOpacity(0.15), // 그림자 색상 및 투명도
              blurRadius: 10, // 그림자 흐림 효과
            ),
            BoxShadow(
              offset: const Offset(-4, -4), // 반대 방향 그림자
              color: Colors.white.withOpacity(0.6), // 그림자 색상 및 투명도
              blurRadius: 10, // 흐림 효과
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 13), // 내부 패딩 설정
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              child: CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 32.w, // 프로필 이미지 크기
                backgroundImage: (friend.profilePicture != null &&
                        friend.profilePicture!.isNotEmpty)
                    ? NetworkImage(friend.profilePicture!)
                    : const AssetImage('assets/images/default_profile.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 8), // 텍스트와 이미지 사이에 여백 추가
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
