import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/write/viewmodels/write_viewmodel.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF0066FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
          '등록하기',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}