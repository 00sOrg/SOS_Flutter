import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/write/viewmodels/write_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class WriteSubmitBtn extends ConsumerWidget {
  const WriteSubmitBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final writeViewModel = ref.read(writeViewModelProvider.notifier);

    return InkWell(
      onTap: () {
        writeViewModel.dummySubmitButtonTap(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text(
          '등록하기',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
