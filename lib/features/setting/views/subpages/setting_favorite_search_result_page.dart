import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_favorite_block.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingFavoriteSearchResultPage extends ConsumerWidget {
  const SettingFavoriteSearchResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingFavoriteViewModelProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(
        title: "즐겨찾는 지인 관리"
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 33),
        child: Column(
          children: [
            SettingNotFavoriteBlock(
              viewModel: viewModel,
              friend: viewModel.dummySearchResultFriend,
            ),
            const SizedBox(height: 59),
            GestureDetector(
              onTap: () => viewModel
                  .requestFavorite(context, viewModel.dummySearchResultFriend.id),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 12,
                ),
                child: const Text(
                  '즐겨찾기 추가 요청 보내기',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
