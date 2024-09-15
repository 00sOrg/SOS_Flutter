import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/auth/repositories/auth_repository.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class SignupViewmodel extends StateNotifier<User> {
  final AuthRepository authRepository;

  SignupViewmodel(this.authRepository)
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

  bool isEmailAvailable = false;
  bool isCheckingEmail = false;
  bool hasCheckedEmail = false;

  Future<void> checkEmail() async {
    if (emailTEC.text.isEmpty) return;

    isCheckingEmail = true;
    hasCheckedEmail = false;
    state = state.copyWith(); // trigger

    try {
      isEmailAvailable = await authRepository.checkEmail(emailTEC.text);
    } catch (e) {
      debugPrint('이메일 검증 실패: $e');
      isEmailAvailable = false;
    }

    isCheckingEmail = false;
    hasCheckedEmail = true;
    state = state.copyWith(); // trigger
  }

  bool isNicknameAvailable = false;
  bool isCheckingNickname = false;
  bool hasCheckedNickname = false;

  Future<void> checkName() async {
    if (nicknameTEC.text.isEmpty) return;

    isCheckingNickname = true;
    hasCheckedNickname = false;
    state = state.copyWith(); // trigger

    try {
      isNicknameAvailable =
          await authRepository.checkNickname(nicknameTEC.text);
    } catch (e) {
      debugPrint('닉네임 검증 실패: $e');
      isNicknameAvailable = false;
    }

    isCheckingNickname = false;
    hasCheckedNickname = true;
    state = state.copyWith(); // trigger
  }

  bool areFieldsValid() {
    return isNicknameAvailable &&
        isEmailAvailable &&
        emailTEC.text.isNotEmpty &&
        passwordTEC.text.isNotEmpty &&
        passwordCheckTEC.text == passwordTEC.text &&
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
      final birthDate = DateTime(
        int.parse(yearTEC.text),
        int.parse(monthTEC.text),
        int.parse(dayTEC.text),
      );

      final updatedUser = state.copyWith(
        email: emailTEC.text,
        password: passwordTEC.text,
        name: nameTEC.text,
        nickname: nicknameTEC.text,
        phoneNumber: numberTEC.text,
        birthDay: birthDate,
      );

      final success =
          await authRepository.signupUser(updatedUser, localImagePath ?? '');

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(text: '회원가입에 성공했습니다'),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(text: '회원가입에 실패했습니다.'),
        );
      }
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
  (ref) => SignupViewmodel(ref.read(authRepositoryProvider)),
);
