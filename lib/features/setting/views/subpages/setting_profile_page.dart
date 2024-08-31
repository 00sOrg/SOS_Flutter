import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/setting/viewmodels/setting_profile_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_labled_field.dart';
import 'package:sos/features/setting/views/widgets/setting_textfield.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/bottom_wide_button.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingProfilePage extends ConsumerStatefulWidget {
  const SettingProfilePage({super.key});

  @override
  ConsumerState<SettingProfilePage> createState() => _SettingProfilePageState();
}

class _SettingProfilePageState extends ConsumerState<SettingProfilePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingProfileViewModelProvider.notifier).loadUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(settingProfileViewModelProvider.notifier);
    final user = ref.watch(settingProfileViewModelProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: '내 정보 수정'),
      body: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    // child: CircleAvatar(
                    //   radius: 50,
                    //   backgroundImage: user.profilePicture.isNotEmpty
                    //       ? NetworkImage(user.profilePicture)
                    //       : null,
                    //   child: user.profilePicture.isEmpty
                    //       ? Icon(Icons.add_a_photo)
                    //       : null,
                    // ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      minRadius: 48,
                      maxRadius: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 38),
                SettingExpandingTextfield(
                  hintText:
                      '건우를 위한 긴 텍스트필드,, 글자 넘 연한건 신경쓰지말고 걍 개발하면 됨요!! 디자인 바뀌는거 따라서 파라미터 몇개 조정해야할수도',
                  onChanged: (temp) => (),
                  maxLength: 250,
                ),
                const SizedBox(height: 30),
                SettingTextfield(
                  hintText: '이메일',
                  maxLength: 80,
                  keyboardType: TextInputType.emailAddress,
                  controller: viewModel.emailTEC,
                  onChanged: viewModel.updateEmail,
                ),
                const SizedBox(height: 9),
                SettingTextfield(
                  hintText: '비밀번호',
                  maxLength: 100,
                  obscureText: true,
                  onChanged: viewModel.updatePassword,
                ),
                const SizedBox(height: 9),
                SettingTextfield(
                  hintText: '비밀번호 확인',
                  maxLength: 100,
                  obscureText: true,
                  onChanged: viewModel.updatePassword,
                ),
                const SizedBox(height: 36),
                SettingLabledField(
                  label: '닉네임',
                  child: Row(
                    children: [
                      Expanded(
                        child: SettingTextfield(
                          hintText: '16자 이내로 입력해 주세요.',
                          maxLength: 16,
                          controller: viewModel.nicknameTEC,
                          onChanged: viewModel.updateNickname,
                        ),
                      ),
                      const SizedBox(width: 9),
                      _checkNameBtn(viewModel),
                    ],
                  ),
                ),
                SettingLabledField(
                  label: '전화번호',
                  child: SettingTextfield(
                    hintText: '010-0000-0000',
                    maxLength: 16,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    controller: viewModel.numberTEC,
                    onChanged: viewModel.updatePhoneNumber,
                  ),
                ),
                SettingLabledField(
                  label: '성별',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _customRadioListTile(
                        title: '남자',
                        value: '남자',
                        groupValue: user.gender,
                        onChanged: viewModel.updateGender,
                      ),
                      const SizedBox(height: 10),
                      _customRadioListTile(
                        title: '여자',
                        value: '여자',
                        groupValue: user.gender,
                        onChanged: viewModel.updateGender,
                      ),
                    ],
                  ),
                ),
                SettingLabledField(
                  label: '생년월일',
                  child: Row(
                    children: [
                      Expanded(
                        child: SettingTextfield(
                          hintText: 'YYYY',
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          controller: viewModel.yearTEC,
                          onChanged: (value) {
                            final year = int.tryParse(value) ?? 2000;
                            viewModel.updateBirthDate(DateTime(
                                year, user.birthDay.month, user.birthDay.day));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SettingTextfield(
                          hintText: 'MM',
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: viewModel.monthTEC,
                          onChanged: (value) {
                            final month = int.tryParse(value) ?? 1;
                            viewModel.updateBirthDate(
                              DateTime(
                                user.birthDay.year,
                                month,
                                user.birthDay.day,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: SettingTextfield(
                          hintText: 'DD',
                          maxLength: 2,
                          controller: viewModel.dayTEC,
                          onChanged: (value) {
                            final day = int.tryParse(value) ?? 1;
                            viewModel.updateBirthDate(
                              DateTime(
                                user.birthDay.year,
                                user.birthDay.month,
                                day,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 25),
          child: BottomWideButton(
            text: '가입하기',
            onTap: () => viewModel.submit(),
          )),
    );
  }

  Widget _checkNameBtn(SettingProfileViewModel viewModel) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => viewModel.checkName(),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.blue, width: 1),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Text(
          '중복확인',
          style: TextStyle(
            color: AppColors.blue,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // 수평배열 신경쓰기 싫어서 그냥 일단 여기서만 쓸 수 있는 애로 이 파일에 만들어둠
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
          const SizedBox(width: 8),
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
