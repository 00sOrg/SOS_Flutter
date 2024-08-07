import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/board/views/widgets/post_preview_block.dart';

class BoardPage extends ConsumerWidget {
  BoardPage({super.key});
  final List<String> dummyPosts =
      List.generate(10, (index) => 'post ${index + 1}');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '사건/사고 목록',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: ListView.builder(
        itemCount: dummyPosts.length,
        itemBuilder: (context, index) {
          return PostPreviewBlock(post: dummyPosts[index]);
        },
      ),
    );
  }
}
