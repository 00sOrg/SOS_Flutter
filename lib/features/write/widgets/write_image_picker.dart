import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nearhere/features/write/viewmodels/write_viewmodel.dart';
import 'package:nearhere/shared/widgets/gradient_container.dart';

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
      child: (post.image == null)
          ? GradientContainer(
              showRefreshBtn: false,
              borderRadius: BorderRadius.circular(8),
              borderStyle: Border.all(color: const Color(0xFFEDEDED), width: 2),
              child: const SizedBox(
                width: double.infinity,
                height: 240,
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.white,
                  size: 72,
                ),
              ),
            )
          : Image.file(
              File(post.image!),
              width: double.infinity,
              height: 240,
              fit: BoxFit.contain,
            ),
    );
  }
}