import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostViewModel {
  final String id; // 게시글 ID 추가
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
    required this.id,
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

class PostViewModelNotifier extends StateNotifier<List<PostViewModel>> {
  PostViewModelNotifier() : super(_dummyPosts);

  // 더미 데이터 목록
  static final List<PostViewModel> _dummyPosts = [
    PostViewModel(
      id: '1',
      profileImageUrl: 'https://via.placeholder.com/150',
      title: '게시글 제목 1',
      date: '2024-08-09',
      location: '서울특별시',
      imageUrl: 'https://via.placeholder.com/400x200',
      hasImage: true,
      content: '여기에 본문 내용이 들어갑니다. 1',
      likes: 100,
      comments: 25,
    ),
    PostViewModel(
      id: '2',
      profileImageUrl: 'https://via.placeholder.com/150',
      title: '게시글 제목 2',
      date: '2024-08-10',
      location: '부산광역시',
      imageUrl: 'https://via.placeholder.com/400x200',
      hasImage: true,
      content: '여기에 본문 내용이 들어갑니다. 2',
      likes: 150,
      comments: 30,
    ),
    PostViewModel(
      id: '3',
      profileImageUrl: 'https://via.placeholder.com/150',
      title: '게시글 제목 3',
      date: '2024-08-11',
      location: '대전광역시',
      imageUrl: 'https://via.placeholder.com/400x200',
      hasImage: true,
      content: '여기에 본문 내용이 들어갑니다. 3',
      likes: 75,
      comments: 10,
    ),
    // 추가적인 더미 데이터들...
    PostViewModel(
      id: '4',
      profileImageUrl: 'https://via.placeholder.com/150',
      title: '게시글 제목 4',
      date: '2024-08-12',
      location: '대구광역시',
      imageUrl: 'https://via.placeholder.com/400x200',
      hasImage: true,
      content: '여기에 본문 내용이 들어갑니다. 4',
      likes: 50,
      comments: 5,
    ),
    PostViewModel(
      id: '5',
      profileImageUrl: 'https://via.placeholder.com/150',
      title: '게시글 제목 5',
      date: '2024-08-13',
      location: '광주광역시',
      imageUrl: 'https://via.placeholder.com/400x200',
      hasImage: true,
      content: '여기에 본문 내용이 들어갑니다. 5',
      likes: 200,
      comments: 40,
    ),
  ];

  PostViewModel getPostById(String id) {
    return state.firstWhere(
      (post) => post.id == id,
      orElse: () => PostViewModel(
        id: '0',
        profileImageUrl: '',
        title: 'Unknown Post',
        date: '',
        location: '',
        imageUrl: '',
        hasImage: false,
        content: 'This post does not exist.',
        likes: 0,
        comments: 0,
      ),
    );
  }
}

// StateNotifierProvider를 사용하여 게시글 관리
final postViewModelProvider =
    StateNotifierProvider<PostViewModelNotifier, List<PostViewModel>>((ref) {
  return PostViewModelNotifier();
});

// ID로 특정 게시글을 가져오는 Provider
final postByIdProvider = Provider.family<PostViewModel, String>((ref, id) {
  final posts = ref.watch(postViewModelProvider);
  final post = posts.firstWhere(
    (post) => post.id == id,
    orElse: () {
      return PostViewModel(
        id: '0',
        profileImageUrl: '',
        title: 'Unknown Post No.$id',
        date: '',
        location: '',
        imageUrl: '',
        hasImage: false,
        content: 'This post does not exist.',
        likes: 0,
        comments: 0,
      );
    },
  );
  return post;
});
