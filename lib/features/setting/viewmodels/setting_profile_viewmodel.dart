import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/setting/repositories/setting_repository.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/user_viewmodel.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';
// import 'package:sos/shared/widgets/custom_snack_bar.dart';

class SettingProfileViewModel extends StateNotifier<User> {
  final SettingRepository settingRepository;
  final UserViewModel userViewModel;
  SettingProfileViewModel(this.settingRepository, this.userViewModel)
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

  Future<void> loadUserData() async {
    // userViewModel.printDecodedToken();
    await userViewModel.loadUserInfo();

    final user = userViewModel.state;

    state = user;

    updateControllers();
  }

  void updateControllers() {
    emailTEC.text = state.email!;
    nameTEC.text = state.name!;
    nicknameTEC.text = state.nickname!;
    numberTEC.text = state.phoneNumber!;
    yearTEC.text = state.birthDate?.year.toString() ?? '0000';
    monthTEC.text = state.birthDate?.month.toString().padLeft(2, '0') ?? '00';
    dayTEC.text = state.birthDate?.day.toString().padLeft(2, '0') ?? '00';
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

  bool hasProfilePictureChanged() {
    return localImagePath != null || state.profilePicture == '';
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

  bool isNicknameAvailable = true;
  bool isCheckingNickname = false;
  bool hasCheckedNickname = false;
  Future<void> checkName() async {
    if (nicknameTEC.text.isEmpty) return;

    isCheckingNickname = true;
    hasCheckedNickname = false;
    state = state.copyWith(); // trigger

    try {
      isNicknameAvailable =
          await settingRepository.checkNickname(nicknameTEC.text);
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
        nicknameTEC.text.isNotEmpty &&
        yearTEC.text.isNotEmpty &&
        monthTEC.text.isNotEmpty &&
        dayTEC.text.isNotEmpty;
  }

  Future<void> submit(BuildContext context) async {
    if (areFieldsValid()) {
      final nickname = nicknameTEC.text;
      final phoneNumber = numberTEC.text;
      final password = passwordTEC.text.isNotEmpty ? passwordTEC.text : null;
      final sex = state.sex;
      final birthDate = state.birthDate;
      String? profilePicture = state.profilePicture;
      String? media;

      if (hasProfilePictureChanged()) {
        media = localImagePath; // '' 가는 경우는 원래 있었는데 삭제된 경우
      }

      final success = await settingRepository.updateUserInfo(
        nickname,
        phoneNumber,
        password,
        sex,
        birthDate,
        profilePicture,
        media,
      );

      if (success) {
        await userViewModel.loadUserInfo();

        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
            text: '프로필 수정에 성공했습니다.',
            backgroundColor: AppColors.blue,
          ),
        );
        GoRouter.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(text: '프로필 수정을 실패했습니다.'),
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

final settingProfileViewModelProvider =
    StateNotifierProvider<SettingProfileViewModel, User>((ref) {
  final settingRepository = ref.read(settingRepositoryProvider);
  final userViewModel = ref.read(userViewModelProvider.notifier);

  return SettingProfileViewModel(settingRepository, userViewModel);
});
