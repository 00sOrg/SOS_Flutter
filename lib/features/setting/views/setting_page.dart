import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/setting/viewmodels/setting_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/user_profile_field.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/user_viewmodel.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';
import 'package:sos/shared/widgets/custom_switch.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingState = ref.watch(settingViewModelProvider);
    final settingViewModel = ref.read(settingViewModelProvider.notifier);

    // User 정보를 로드
    ref.read(userViewModelProvider.notifier).loadUserInfo();

    return Scaffold(
      appBar: const CustomAppBar(
        title: '설정',
        hasLeading: false,
      ),
      body: Column(
        children: [
          // UserProfileField에 패딩 적용
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: UserProfileField(
              onPressed: () => settingViewModel.goToEditProfile(context),
            ),
          ),
          // Divider 추가
          const Divider(
            color: AppColors.finalGray,
            height: 2,
            thickness: 8,
          ),
          // 아래 내용에 패딩 적용
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  settingSwitchTile(
                    title: '알림 설정',
                    value: settingState.isNotificationEnabled,
                    onChanged: (value) =>
                        settingViewModel.toggleNotification(value),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  settingTile(
                    title: '내 게시글',
                    onTap: () => settingViewModel.goToMyPosts(context),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  settingTile(
                    title: '건강 정보 등록 및 수정',
                    onTap: () => settingViewModel.goToHealthInfo(context),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  settingTile(
                    title: '즐겨찾는 지인 관리',
                    onTap: () => settingViewModel.goToFavorites(context),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  settingTile(
                    title: '계정 삭제',
                    onTap: () =>
                        settingViewModel.showDeleteAccountModal(context),
                  ),
                  const SizedBox(height: 10), // 간격 추가
                  settingTile(
                    title: '로그아웃',
                    onTap: () => settingViewModel.showLogoutModal(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget settingSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.textGray.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            CustomSwitch(
              isOn: value,
              onTap: () => onChanged(!value),
            ),
          ],
        ),
      ),
    );
  }

  Widget settingTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.textGray.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
