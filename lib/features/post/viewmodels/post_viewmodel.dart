import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_list.dart';

class PostViewModelNotifier extends StateNotifier<List<Post>> {
  PostViewModelNotifier() : super(dummyPosts);

  Post getPostById(int postId) {
    return state.firstWhere(
      (post) => post.postId == postId,
      orElse: () => Post(
        postId: 0,
        createdAt: DateTime(0),
        title: 'Unknown Post',
        latitude: 0.0,
        longitude: 0.0,
        comments: [],
      ),
    );
  }
}

final postViewModelProvider =
    StateNotifierProvider<PostViewModelNotifier, List<Post>>((ref) {
  return PostViewModelNotifier();
});

final postByIdProvider = Provider.family<Post, int>((ref, postId) {
  final posts = ref.watch(postViewModelProvider);
  return posts.firstWhere(
    (post) => post.postId == postId,
    orElse: () => Post(
      postId: 0,
      createdAt: DateTime(0),
      title: 'Unknown Post No.$postId',
      latitude: 0.0,
      longitude: 0.0,
      comments: [],
    ),
  );
});
