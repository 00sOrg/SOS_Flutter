import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/setting/repositories/setting_repository.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/user_viewmodel.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

// class UserHealthInfo {
//   final double height;
//   final double weight;
//   final String bloodType;
//   final String disease;
//   final String medication;

//   UserHealthInfo({
//     required this.height,
//     required this.weight,
//     required this.bloodType,
//     required this.disease,
//     required this.medication,
//   });

//   UserHealthInfo copyWith({
//     double? height,
//     double? weight,
//     String? bloodType,
//     String? disease,
//     String? medication,
//   }) {
//     return UserHealthInfo(
//       height: height ?? this.height,
//       weight: weight ?? this.weight,
//       bloodType: bloodType ?? this.bloodType,
//       disease: disease ?? this.disease,
//       medication: medication ?? this.medication,
//     );
//   }
// }

class SettingHealthViewModel extends StateNotifier<User> {
  final SettingRepository settingRepository;

  final UserViewModel userViewModel;
  SettingHealthViewModel(this.settingRepository, this.userViewModel)
      : super(
          User(
            height: '',
            weight: '',
            bloodType: '',
            disease: '',
            medication: '',
          ),
        ) {
    heightTEC = TextEditingController(text: state.height.toString());
    weightTEC = TextEditingController(text: state.weight.toString());
    // bloodTypeTEC = TextEditingController(text: state.bloodType);
    diseaseTEC = TextEditingController(text: state.disease);
    medicationTEC = TextEditingController(text: state.medication);
  }

  late TextEditingController heightTEC;
  late TextEditingController weightTEC;
  // late TextEditingController bloodTypeTEC;
  late TextEditingController diseaseTEC;
  late TextEditingController medicationTEC;

  void loadUserData() async {
    // 예시로 더미 데이터를 로드합니다.
    // final dummyHealthInfo = UserHealthInfo(
    //   height: 170.0,
    //   weight: 70.0,
    //   bloodType: 'A',
    //   disease: '천식',
    //   medication: 'Ventolin',
    // );
    await userViewModel.loadUserInfo();
    final user = userViewModel.state;
    state = user;
    updateControllers();
  }

  void updateControllers() {
    heightTEC.text = state.height ?? '';
    weightTEC.text = state.weight ?? '';
    // bloodTypeTEC.text = state.bloodType ?? '';
    diseaseTEC.text = state.disease ?? '';
    medicationTEC.text = state.medication ?? '';
  }

  void updateHeight(String height) {
    state = state.copyWith(height: height);
  }

  void updateWeight(String weight) {
    state = state.copyWith(weight: weight);
  }

  void updateBloodType(String? bloodType) {
    if (bloodType != null && bloodType.isEmpty) {
      state = state.copyWith(bloodType: bloodType);
    } else {
      state = state.copyWith(bloodType: bloodType);
    }
  }

  void updateDisease(String? disease) {
    state = state.copyWith(disease: disease);
  }

  void updateMedication(String medication) {
    state = state.copyWith(medication: medication);
  }

  Future<void> submit(BuildContext context) async {
    debugPrint(
        '건강 정보: ${state.height}cm, ${state.weight}kg, 혈액형: ${state.bloodType}, 질병: ${state.disease}, 약물: ${state.medication}');
    final height = heightTEC.text;
    final weight = weightTEC.text;
    final bloodType = state.bloodType;
    final disease = diseaseTEC.text;
    final medication = medicationTEC.text;

    final success = await settingRepository.updateHealthInfo(
      height,
      weight,
      bloodType,
      disease,
      medication,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          text: '건강정보 수정에 성공했습니다.',
          backgroundColor: AppColors.blue,
        ),
      );
      GoRouter.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: '건강정보 수정을 실패했습니다.'),
      );
    }
  }

  @override
  void dispose() {
    heightTEC.dispose();
    weightTEC.dispose();
    // bloodTypeTEC.dispose();
    diseaseTEC.dispose();
    medicationTEC.dispose();
    super.dispose();
  }
}

final settingHealthViewModelProvider =
    StateNotifierProvider<SettingHealthViewModel, User>((ref) {
  final settingRepository = ref.read(settingRepositoryProvider);
  final userViewModel = ref.read(userViewModelProvider.notifier);

  return SettingHealthViewModel(settingRepository, userViewModel);
});
