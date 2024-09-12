import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_favorite_search_bar.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingFavoriteSearchPage extends ConsumerWidget {
  const SettingFavoriteSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingFavoriteViewModelProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(
        title: '즐겨찾는 지인 관리',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 33,
            width: double.infinity,
          ),
          const Text(
            '즐겨찾기 하고 싶은 지인의 닉네임을 입력해 주세요.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textGray,
              height: 1.2,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SettingFavoriteSearchBar(viewModel: viewModel),
        ],
      ),
    );
  }
}
