import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/models/comment.dart';
import 'package:sos/shared/utils/format_date_time.dart';

class CommentBlock extends StatelessWidget {
  final Comment comment;

  const CommentBlock({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 정렬을 왼쪽 정렬로 수정
        children: [
          Row(
            children: [
              // 댓글 작성자의 프로필 사진을 원형으로 표시
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: comment.profilePic != null
                    ? Image.network(
                        comment.profilePic!,
                        width: 32,
                      )
                    : SvgPicture.asset(
                        'assets/icons/default_profile_icon.svg',
                        width: 32,
                      ),
              ),
              const SizedBox(width: 9),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 댓글 작성자의 이름 표시
                  Text(
                    comment.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // 댓글 작성 시간 표시
                  Text(
                    formatDateTime(comment.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB9B9B9),
                      fontFamily: 'Apple SD Gothic Neo',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 4),
          // 댓글 내용 표시
          Text(
            comment.content,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Apple SD Gothic Neo',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          )
        ],
      ),
    );
  }
}
