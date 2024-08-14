import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/viewmodels/post_viewmodel.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postViewModel = ref.watch(postViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로가기 라우터
          },
        ),
        title: Text('게시물'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(postViewModel),
              const SizedBox(height: 16.0),
              _buildImageSection(postViewModel),
              const SizedBox(height: 16.0),
              _buildContentSection(postViewModel),
              const SizedBox(height: 16.0),
              _buildLikeAndCommentSection(postViewModel),
              const SizedBox(height: 16.0),
              _buildCommentSection(), // 댓글 섹션
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(PostViewModel viewModel) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.0,
          backgroundImage: NetworkImage(viewModel.profileImageUrl),
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${viewModel.date} · ${viewModel.location}',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageSection(PostViewModel viewModel) {
    return viewModel.hasImage
        ? Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(viewModel.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          )
        : SizedBox.shrink();
  }

  Widget _buildContentSection(PostViewModel viewModel) {
    return Text(
      viewModel.content,
      style: TextStyle(fontSize: 16.0),
    );
  }

  Widget _buildLikeAndCommentSection(PostViewModel viewModel) {
    return Row(
      children: [
        Icon(Icons.favorite_border),
        const SizedBox(width: 8.0),
        Text('${viewModel.likes}'), // 좋아요 수
        const SizedBox(width: 16.0),
        Icon(Icons.comment),
        const SizedBox(width: 8.0),
        Text('${viewModel.comments}'), // 댓글 수
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      children: [
        Text('여기에 댓글 목록이 표시됩니다.'),
        // 이미 구현해놓은 댓글 위젯을 여기에 추가하세요
      ],
    );
  }
}
