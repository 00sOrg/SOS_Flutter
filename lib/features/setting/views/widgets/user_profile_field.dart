import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/user_viewmodel.dart';

class UserProfileField extends ConsumerWidget {
  final VoidCallback onPressed;

  const UserProfileField({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userViewModelProvider를 구독하여 사용자 정보를 가져옴
    final user = ref.watch(userViewModelProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), // 상하 패딩 추가
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // 프로필 사진
          Container(
            padding: const EdgeInsets.all(2), // 테두리 두께 설정
            decoration: BoxDecoration(
              shape: BoxShape.circle, // 원형 모양 유지
              border: Border.all(
                color: AppColors.lightBlue, // 테두리 색상 설정 (파란색)
                width: 3, // 테두리 두께 설정 (2짜리)
              ),
            ),
            child: user!.profilePicture != null &&
                    user.profilePicture!.isNotEmpty
                ? CircleAvatar(
                    radius: 40, // 프로필 사진 크기
                    backgroundImage: NetworkImage(user.profilePicture!),
                    backgroundColor: Colors.grey[200], // 백그라운드 색상 (이미지 없는 경우)
                  )
                : CircleAvatar(
                    radius: 40, // 프로필 사진 크기
                    backgroundColor: Colors.grey[200], // 백그라운드 색상
                    child: Image.asset(
                      'assets/images/default_profile.png', // 기본 프로필 이미지
                      width: 64,
                      height: 64,
                    ),
                  ),
          ),

          const SizedBox(width: 15), // 이미지와 텍스트 사이의 간격

          // 유저 이름과 닉네임을 포함한 Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 텍스트를 좌측 정렬
              children: [
                // 유저 이름
                Text(
                  user.name ?? 'Unknown',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2), // 이름과 닉네임 사이의 간격
                // 닉네임
                Text(
                  user.nickname ?? 'Nickname',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          // 오른쪽에 IconButton 추가
          Transform.translate(
            offset: const Offset(0, 10), // 아이콘을 10픽셀 아래로 이동
            child: IconButton(
              icon: Image.asset(
                'assets/icons/setting/Edit.png',
                height: 50,
                width: 50,
              ), // 프로필 수정 아이콘
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}
