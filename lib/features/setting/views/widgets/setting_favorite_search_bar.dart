import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class SettingFavoriteSearchBar extends StatelessWidget {
  final SettingFavoriteViewModel viewModel;

  const SettingFavoriteSearchBar({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchTEC = TextEditingController();

    return SizedBox(
      height: 42,
      width: 251.w,
      child: TextField(
        controller: searchTEC,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
          border: AppBorders.thickBlueBorder,
          focusedBorder: AppBorders.thickBlueBorder,
          enabledBorder: AppBorders.thickGrayBorder,
          filled: true,
          fillColor: AppColors.white.withOpacity(0.7),
          suffixIcon: GestureDetector(
            onTap: () => viewModel.searchFriend(context, searchTEC.text),
            child: const Icon(Icons.search, size: 26),
          ),
          // suffixIcon: SvgPicture.asset('assets/icons/search.svg')),
        ),
        cursorHeight: 20,
        autocorrect: false,
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.1,
        ),
      ),
    );
  }
}
