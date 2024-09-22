import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentWriteSection extends ConsumerStatefulWidget {
  final int postId; // Accept postId as a parameter

  const CommentWriteSection({super.key, required this.postId});

  @override
  _CommentWriteSectionState createState() => _CommentWriteSectionState();
}

class _CommentWriteSectionState extends ConsumerState<CommentWriteSection> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(16, 11, 13, 25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
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
              color: AppColors.blue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                icon: const Icon(Icons.send, color: AppColors.white),
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
                    });
                  } else {
                    debugPrint('Comment is empty');
                  }
                }),
          ),
        ],
      ),
    );
  }
}
