import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingFavoriteAddButton extends ConsumerWidget {
  const SettingFavoriteAddButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => ref
          .read(settingFavoriteViewModelProvider.notifier)
          .goToAddFavoritePage(context),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.25),
              offset: const Offset(1, 2),
              blurRadius: 2,
              spreadRadius: 0,
            )
          ],
        ),
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }
}
