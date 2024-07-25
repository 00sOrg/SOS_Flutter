import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearhere/shared/models/post.dart';
import 'package:nearhere/shared/repositories/post_repository.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

final postsProvider = FutureProvider<List<Post>>((ref) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPosts();
});

final postProvider = FutureProvider.family<Post, String>((ref, id) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPost(id);
});