import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendHelpBtn extends StatelessWidget {
  final int id;
  final String name;
  final String? profilePicture;

  const FriendHelpBtn({
    super.key,
    required this.id,
    required this.name,
    this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: id == -1
          ? () {
              // 친구 추가 버튼 눌렸을 때 실행될 로직
              debugPrint('친구 추가 버튼 클릭');
            }
          : null,
      child: Container(
        height: 145.h,
        width: 157.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: id == -1 ? Colors.green.shade200 : Colors.amber.shade200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            id == -1
                ? Icon(Icons.add, size: 50.w) // 친구 추가 버튼 UI
                : (profilePicture != null
                    ? Image.network(profilePicture!, height: 50.w) // 친구 프로필 이미지
                    : SvgPicture.asset('assets/icons/default_profile_icon.svg',
                        height: 50.w)), // 기본 아이콘
            if (id != -1) // 친구가 있을 때만 텍스트 표시
              SizedBox(height: 6.h),
            if (id != -1) // 친구가 있을 때만 텍스트 표시
              Text(
                '$name 주변 도움 요청',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
