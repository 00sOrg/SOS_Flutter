import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';
import 'package:sos/features/post/views/widgets/comment_write_section.dart';
import 'package:sos/features/post/views/widgets/emergency_respose_popup.dart';
import 'package:sos/features/post/views/widgets/user_profile_section.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/styles/global_styles.dart';
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

    return KeyboardDismisser(
      child: Scaffold(
        appBar: CustomAppBar(
          title: '게시글',
          onTapLeading: () => GoRouter.of(context).pop(),
        ),
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
                    // padding: const EdgeInsets.fromLTRB(20, 18, 20, 80),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                        child: Column(
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
                            const SizedBox(height: 13),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.lineGray,
                      ),
                      CommentSection(comments: post.comments),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CommentWriteSection(postId: post.postId),
                ),
                Positioned(
                  right: 20, // 오른쪽 여백
                  bottom: 130, // 버튼의 세로 위치
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EmergencyResponse(
                            eventType:
                                getPostTypeFromString(post.disasterType!),
                          ); // PostType에 맞는 팝업 호출
                        },
                      );
                    },
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: const OvalBorder(),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 5,
                            offset: Offset(2, 1),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/home/F-Megaphone.png', // 아이콘 경로
                          width: 44, // 아이콘 크기 설정
                          height: 44,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
