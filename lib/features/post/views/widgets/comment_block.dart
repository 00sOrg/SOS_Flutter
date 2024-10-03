import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/shared/models/comment.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/format_date_time.dart';

class CommentBlock extends ConsumerWidget {
  final Comment comment;
  final int currentUserId;
  final int postId; // 게시글 ID 추가

  const CommentBlock({
    super.key,
    required this.comment,
    required this.currentUserId,
    required this.postId, // 게시글 ID 추가
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
        border: const Border(
          bottom: BorderSide(
            color: AppColors.lineGray, // 테두리 색상
            width: 1, // 테두리 두께
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 정렬을 왼쪽 정렬로 수정
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // 위로 정렬
            children: [
              Container(
                padding: const EdgeInsets.all(2), // 테두리 두께 설정
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // 원형 모양 유지
                  border: Border.all(
                    color: AppColors.lightBlue, // 테두리 색상 설정 (파란색)
                    width: 3, // 테두리 두께 설정
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
              Expanded(
                child: Column(
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
                ),
              ),
              // 댓글 작성자와 현재 사용자가 같을 때만 옵션 아이콘 표시
              if (comment.userId == currentUserId)
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.textGray),
                  onPressed: () {
                    _showOptions(context, ref, comment.commentId);
                  },
                ),
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
        ],
      ),
    );
  }

// 옵션 아이콘을 눌렀을 때의 동작
  void _showOptions(BuildContext context, WidgetRef ref, int commentId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('수정'),
                onTap: () {
                  Navigator.of(context).pop();
                  // 댓글 수정 로직
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('삭제'),
                onTap: () async {
                  Navigator.of(context).pop();
                  // 댓글 삭제 로직
                  final postViewModel =
                      ref.read(postViewModelProvider(postId).notifier);
                  await postViewModel.deleteComment(postId, commentId);

                  // 댓글 삭제 후 새로고침
                  ref.refresh(postByIdProvider(postId)); // 댓글 삭제 후 상태 새로고침
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
