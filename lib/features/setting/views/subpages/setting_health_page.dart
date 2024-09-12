import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/setting/viewmodels/setting_health_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_labled_field.dart';
import 'package:sos/features/setting/views/widgets/setting_textfield.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/bottom_wide_button.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingHealthPage extends ConsumerStatefulWidget {
  const SettingHealthPage({super.key});

  @override
  ConsumerState<SettingHealthPage> createState() => _SettingHealthPageState();
}

class _SettingHealthPageState extends ConsumerState<SettingHealthPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingHealthViewModelProvider.notifier).loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(settingHealthViewModelProvider.notifier);
    final userhealthInfo = ref.watch(settingHealthViewModelProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: '건강 정보 등록 및 수정'),
      body: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 33, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingLabledField(
                  label: '키 · 몸무게',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SettingTextfield(
                          hintText: '키',
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          controller: viewModel.heightTEC,
                          onChanged: (value) {
                            final height = double.tryParse(value) ?? 0.0;
                            viewModel.updateHeight(height);
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'cm',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Apple SD Gothic Neo',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SettingTextfield(
                          hintText: '몸무게',
                          maxLength: 5,
                          keyboardType: TextInputType.number,
                          controller: viewModel.weightTEC,
                          onChanged: (value) {
                            final weight = double.tryParse(value) ?? 0.0;
                            viewModel.updateWeight(weight);
                          },
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'kg',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Apple SD Gothic Neo',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SettingLabledField(
                  label: '혈액형',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      _customRadioListTile(
                        title: 'A',
                        value: 'A',
                        groupValue: userhealthInfo.bloodType,
                        onChanged: (value) => viewModel.updateBloodType(value),
                      ),
                      const SizedBox(width: 50),
                      _customRadioListTile(
                        title: 'B',
                        value: 'B',
                        groupValue: userhealthInfo.bloodType,
                        onChanged: (value) => viewModel.updateBloodType(value),
                      ),
                      const SizedBox(width: 50),
                      _customRadioListTile(
                        title: 'AB',
                        value: 'AB',
                        groupValue: userhealthInfo.bloodType,
                        onChanged: (value) => viewModel.updateBloodType(value),
                      ),
                      const SizedBox(width: 50),
                      _customRadioListTile(
                        title: 'O',
                        value: 'O',
                        groupValue: userhealthInfo.bloodType,
                        onChanged: (value) => viewModel.updateBloodType(value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: const Text(
                    '기존에 앓고 있던 질병',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SettingExpandingTextfield(
                  hintText: '고혈압, 당뇨, 등 질병 목록 (최대 250자)',
                  onChanged: (temp) => (),
                  maxLength: 250,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: const Text(
                    '현재 섭취하고 있는 약',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SettingExpandingTextfield(
                  hintText: '고혈압, 당뇨, 등 질병 목록 (최대 250자)',
                  onChanged: (temp) => (),
                  maxLength: 250,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 25),
          child: BottomWideButton(
            text: '저장하기',
            onTap: () => viewModel.submit(),
          )),
    );
  }

  Widget _customRadioListTile({
    required String title,
    required String value,
    required String groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 0),
          Radio<String>(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: AppColors.blue,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: AppTexts.bodyStyle.copyWith(
              color: isSelected ? null : AppColors.textGray,
            ),
          ),
        ],
      ),
    );
  }
}
