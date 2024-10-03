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
                Container(
                  decoration: BoxDecoration(
                    color: getTagColor(post.disasterType!), // 이벤트 타입에 따른 배경색
                    gradient: LinearGradient(
                      colors: [
                        getTagColor(post.disasterType!)
                            .withOpacity(0.9), // 진한 색
                        getTagColor(post.disasterType!)
                            .withOpacity(0.6), // 연한 색
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.8),
                        spreadRadius: 8, // 그림자 크기를 넓게
                        blurRadius: 10, // 그림자를 더 흐리게
                        offset: const Offset(0, 15), // 그림자가 더 아래로 멀리 떨어지도록
                      ),
                    ],
                  ),
                ),
                RefreshIndicator.adaptive(
                  onRefresh: () async {
                    await postViewModel.refreshPost(postId);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    decoration: const BoxDecoration(
                      color: AppColors.white, // 배경색 설정
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20), // 왼쪽 상단 모서리 둥글게
                        topRight: Radius.circular(20), // 오른쪽 상단 모서리 둥글게
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4), // 살짝 떠 있는 효과
                        ),
                      ],
                    ),
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
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CommentWriteSection(
                      postId: post.postId, postType: post.disasterType!),
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
                      decoration: const ShapeDecoration(
                        color: AppColors.white,
                        shape: OvalBorder(),
                        shadows: [
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
