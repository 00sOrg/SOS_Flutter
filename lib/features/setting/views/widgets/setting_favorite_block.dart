import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/small_text_button.dart';

class SettingFavoriteBlock extends StatelessWidget {
  final Friend friend;
  final SettingFavoriteViewModel viewModel;

  const SettingFavoriteBlock({
    super.key,
    required this.friend,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: 136.w,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 51,
                child: (friend.profilePicture != null &&
                        friend.profilePicture!.isNotEmpty)
                    ? ClipOval(
                        child: Image.network(
                          friend.profilePicture!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/default_profile.png',
                        width: 76,
                      ),
              ),
              const SizedBox(width: 24),
              viewModel.isEditMode(friend.id) ? _inEditMode() : _inStaticMode(),
              const SizedBox(width: 6),
            ],
          ),
        ),
        Positioned(
          top: 10,
          left: 8,
          child: InkWell(
            onTap: () => viewModel.showDeleteModal(
              context: context,
              id: friend.id,
              name: friend.name,
            ),
            child: const Icon(
              Icons.close,
              color: AppColors.textGray,
              size: 22,
            ),
          ),
        )
      ],
    );
  }

  Widget _inStaticMode() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            friend.nickName ?? friend.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
            softWrap: true,
            textAlign: TextAlign.end,
          ),
          const SizedBox(height: 4, width: double.maxFinite),
          Text(
            friend.address,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textGray,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
            softWrap: true,
            textAlign: TextAlign.end,
          ),
          const Spacer(),
          SmallTextButton(
            text: '수정',
            onTap: () => viewModel.editFavorite(friend.id),
            buttonColor: const Color(0xFFFFFFFF),
            textColor: AppColors.blue,
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  Widget _inEditMode() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue, width: 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  TextField(
                    autofocus: true,
                    textAlign: TextAlign.end,
                    controller: viewModel.getNicknameTEC(friend.id),
                    autocorrect: false,
                    maxLength: 16,
                    maxLines: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: friend.name,
                      hintStyle: const TextStyle(
                        color: AppColors.textGray,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counterText: '',
                    ),
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 6,
                    child: Text(
                      '${viewModel.getNicknameTEC(friend.id).text.length}/16',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGray,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 9, width: double.maxFinite),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmallTextButton(
                text: '취소',
                onTap: () => viewModel.cancelEditFavorite(friend.id),
                buttonColor: const Color(0xFFFFFFFF),
                textColor: AppColors.black,
              ),
              const SizedBox(width: 16),
              SmallTextButton(
                text: '완료',
                onTap: () => viewModel.saveFavorite(friend.id, friend.name),
              ),
            ],
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
