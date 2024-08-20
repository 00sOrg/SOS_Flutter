import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/x_post.dart';
import 'package:sos/shared/repositories/post_repository.dart';

final postRepositoryProvider = Provider((ref) => PostRepository());

final postsProvider = FutureProvider<List<XPost>>((ref) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPosts();
});

final postProvider = FutureProvider.family<XPost, String>((ref, id) async {
  final repository = ref.watch(postRepositoryProvider);
  return repository.getPost(id);
});
