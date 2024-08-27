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
        ) {
    emailTEC = TextEditingController(text: state.email);
    nicknameTEC = TextEditingController(text: state.nickname);
    numberTEC = TextEditingController(text: state.phoneNumber);
    yearTEC = TextEditingController(text: state.birthDay.year.toString());
    monthTEC = TextEditingController(
        text: state.birthDay.month.toString().padLeft(2, '0'));
    dayTEC = TextEditingController(
        text: state.birthDay.day.toString().padLeft(2, '0'));
  }

  late TextEditingController emailTEC;
  late TextEditingController nicknameTEC;
  late TextEditingController numberTEC;
  late TextEditingController yearTEC;
  late TextEditingController monthTEC;
  late TextEditingController dayTEC;

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
    updateControllers();
  }

  void updateControllers() {
    emailTEC.text = state.email;
    nicknameTEC.text = state.nickname;
    numberTEC.text = state.phoneNumber;
    yearTEC.text = state.birthDay.year.toString();
    monthTEC.text = state.birthDay.month.toString().padLeft(2, '0');
    dayTEC.text = state.birthDay.day.toString().padLeft(2, '0');
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

  @override
  void dispose() {
    emailTEC.dispose();
    nicknameTEC.dispose();
    numberTEC.dispose();
    yearTEC.dispose();
    monthTEC.dispose();
    dayTEC.dispose();
    super.dispose();
  }
}

final settingProfileViewModelProvider =
    StateNotifierProvider<SettingProfileViewModel, User>(
  (ref) => SettingProfileViewModel(),
);
