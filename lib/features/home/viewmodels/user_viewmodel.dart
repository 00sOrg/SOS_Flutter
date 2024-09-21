import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/user.dart';

//TODO: USER VIEWMODEL SHARED로 옮겨야함 -> user viewmodel 삭제 예정
// JWT token을 이용하여 payload를 decode하여 사용자 정보를 가져오는 방식으로 변경
class UserViewModel extends StateNotifier<User?> {
  UserViewModel() : super(null);

  void loadUserInfo() {
    final user = User(
      name: '윤지민',
      profilePicture: 'https://example.com/profile.jpg',
      email: 'user@example.com',
      password: 'password123',
      nickname: '지민닉네임',
      phoneNumber: '010-1234-5678',
      gender: '여성',
      birthDay: DateTime(2000, 1, 1),
    );

    state = user;
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, User?>((ref) {
  return UserViewModel();
});
