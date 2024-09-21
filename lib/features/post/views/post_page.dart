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
    final postAsync = ref.watch(postByIdProvider(postId));
    final postViewModel = ref.watch(postViewModelProvider(postId).notifier);

    return Scaffold(
      appBar: CustomAppBar(title: '${postAsync.value?.title ?? ''}'),
      body: postAsync.when(
        data: (post) {
          if (post == null) {
            return const Center(child: Text('No post found'));
          }
          return Stack(
            children: [
              RefreshIndicator.adaptive(
                onRefresh: () async {
                  await postViewModel.refreshPost(postId);
                },
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(25, 18.0, 25, 80.0),
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
                    const SizedBox(height: 40),
                    LikeAndCommentSection(post: post),
                    CommentSection(comments: post.comments),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CommentWriteSection(postId: post.postId),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
