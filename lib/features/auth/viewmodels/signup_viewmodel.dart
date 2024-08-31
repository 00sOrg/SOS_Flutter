import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class SignupViewmodel extends StateNotifier<User> {
  SignupViewmodel()
      : emailTEC = TextEditingController(),
        passwordTEC = TextEditingController(),
        passwordCheckTEC = TextEditingController(),
        nameTEC = TextEditingController(),
        nicknameTEC = TextEditingController(),
        numberTEC = TextEditingController(),
        yearTEC = TextEditingController(),
        monthTEC = TextEditingController(),
        dayTEC = TextEditingController(),
        super(
          User(
            name: '',
            email: '',
            password: '',
            nickname: '',
            phoneNumber: '',
            gender: '',
            birthDay: DateTime(2000, 1, 1),
            profilePicture: '',
          ),
        );

  final TextEditingController emailTEC;
  final TextEditingController passwordTEC;
  final TextEditingController passwordCheckTEC;
  final TextEditingController nameTEC;
  final TextEditingController nicknameTEC;
  final TextEditingController numberTEC;
  final TextEditingController yearTEC;
  final TextEditingController monthTEC;
  final TextEditingController dayTEC;

  String? localImagePath;
  void updateProfilePicture(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      localImagePath = imagePath;
    } else {
      state = state.copyWith(profilePicture: '');
      localImagePath = null;
    }
    state = state.copyWith(profilePicture: imagePath); // trigger
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
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

  Future<void> checkEmail() async {
    debugPrint('이메일 중복확인 액션');
  }

  Future<void> checkName() async {
    debugPrint('닉네임 중복확인 액션');
  }

  bool areFieldsValid() {
    return emailTEC.text.isNotEmpty &&
        passwordTEC.text.isNotEmpty &&
        passwordCheckTEC.text.isNotEmpty &&
        nameTEC.text.isNotEmpty &&
        nicknameTEC.text.isNotEmpty &&
        numberTEC.text.isNotEmpty &&
        yearTEC.text.isNotEmpty &&
        monthTEC.text.isNotEmpty &&
        dayTEC.text.isNotEmpty;
  }

  Future<void> submit(BuildContext context) async {
    if (areFieldsValid()) {
      debugPrint('유저정보: ${state.nickname}, ${state.email}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          text: '모든 필드를 입력해야 합니다.',
        ),
      );
    }
  }

  @override
  void dispose() {
    emailTEC.dispose();
    passwordTEC.dispose();
    passwordCheckTEC.dispose();
    nameTEC.dispose();
    nicknameTEC.dispose();
    numberTEC.dispose();
    yearTEC.dispose();
    monthTEC.dispose();
    dayTEC.dispose();
    super.dispose();
  }
}

final signupViewModelProvider = StateNotifierProvider<SignupViewmodel, User>(
  (ref) => SignupViewmodel(),
);
