import 'package:flutter/material.dart';
import 'package:sos/shared/models/comment.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/format_date_time.dart';

class CommentBlock extends StatelessWidget {
  final Comment comment;

  const CommentBlock({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 정렬을 왼쪽 정렬로 수정
      children: [
        const SizedBox(height: 17),
        Row(
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
              child: comment.userProfilePictureURL != null &&
                      comment.userProfilePictureURL!.isNotEmpty
                  ? CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          NetworkImage(comment.userProfilePictureURL!),
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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userNickname,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  formatDateTime(comment.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGray,
                    fontFamily: 'Apple SD Gothic Neo',
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 11),
        // 댓글 내용 표시
        Text(
          comment.content,
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontFamily: 'Apple SD Gothic Neo',
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
