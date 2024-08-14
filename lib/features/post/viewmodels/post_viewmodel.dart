import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostViewModel {
  final String profileImageUrl;
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  final bool hasImage;
  final String content;
  final int likes;
  final int comments;

  PostViewModel({
    required this.profileImageUrl,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.hasImage,
    required this.content,
    required this.likes,
    required this.comments,
  });
}

final postViewModelProvider = Provider<PostViewModel>((ref) {
  // 여기에 실제 데이터를 제공하세요. 예를 들어, API로부터 데이터를 받아와서 PostViewModel로 초기화할 수 있습니다.
  return PostViewModel(
    profileImageUrl: 'https://via.placeholder.com/150',
    title: '게시글 제목',
    date: '2024-08-09',
    location: '서울특별시',
    imageUrl: 'https://via.placeholder.com/400x200',
    hasImage: true,
    content: '여기에 본문 내용이 들어갑니다.',
    likes: 100,
    comments: 25,
  );
});
