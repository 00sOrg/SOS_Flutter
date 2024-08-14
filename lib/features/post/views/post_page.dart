import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'widgets/profile_section.dart';
import 'widgets/image_section.dart';
import 'widgets/content_section.dart';
import 'widgets/like_and_comment_section.dart';
import 'package:sos/features/post/views/widgets/post_badge.dart';
//import 'widgets/comment_block.dart';
import '../viewmodels/comment_list.dart';

class PostPage extends ConsumerWidget {
  final String id; // 게시글 ID를 받는 변수

  const PostPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 특정 ID로 PostViewModel을 불러오는 코드 (Provider에서 가져옴)
    final postViewModel = ref.watch(postByIdProvider(id));

    // 만약 해당 ID에 대한 게시글이 없다면 에러 표시
    if (postViewModel == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('게시글을 찾을 수 없습니다'),
        ),
        body: const Center(
          child: Text('해당 게시글이 존재하지 않습니다.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(postViewModel.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true, // 추가: ListView가 부모의 크기에 맞추어 조정됩니다.
        physics: const ClampingScrollPhysics(), // 추가: 기본 스크롤 물리 적용
        children: [
          // "실시간!!" Badge
          const PostBadge(text: '실시간!!', color: Colors.blue),

          const SizedBox(height: 8),

          // Profile Section (사용자 정보 및 날짜)
          ProfileSection(viewModel: postViewModel),

          const SizedBox(height: 16),

          // Image Section (게시글에 포함된 이미지)
          ImageSection(viewModel: postViewModel),

          const SizedBox(height: 16),

          // Content Section (게시글 내용)
          ContentSection(viewModel: postViewModel),

          const SizedBox(height: 16),

          // Likes and Comments Section (좋아요 및 댓글 수)
          LikeAndCommentSection(viewModel: postViewModel),

          const SizedBox(height: 16),

          // Comments List (댓글 리스트)
          // CommentList(), // CommentList는 더미 데이터로 댓글 표시
        ],
      ),
    );
  }
}
