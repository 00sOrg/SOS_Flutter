import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/post/repositories/post_repository.dart';
import 'package:sos/shared/models/post.dart';

class PostViewModelNotifier extends StateNotifier<Post?> {
  final PostRepository _postRepository;

  PostViewModelNotifier(this._postRepository) : super(null);

  // 게시글 불러오기
  Future<Post?> getOnePostById(int id) async {
    final post = await _postRepository.getOnePostbyId(id);
    state = post; // Update the single post state
    return post;
  }

  // 좋아요 기능
  Future<void> toggleLike(int postId) async {
    if (state == null) return;

    // Optimistically update the state
    state = state!.copyWith(
      likesCount:
          state!.isLiked ? state!.likesCount - 1 : state!.likesCount + 1,
      isLiked: !state!.isLiked,
    );

    // Call the likePost function to notify the backend
    final success = await _postRepository.likePost(postId);

    // If the backend response does not match, revert the state
    if (state!.isLiked != success) {
      state = state!.copyWith(
        likesCount: success ? state!.likesCount + 1 : state!.likesCount - 1,
        isLiked: success,
      );
    }
  }

  // 댓글 추가 기능
  Future<void> addCommentToPost(int postId, String comment) async {
    final success = await _postRepository.addCommentToPost(postId, comment);
    if (success && state != null) {
      state = state!.copyWith(commentsCount: state!.commentsCount + 1);
    }
  }

  // 게시글 새로고침
  Future<void> refreshPost(int postId) async {
    state = await getOnePostById(postId);
  }

  // 게시글 삭제
  Future<void> deletePost(int postId) async {
    final success = await _postRepository.deletePostById(postId);
    if (success) {
      // 상태를 null로 설정하여 삭제된 게시글을 처리
      state = null;
    }
  }

  // 댓글 삭제
  Future<void> deleteComment(int postId, int commentId) async {
    final success = await _postRepository.deleteCommentById(commentId);
    if (success && state != null) {
      state = state!.copyWith(commentsCount: state!.commentsCount - 1);
    }
  }

  // 홈페이지로 이동
  void navigateToHome(BuildContext context) {
    GoRouter.of(context).go('/home');
  }
}

// Provider for PostViewModelNotifier managing a single Post
final postViewModelProvider =
    StateNotifierProvider.family<PostViewModelNotifier, Post?, int>(
        (ref, postId) {
  final postRepository = PostRepository();
  return PostViewModelNotifier(postRepository)..getOnePostById(postId);
});

// Provider for accessing a single post by ID using FutureProvider
final postByIdProvider = FutureProvider.family<Post?, int>((ref, postId) async {
  final postViewModel = ref.read(postViewModelProvider(postId).notifier);
  return postViewModel.getOnePostById(postId);
});
