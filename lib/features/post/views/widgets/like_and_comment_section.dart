import 'package:flutter/material.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';

class LikeAndCommentSection extends StatelessWidget {
  final PostViewModel viewModel;

  const LikeAndCommentSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.favorite_border),
        const SizedBox(width: 8.0),
        Text('${viewModel.likes}'), // 좋아요 수
        const SizedBox(width: 16.0),
        const Icon(Icons.comment),
        const SizedBox(width: 8.0),
        Text('${viewModel.comments}'), // 댓글 수
      ],
    );
  }
}
