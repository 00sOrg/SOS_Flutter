import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_favorite_add_button.dart';
import 'package:sos/features/setting/views/widgets/setting_favorite_block.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingFavoritePage extends ConsumerWidget {
  const SettingFavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(settingFavoriteViewModelProvider.notifier);
    final friends = ref.watch(settingFavoriteViewModelProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: '즐겨찾는 지인 관리',
      ),
      body: KeyboardDismisser(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 33),
            child: Column(
              children: [
                if (friends.isEmpty) ...[
                  const SettingFavoriteBlockForEmpty(),
                  const SizedBox(height: 26),
                  textWhenEmpty(),
                ] else ...[
                  ...friends.map(
                    (friend) => SettingFavoriteBlock(
                      friend: friend,
                      viewModel: viewModel,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SettingFavoriteAddButton(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
