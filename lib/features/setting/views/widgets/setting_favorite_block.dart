import 'package:flutter/material.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/small_text_button.dart';

class SettingFavoriteBlock extends StatelessWidget {
  final Friend friend;
  final TextEditingController nicknameTEC;
  final bool isEditMode;
  final VoidCallback onEdit;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const SettingFavoriteBlock({
    super.key,
    required this.friend,
    required this.nicknameTEC,
    required this.isEditMode,
    required this.onEdit,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 142,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 10),
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
            backgroundImage: (friend.profilePicture != null &&
                    friend.profilePicture!.isNotEmpty)
                ? NetworkImage(friend.profilePicture!)
                : const AssetImage('assets/images/default_user.png'),
          ),
          const SizedBox(width: 35),
          isEditMode ? _inEditMode() : _inStaticMode(),
          const SizedBox(width: 6),
        ],
      ),
    );
  }

  Widget _inStaticMode() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            friend.name,
            style: const TextStyle(
              fontSize: 16,
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
              fontSize: 10,
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
            onTap: onEdit,
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
                    controller: nicknameTEC,
                    autocorrect: false,
                    maxLength: 16,
                    maxLines: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: friend.name,
                      hintStyle: const TextStyle(
                        color: AppColors.textGray,
                        fontSize: 14,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 6,
                    child: Text(
                      '${nicknameTEC.text.length}/16',
                      style: TextStyle(
                        fontSize: 12,
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
                text: '삭제',
                onTap: onDelete,
                buttonColor: const Color(0xFFFFFFFF),
                textColor: AppColors.black,
              ),
              const SizedBox(width: 16),
              SmallTextButton(
                text: '완료',
                onTap: onSave,
              ),
            ],
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
