import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/write/views/widgets/write_cautions_block.dart';
import 'package:sos/features/write/views/widgets/write_submit_btn.dart';

class WritePage extends ConsumerWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final viewModel = ref.watch(writeViewModelProvider.notifier);

    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: const Text(
            '사건/사고 게시물 작성',
            style: TextStyle(fontSize: 17),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Divider(height: 1, thickness: 1),
                const SizedBox(height: 21),
                titleField(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    height: 1.3,
                    color: const Color(0xFFE9E9E9),
                  ),
                ),
                contentField(),
                const SizedBox(height: 300),
                const WriteCautionsBlock(),
                const SizedBox(height: 24),
                const WriteSubmitBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleField() {
    return TextField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      maxLines: 1,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        hintText: '제목',
        hintStyle: TextStyle(
          fontSize: 16,
          color: Color(0xFFB6B6B6),
          fontWeight: FontWeight.w700,
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: Color(0xFF060606),
        fontWeight: FontWeight.w700,
      ),
      onTap: () {},
    );
  }

  Widget contentField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      autocorrect: false,
      minLines: 2,
      maxLines: null,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        hintText: '내용을 입력하세요.',
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFFB6B6B6),
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF060606),
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
      onTap: () {},
    );
  }
}
