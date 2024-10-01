import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/user.dart';
// import 'package:sos/shared/widgets/custom_snack_bar.dart';

class SettingProfileViewModel extends StateNotifier<User> {
  SettingProfileViewModel()
      : super(
          User(
            name: '',
            email: '',
            password: '',
            nickname: '',
            phoneNumber: '',
            sex: '',
            birthDate: DateTime(2000, 1, 1),
            profilePicture: '',
          ),
        ) {
    emailTEC = TextEditingController(text: state.email);
    passwordTEC = TextEditingController();
    passwordCheckTEC = TextEditingController();
    nameTEC = TextEditingController(text: state.name);
    nicknameTEC = TextEditingController(text: state.nickname);
    numberTEC = TextEditingController(text: state.phoneNumber);
    yearTEC = TextEditingController(text: state.birthDate!.year.toString());
    monthTEC = TextEditingController(
        text: state.birthDate!.month.toString().padLeft(2, '0'));
    dayTEC = TextEditingController(
        text: state.birthDate!.day.toString().padLeft(2, '0'));
  }

  late TextEditingController emailTEC;
  late TextEditingController passwordTEC;
  late TextEditingController passwordCheckTEC;
  late TextEditingController nameTEC;
  late TextEditingController nicknameTEC;
  late TextEditingController numberTEC;
  late TextEditingController yearTEC;
  late TextEditingController monthTEC;
  late TextEditingController dayTEC;

  void loadUserData() {
    // TODO: 일단 더미 -> 서버에서 받아오도록 수정
    final dummyUser = User(
      name: '김채리',
      email: 'dummy@example.com',
      password: '',
      nickname: '챌챌',
      phoneNumber: '010-8575-4997',
      sex: '여자',
      birthDate: DateTime(2000, 9, 25),
      profilePicture: 'https://picsum.photos/100',
    );
    state = dummyUser;
    updateControllers();
  }

  void updateControllers() {
    emailTEC.text = state.email!;
    nameTEC.text = state.name!;
    nicknameTEC.text = state.nickname!;
    numberTEC.text = state.phoneNumber!;
    yearTEC.text = state.birthDate!.year.toString();
    monthTEC.text = state.birthDate!.month.toString().padLeft(2, '0');
    dayTEC.text = state.birthDate!.day.toString().padLeft(2, '0');
  }

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

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void updateNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void updateGender(String? gender) {
    if (gender != null) {
      state = state.copyWith(sex: gender);
    }
  }

  void updateBirthDate(DateTime birthDay) {
    state = state.copyWith(birthDate: birthDay);
  }

  bool isNicknameAvailable = false;
  bool isCheckingNickname = false;
  bool hasCheckedNickname = false;
  Future<void> checkName() async {
    debugPrint('닉네임 중복확인 액션');
    if (nicknameTEC.text.isEmpty) return;

    isCheckingNickname = true;
    hasCheckedNickname = false;
    state = state.copyWith(); // trigger
    // dummy 시간 줌
    await Future.delayed(const Duration(seconds: 1));

    // dummy 닉네임
    isNicknameAvailable =
        (nicknameTEC.text != 'hi') && (nicknameTEC.text.isNotEmpty);

    isCheckingNickname = false;
    hasCheckedNickname = true;
    state = state.copyWith(); // trigger
  }

  bool areFieldsValid() {
    return nicknameTEC.text.isNotEmpty &&
        yearTEC.text.isNotEmpty &&
        monthTEC.text.isNotEmpty &&
        dayTEC.text.isNotEmpty;
  }

  Future<void> submit(BuildContext context) async {
    // if (areFieldsValid()) {
    debugPrint('유저정보: ${state.nickname}, ${state.email}');
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     //customSnackBar(text: '입력값을 확인해주세요')
    //   );
    // }
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

final settingProfileViewModelProvider =
    StateNotifierProvider<SettingProfileViewModel, User>(
  (ref) => SettingProfileViewModel(),
);
