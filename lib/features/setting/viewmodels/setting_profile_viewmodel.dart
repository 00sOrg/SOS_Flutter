import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/user.dart';

class SettingProfileViewModel extends StateNotifier<User> {
  SettingProfileViewModel()
      : super(
          User(
            email: '',
            password: '',
            nickname: '',
            phoneNumber: '',
            gender: '',
            birthDay: DateTime(2000, 1, 1),
            profilePicture: '',
          ),
        );

  void loadUserData() {
    // 일단 더미
    final dummyUser = User(
      email: 'dummy@example.com',
      password: '',
      nickname: '챌챌',
      phoneNumber: '010-8575-4997',
      gender: '여자',
      birthDay: DateTime(2000, 9, 25),
      profilePicture: '',
    );
    state = dummyUser;
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void updatePhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void updateGender(String? gender) {
    if (gender != null) {
      state = state.copyWith(gender: gender);
    }
  }

  void updateBirthDate(DateTime birthDay) {
    state = state.copyWith(birthDay: birthDay);
  }

  void updateProfilePicture(String profilePicture) {
    state = state.copyWith(profilePicture: profilePicture);
  }

  Future<void> checkName() async {
    debugPrint('중복확인 액션');
  }

  Future<void> submit() async {
    debugPrint('유저정보: ${state.nickname}, ${state.email}');
  }
}

final settingProfileViewModelProvider =
    StateNotifierProvider<SettingProfileViewModel, User>(
  (ref) => SettingProfileViewModel(),
);
