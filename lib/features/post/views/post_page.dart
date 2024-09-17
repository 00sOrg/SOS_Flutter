import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/features/post/views/widgets/comment_write_section.dart';
import 'package:sos/features/post/views/widgets/user_profile_section.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';
import 'widgets/header_section.dart';
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
      appBar: CustomAppBar(title: post.title),
      body: Stack(
        children: [
          // Content scrollable area
          ListView(
            padding: const EdgeInsets.fromLTRB(31.0, 18.0, 31.0, 80.0),
            children: [
              PostBadge(post: post),
              const SizedBox(height: 2),
              HeaderSection(post: post),
              const SizedBox(height: 14),
              UserProfileSection(post: post),
              const SizedBox(height: 8),
              ImageSection(post: post),
              const SizedBox(height: 16),
              ContentSection(post: post),
              const SizedBox(height: 19),
              LikeAndCommentSection(post: post),
              CommentSection(comments: post.comments),
            ],
          ),

          // Fixed comment bar at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
                const CommentWriteSection(), // Use the CommentWriteSection here
          ),
        ],
      ),
    );
  }
}
