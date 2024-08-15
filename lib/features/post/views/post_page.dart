import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'widgets/profile_section.dart';
import 'widgets/image_section.dart';
import 'widgets/content_section.dart';
import 'widgets/like_and_comment_section.dart';
import 'widgets/comment_section.dart';
import 'package:sos/features/post/views/widgets/post_badge.dart';

class PostPage extends ConsumerWidget {
  final int postId; // 게시글 ID를 받는 변수

  const PostPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 특정 ID로 Post를 불러오는 코드 (Provider에서 가져옴)
    final post = ref.watch(postByIdProvider(postId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(post.title), // Post의 제목 사용
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // "실시간!!" Badge
          const PostBadge(text: '실시간!!', color: Colors.blue),

          const SizedBox(height: 8),

          // Profile Section (사용자 정보 및 날짜)
          ProfileSection(post: post), // Post 객체 전달

          const SizedBox(height: 16),

          // Image Section (게시글에 포함된 이미지)
          ImageSection(post: post), // Post 객체 전달

          const SizedBox(height: 16),

          // Content Section (게시글 내용)
          ContentSection(post: post), // Post 객체 전달

          const SizedBox(height: 16),

          // Likes and Comments Section (좋아요 및 댓글 수)
          LikeAndCommentSection(post: post), // Post 객체 전달

          const SizedBox(height: 16),

          // Comments List (댓글 리스트)
          CommentSection(comments: post.comments),
          //CommentList(comments: post.comments), // 댓글 목록 전달
        ],
      ),
    );
  }
}
