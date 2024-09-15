import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/x_archive/x_post.dart';
import 'package:sos/shared/repositories/x_post_repository.dart';

class BoardViewModel extends StateNotifier<AsyncValue<List<XPost>>> {
  final XPostRepository _repository;

  BoardViewModel(this._repository)
      : super(
          const AsyncValue.loading(),
        ) {
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final posts = await _repository.getPosts();
      state = AsyncValue.data(posts);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deletePost(String id) async {
    await _repository.deletePost(id);
    state = state.whenData(
      (posts) => posts.where((post) => post.id != id).toList(),
    );
  }
}

final boardViewModelProvider =
    StateNotifierProvider<BoardViewModel, AsyncValue<List<XPost>>>(
  (ref) {
    final repository = ref.watch(postRepositoryProvider);
    return BoardViewModel(repository);
  },
);
