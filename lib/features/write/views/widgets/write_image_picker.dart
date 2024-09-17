import 'dart:io';
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
        await viewModel.pickImage();
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
              width: 87,
              height: 87,
              fit: BoxFit.contain,
            ),
    );
  }
}
