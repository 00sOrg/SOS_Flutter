import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_list.dart';

class PostViewModelNotifier extends StateNotifier<List<Post>> {
  PostViewModelNotifier() : super(dummyPosts);

  // Get a post by ID
  Post getPostById(int postId) {
    return state.firstWhere((post) => post.postId == postId);
  }

  // Toggle like for the given post
  void toggleLike(int postId) {
    state = [
      for (final post in state)
        if (post.postId == postId)
          post.copyWith(
            likesCount:
                post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
            isLiked: !post.isLiked, // Toggle the like status
          )
        else
          post,
    ];
  }

  // Add a comment for the given post
  void addComment(int postId) {
    state = [
      for (final post in state)
        if (post.postId == postId)
          post.copyWith(commentsCount: post.commentsCount + 1)
        else
          post,
    ];
  }
}

// Define the postViewModelProvider
final postViewModelProvider =
    StateNotifierProvider<PostViewModelNotifier, List<Post>>((ref) {
  return PostViewModelNotifier();
});

// Provider for accessing a post by ID
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
