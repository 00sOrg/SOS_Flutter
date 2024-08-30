import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos/shared/styles/global_styles.dart';

class ProfileImagePicker extends StatelessWidget {
  final String? profilePicture;
  final String? localImagePath;
  final void Function(String?) onImageSelected;

  const ProfileImagePicker({
    super.key,
    required this.profilePicture,
    required this.localImagePath,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imageProvider;

    if (localImagePath != null && localImagePath!.isNotEmpty) {
      imageProvider = FileImage(File(localImagePath!));
    } else if (profilePicture != null && profilePicture!.isNotEmpty) {
      imageProvider = NetworkImage(profilePicture!);
    } else {
      imageProvider = const AssetImage('assets/images/default_user.png');
    }

    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 48,
            backgroundImage: imageProvider,
          ),
          const Positioned(
            bottom: -3,
            right: -3,
            child: CircleAvatar(
              backgroundColor: AppColors.textGray,
              radius: 15,
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await _pickImage();
              },
              child: const Text('이미지 수정'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                onImageSelected(null);
                Navigator.of(context).pop();
              },
              isDestructiveAction: true,
              child: const Text('이미지 삭제'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      onImageSelected(image.path);
    }
  }
}
