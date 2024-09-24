import 'package:flutter/material.dart';
import 'package:sos/shared/models/comment.dart';
import 'package:sos/features/post/views/widgets/comment_block.dart';

class CommentSection extends StatelessWidget {
  final List<Comment>? comments;

  const CommentSection({super.key, this.comments});

  @override
  Widget build(BuildContext context) {
    // comments가 null이거나 비어있으면 빈 SizedBox를 반환
    if (comments == null || comments!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.separated(
        shrinkWrap: true, // 부모 위젯의 크기에 맞게 조정
        physics: const NeverScrollableScrollPhysics(), // 외부 스크롤에 따라가도록 설정
        itemCount: comments!.length,
        itemBuilder: (context, index) {
          final comment = comments![index];
          return CommentBlock(comment: comment);
        },
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.5,
          height: 1,
        ),
      ),
    );
  }
}
