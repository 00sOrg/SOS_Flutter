import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/user.dart';

class UserViewModel extends StateNotifier<User?> {
  UserViewModel() : super(null);

  void loadUserInfo() {
    final user = User(
      name: '윤지민',
      profilePicture: 'https://example.com/profile.jpg',
      name: '윤지민',
      email: 'user@example.com',
      password: 'password123',
      nickname: '윤지미니미닝',
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
