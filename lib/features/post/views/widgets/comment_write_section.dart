import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class CommentWriteSection extends ConsumerStatefulWidget {
  final int postId;
  final String postType;

  const CommentWriteSection(
      {super.key, required this.postId, required this.postType});

  @override
  ConsumerState<CommentWriteSection> createState() =>
      _CommentWriteSectionState();
}

class _CommentWriteSectionState extends ConsumerState<CommentWriteSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final buttonColor = getTagColor(widget.postType);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            color: AppColors.black.withOpacity(0.20),
            blurRadius: 3,
            spreadRadius: 4,
          ),
        ],
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(20), // 왼쪽 상단 모서리 둥글게
        //   topRight: Radius.circular(20), // 오른쪽 상단 모서리 둥글게
        // ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 13, 14),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '댓글을 추가하세요',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.lineGray,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                color: buttonColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  icon: Image.asset(
                    'assets/icons/post/Send.png',
                  ),
                  onPressed: () {
                    final comment = _controller.text;
                    if (comment.isNotEmpty) {
                      ref
                          .read(postViewModelProvider(widget.postId).notifier)
                          .addCommentToPost(widget.postId, comment)
                          .then((_) {
                        // Clear the comment field
                        _controller.clear();
                        // Refresh the post to show the new comment
                        ref.refresh(postByIdProvider(widget.postId));
                        FocusScope.of(context).unfocus();
                      });
                    } else {
                      debugPrint('Comment is empty');
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
