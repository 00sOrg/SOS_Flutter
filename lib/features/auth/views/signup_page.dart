import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/auth/viewmodels/signup_viewmodel.dart';
import 'package:sos/features/auth/views/widgets/signup_textfield.dart';
import 'package:sos/features/setting/views/widgets/setting_labled_field.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/bottom_wide_button.dart';
import 'package:sos/shared/widgets/check_duplicate_button.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';
import 'package:sos/shared/widgets/profile_image_picker.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(signupViewModelProvider.notifier);
    final user = ref.watch(signupViewModelProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: '회원가입',
        onTapLeading: () => GoRouter.of(context).pop(),
      ),
      body: KeyboardDismisser(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ProfileImagePicker(
                    profilePicture: user.profilePicture,
                    localImagePath: viewModel.localImagePath,
                    onImageSelected: (newImg) {
                      viewModel.updateProfilePicture(newImg ?? '');
                    },
                  ),
                ),
                const SizedBox(height: 38),
                Row(
                  children: [
                    Expanded(
                      child: SignupTextfield(
                        hintText: '이메일',
                        maxLength: 80,
                        keyboardType: TextInputType.emailAddress,
                        controller: viewModel.emailTEC,
                        onChanged: viewModel.updateEmail,
                      ),
                    ),
                    const SizedBox(width: 6),
                    CheckDuplicateButton(onTap: viewModel.checkEmail),
                  ],
                ),
                const SizedBox(height: 2),
                if (viewModel.hasCheckedEmail)
                  _emailCheckResult(viewModel.isEmailAvailable),
                const SizedBox(height: 12),
                SignupTextfield(
                  hintText: '비밀번호(문자/숫자 포함 6-20자)',
                  maxLength: 100,
                  obscureText: true,
                  controller: viewModel.passwordTEC,
                  onChanged: viewModel.updatePassword,
                ),
                const SizedBox(height: 9),
                SignupTextfield(
                  hintText: '비밀번호 확인',
                  maxLength: 100,
                  obscureText: true,
                  controller: viewModel.passwordCheckTEC,
                  onChanged: viewModel.updatePassword,
                ),
                const SizedBox(height: 36),
                SettingLabledField(
                  label: '이름',
                  child: SignupTextfield(
                    hintText: '이름',
                    maxLength: 10,
                    controller: viewModel.nameTEC,
                    onChanged: viewModel.updateName,
                  ),
                ),
                SettingLabledField(
                  label: '닉네임',
                  bottomPadding: 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: SignupTextfield(
                          hintText: '16자 이내로 입력해 주세요.',
                          maxLength: 16,
                          controller: viewModel.nicknameTEC,
                          onChanged: viewModel.updateNickname,
                        ),
                      ),
                      const SizedBox(width: 6),
                      CheckDuplicateButton(onTap: viewModel.checkName),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                if (viewModel.hasCheckedNickname)
                  _nameCheckResult(viewModel.isNicknameAvailable),
                const SizedBox(height: 18),
                SettingLabledField(
                  label: '전화번호',
                  child: SignupTextfield(
                    hintText: '010-0000-0000',
                    maxLength: 16,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    controller: viewModel.numberTEC,
                    onChanged: (_) {},
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
                        groupValue: user.sex!,
                        onChanged: viewModel.updateGender,
                      ),
                      const SizedBox(height: 10),
                      _customRadioListTile(
                        title: '여자',
                        value: '여자',
                        groupValue: user.sex!,
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
                        child: SignupTextfield(
                          hintText: 'YYYY',
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          controller: viewModel.yearTEC,
                          onChanged: (value) {
                            final year = int.tryParse(value) ?? 2000;
                            viewModel.updateBirthDate(
                              DateTime(
                                year,
                                user.birthDate!.month,
                                user.birthDate!.day,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SignupTextfield(
                          hintText: 'MM',
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: viewModel.monthTEC,
                          onChanged: (value) {
                            final month = int.tryParse(value) ?? 1;
                            viewModel.updateBirthDate(
                              DateTime(
                                user.birthDate!.year,
                                month,
                                user.birthDate!.day,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: SignupTextfield(
                          hintText: 'DD',
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: viewModel.dayTEC,
                          onChanged: (value) {
                            final day = int.tryParse(value) ?? 1;
                            viewModel.updateBirthDate(
                              DateTime(
                                user.birthDate!.year,
                                user.birthDate!.month,
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
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 60),
          child: BottomWideButton(
            text: '가입하기',
            onTap: () => viewModel.submit(context),
          )),
    );
  }

  Widget _nameCheckResult(bool isOkay) {
    return Row(
      children: [
        Icon(
          isOkay ? Icons.check : Icons.close,
          color: isOkay ? AppColors.blue : AppColors.red,
        ),
        const SizedBox(width: 8),
        Text(
          isOkay ? '사용 가능한 닉네임입니다.' : '사용 불가한 닉네임입니다.',
          style: TextStyle(
            color: isOkay ? AppColors.blue : AppColors.red,
          ),
        ),
      ],
    );
  }

  Widget _emailCheckResult(bool isOkay) {
    return Row(
      children: [
        Icon(
          isOkay ? Icons.check : Icons.close,
          color: isOkay ? AppColors.blue : AppColors.red,
        ),
        const SizedBox(width: 8),
        Text(
          isOkay ? '사용 가능한 이메일입니다.' : '사용 불가한 이메일입니다.',
          style: TextStyle(
            color: isOkay ? AppColors.blue : AppColors.red,
          ),
        ),
      ],
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
