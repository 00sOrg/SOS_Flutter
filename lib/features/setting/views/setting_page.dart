import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/setting/viewmodels/setting_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingState = ref.watch(settingViewModelProvider);
    final settingViewModel = ref.read(settingViewModelProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(
        title: '설정',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Column(
          children: [
            settingSwitchTile(
              title: '알림 설정',
              value: settingState.isNotificationEnabled,
              onChanged: (value) => settingViewModel.toggleNotification(value),
            ),
            settingTile(
                title: '회원 정보 수정',
                onTap: () => settingViewModel.goToEditProfile(context)),
            settingTile(
                title: '건강 정보 등록 및 수정',
                onTap: () => settingViewModel.goToHealthInfo(context)),
            settingTile(
                title: '즐겨찾는 지인 관리',
                onTap: () => settingViewModel.goToFavorites(context)),
            settingTile(title: '계정 삭제', onTap: () {}),
            settingTile(title: '로그아웃', onTap: () {}),
          ],
        ),
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
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lineGray,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            SizedBox(
              height: 10,
              child: CupertinoSwitch(
                value: value,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget settingTile({
  required String title,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lineGray,
          ),
        ),
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
    ),
  );
}
