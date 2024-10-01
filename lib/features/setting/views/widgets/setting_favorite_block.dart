import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/setting/viewmodels/setting_favorite_viewmodel.dart';
import 'package:sos/features/setting/views/widgets/setting_favorite_add_button.dart';
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
            color: AppColors.finalGray,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
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
                backgroundImage: (friend.profilePicture != null &&
                        friend.profilePicture!.isNotEmpty)
                    ? NetworkImage(friend.profilePicture!)
                    : const AssetImage('assets/images/default_profile.png')
                        as ImageProvider,
              ),
              const SizedBox(width: 24),
              viewModel.isEditMode(friend.favoriteMemberId)
                  ? _inEditMode()
                  : _inStaticMode(),
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
              id: friend.favoriteMemberId,
              name: friend.modifiedNickname,
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
            friend.modifiedNickname ?? friend.nickname,
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
            friend.lastLocation!,
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
            onTap: () => viewModel.editFavorite(friend.favoriteMemberId),
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
                    controller:
                        viewModel.getNicknameTEC(friend.favoriteMemberId),
                    autocorrect: false,
                    maxLength: 16,
                    maxLines: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: friend.nickname,
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
                      '${viewModel.getNicknameTEC(friend.favoriteMemberId).text.length}/16',
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
                onTap: () =>
                    viewModel.cancelEditFavorite(friend.favoriteMemberId),
                buttonColor: const Color(0xFFFFFFFF),
                textColor: AppColors.black,
              ),
              const SizedBox(width: 16),
              SmallTextButton(
                text: '완료',
                onTap: () => viewModel.saveFavorite(
                    friend.favoriteMemberId, friend.modifiedNickname),
              ),
            ],
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}

class SettingNotFavoriteBlock extends StatelessWidget {
  final Friend friend;
  final SettingFavoriteViewModel viewModel;

  const SettingNotFavoriteBlock({
    super.key,
    required this.friend,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    // !isPending 은 검색 결과인 경우임
    bool isPending = friend.isAccepted == false;

    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: 136.w,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: AppColors.finalGray,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: isPending ? 0.2 : 1,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 51,
                  backgroundImage: (friend.profilePicture != null &&
                          friend.profilePicture!.isNotEmpty)
                      ? NetworkImage(friend.profilePicture!)
                      : const AssetImage('assets/images/default_profile.png')
                          as ImageProvider,
                ),
              ),
              const SizedBox(width: 24),
              Text(
                friend.modifiedNickname,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  color: isPending ? AppColors.black.withOpacity(0.2) : null,
                ),
                softWrap: true,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        isPending
            ? SizedBox(
                height: 136.w,
                child: const Center(
                  child: Text(
                    '즐겨찾기 요청 수락 대기중...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class SettingFavoriteBlockForEmpty extends StatelessWidget {
  const SettingFavoriteBlockForEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 136.w,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.finalGray,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Center(child: SettingFavoriteAddButton()),
    );
  }
}

Text textWhenEmpty() {
  return const Text(
    '즐겨찾는 지인을 추가해보세요!',
    style: TextStyle(
      height: 1.2,
      fontWeight: FontWeight.w400,
      fontSize: 14.4,
      color: AppColors.textGray,
    ),
  );
}
