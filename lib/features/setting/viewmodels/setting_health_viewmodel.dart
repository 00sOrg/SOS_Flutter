import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class UserHealthInfo {
  final double height;
  final double weight;
  final String bloodType;
  final String disease;
  final String medication;

  UserHealthInfo({
    required this.height,
    required this.weight,
    required this.bloodType,
    required this.disease,
    required this.medication,
  });

  UserHealthInfo copyWith({
    double? height,
    double? weight,
    String? bloodType,
    String? disease,
    String? medication,
  }) {
    return UserHealthInfo(
      height: height ?? this.height,
      weight: weight ?? this.weight,
      bloodType: bloodType ?? this.bloodType,
      disease: disease ?? this.disease,
      medication: medication ?? this.medication,
    );
  }
}

class SettingHealthViewModel extends StateNotifier<UserHealthInfo> {
  SettingHealthViewModel()
      : super(
          UserHealthInfo(
            height: 0.0,
            weight: 0.0,
            bloodType: '',
            disease: '',
            medication: '',
          ),
        ) {
    heightTEC = TextEditingController(text: state.height.toString());
    weightTEC = TextEditingController(text: state.weight.toString());
    bloodTypeTEC = TextEditingController(text: state.bloodType);
    diseaseTEC = TextEditingController(text: state.disease);
    medicationTEC = TextEditingController(text: state.medication);
  }

  late TextEditingController heightTEC;
  late TextEditingController weightTEC;
  late TextEditingController bloodTypeTEC;
  late TextEditingController diseaseTEC;
  late TextEditingController medicationTEC;

  void loadUserData() {
    // 예시로 더미 데이터를 로드합니다.
    final dummyHealthInfo = UserHealthInfo(
      height: 170.0,
      weight: 70.0,
      bloodType: 'A',
      disease: '천식',
      medication: 'Ventolin',
    );
    state = dummyHealthInfo;
    updateControllers();
  }

  void updateControllers() {
    heightTEC.text = state.height.toString();
    weightTEC.text = state.weight.toString();
    bloodTypeTEC.text = state.bloodType;
    diseaseTEC.text = state.disease;
    medicationTEC.text = state.medication;
  }

  void updateHeight(double height) {
    state = state.copyWith(height: height);
  }

  void updateWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  void updateBloodType(String? bloodType) {
    if (bloodType != null) {
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
    GoRouter.of(context).pop();
    debugPrint(
        '건강 정보: ${state.height}cm, ${state.weight}kg, 혈액형: ${state.bloodType}, 질병: ${state.disease}, 약물: ${state.medication}');
    // 이곳에 실제 제출 로직을 구현할 수 있습니다.
  }

  @override
  void dispose() {
    heightTEC.dispose();
    weightTEC.dispose();
    bloodTypeTEC.dispose();
    diseaseTEC.dispose();
    medicationTEC.dispose();
    super.dispose();
  }
}

final settingHealthViewModelProvider =
    StateNotifierProvider<SettingHealthViewModel, UserHealthInfo>(
  (ref) => SettingHealthViewModel(),
);
