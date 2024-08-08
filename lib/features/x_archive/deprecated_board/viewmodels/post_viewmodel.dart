import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/models/x_post.dart';
import '../../../../shared/repositories/post_repository.dart';

class PostViewModel extends StateNotifier<AsyncValue<XPost>> {
  PostViewModel(this._repository, this.id) : super(const AsyncValue.loading()) {
    fetchPost();
  }

  final PostRepository _repository;
  final String id;

  Future<void> fetchPost() async {
    try {
      final post = await _repository.getPost(id);
      state = AsyncValue.data(post);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final postViewModelProvider =
    StateNotifierProvider.family<PostViewModel, AsyncValue<XPost>, String>(
        (ref, id) {
  final repository = ref.watch(postRepositoryProvider);
  return PostViewModel(repository, id);
});
