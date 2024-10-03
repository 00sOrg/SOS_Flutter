import 'package:flutter/cupertino.dart';
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
import 'package:sos/shared/viewmodels/user_viewmodel.dart';
import 'package:sos/shared/widgets/animated_button.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';
import '../../setting/views/widgets/setting_modal.dart';
import 'widgets/header_section.dart';
import 'widgets/image_section.dart';
import 'widgets/content_section.dart';
import 'widgets/like_and_comment_section.dart';
import 'widgets/comment_section.dart';
import 'package:sos/features/post/views/widgets/post_badge.dart';

class PostPage extends ConsumerStatefulWidget {
  final int postId;

  const PostPage({super.key, required this.postId});

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> {
  @override
  void initState() {
    super.initState();
    // 페이지가 로드될 때마다 새로고침
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(postViewModelProvider(widget.postId).notifier)
          .getOnePostById(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final postAsync = ref.watch(postByIdProvider(widget.postId));
    final postViewModel =
        ref.watch(postViewModelProvider(widget.postId).notifier);

    final user = ref.watch(userViewModelProvider);

    debugPrint('Current User ID: ${user.memberId}');

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
            final currentUserId = user.memberId;

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
                    await postViewModel.refreshPost(widget.postId);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                    decoration: const BoxDecoration(
                      color: AppColors.white, // 배경색 설정
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(60, 0, 0, 0),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(2, -4), // 살짝 떠 있는 효과
                        ),
                      ],
                    ),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                          child: Column(
                            children: [
                              PostBadge(post: post),
                              const SizedBox(height: 2),
                              HeaderSection(
                                post: post,
                                currentUserId: currentUserId,
                                onDelete: () async {
                                  final shouldDelete =
                                      await _showDeleteConfirmation(context);
                                  if (shouldDelete) {
                                    await postViewModel
                                        .deletePost(widget.postId);
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                              const SizedBox(height: 10),
                              UserProfileSection(post: post),
                              const SizedBox(height: 12),
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
                          thickness: 4,
                          color: AppColors.lineGray,
                        ),
                        CommentSection(
                          comments: post.comments,
                          currentUserId: currentUserId,
                          postId: post.postId,
                        ),
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
                  right: 20,
                  bottom: 130,
                  child: AnimatedButton(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EmergencyResponse(
                            eventType:
                                getPostTypeFromString(post.disasterType!),
                          );
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
                          'assets/icons/home/F-Megaphone.png',
                          width: 44,
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

  Future<bool> _showDeleteConfirmation(BuildContext context) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return SettingModal(
              title: '게시글 삭제',
              content: '정말로 이 게시글을 삭제하시겠습니까?',
              leftBtn: '취소',
              rightBtn: '삭제',
              rightBtnColor: Colors.red,
              onRightBtnPressed: () {
                Navigator.of(context).pop(true);
              },
            );
          },
        ) ??
        false;
  }
}
