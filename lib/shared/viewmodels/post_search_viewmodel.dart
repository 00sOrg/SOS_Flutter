import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/post/repositories/post_repository.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/log_util.dart';

class PostSearchViewModel extends StateNotifier<List<Post>> {
  final PostRepository postRepository;

  // 생성자에서 postRepository를 초기화하고, 초기 상태로 빈 리스트를 설정
  PostSearchViewModel(this.postRepository) : super([]);

  // 게시글 검색 함수 - Future를 반환하도록 수정
  Future<List<Post>> searchPosts(String keyword) async {
    try {
      final postList = await postRepository.getPostsByKeyword(keyword);
      state = postList; // 상태 업데이트
      return postList;
    } catch (e) {
      state = []; // 에러 발생 시 빈 리스트로 상태 업데이트
      LogUtil.e('Error fetching post list: $e');
      return [];
    }
  }
}

final postSearchViewModelProvider =
    StateNotifierProvider<PostSearchViewModel, List<Post>>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  return PostSearchViewModel(postRepository);
});
