import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/write/viewmodels/write_viewmodel.dart';
import 'package:sos/features/write/views/image_check_page.dart';
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
          _showBottomSheet(context, viewModel, ref);
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
                size: 46,
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

  void _showBottomSheet(
    BuildContext context,
    WriteViewModel viewModel,
    WidgetRef ref,
  ) {
    final post = ref.watch(writeViewModelProvider);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            if (post.mediaURL != null)
              CupertinoActionSheetAction(
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageCheckPage(
                        imagePath: post.mediaURL!,
                        viewOnly: true,
                      ),
                    ),
                  );
                },
                child: const Text('사진 보기'),
              ),
            // CupertinoActionSheetAction(
            //   onPressed: () async {
            //     Navigator.of(context).pop();
            //     await viewModel.takeImg(context);
            //   },
            //   child: const Text('사진 촬영'),
            // ),
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.of(context).pop();
                await viewModel.pickImage();
              },
              child: const Text('갤러리'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                viewModel.clearImagePicker();
                Navigator.of(context).pop();
              },
              child: const Text('사진 삭제'),
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
