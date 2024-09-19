import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/write/viewmodels/write_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class WriteImagePicker extends ConsumerWidget {
  const WriteImagePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(writeViewModelProvider.notifier);
    final post = ref.watch(writeViewModelProvider);

    return InkWell(
      onTap: () async {
        if (post.mediaURL == null) {
          await viewModel.pickImage();
        } else {
          _showBottomSheet(context, viewModel);
        }
      },
      child: (post.mediaURL == null)
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.finalGray,
              ),
              width: 87.w,
              height: 87.w,
              child: const Icon(
                Icons.add_photo_alternate_outlined,
                color: AppColors.textGray,
                size: 50,
              ),
            )
          : Image.file(
              File(post.mediaURL!),
              width: 87.w,
              height: 87.w,
              fit: BoxFit.contain,
            ),
    );
  }

  void _showBottomSheet(BuildContext context, WriteViewModel viewModel) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await viewModel.pickImage();
              },
              child: const Text('이미지 수정'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                viewModel.clearImagePicker();
                Navigator.of(context).pop();
              },
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
}
