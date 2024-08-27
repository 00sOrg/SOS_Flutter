import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/write/views/widgets/write_cautions_block.dart';
import 'package:sos/features/write/views/widgets/write_submit_btn.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final TextEditingController _contentTEC = TextEditingController();
  final dummyAdress = '서울시 서초구 서초동';
  final dummyImg = 'https://picsum.photos/180/300';

  @override
  void initState() {
    super.initState();
    _contentTEC.addListener(_handleContentChange);
  }

  @override
  void dispose() {
    _contentTEC.removeListener(_handleContentChange);
    _contentTEC.dispose();
    super.dispose();
  }

  void _handleContentChange() {
    setState(() {
      // 텍스트필드 내용 변하면 리빌드 트리거함
    });
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = ref.watch(writeViewModelProvider.notifier);
    return KeyboardDismisser(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: '사건/사고 게시물 작성',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
          child: Column(
            children: [
              _topArea(),
              const SizedBox(height: 13),
              Expanded(child: _contentField()),
              if (_contentTEC.text.isEmpty) const WriteCautionsBlock(),
              const SizedBox(height: 16),
              const WriteSubmitBtn(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(dummyImg),
              fit: BoxFit.cover,
            ),
          ),
          width: 87.w,
          height: 87.w,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleField(),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 7),
                child: Container(
                  height: 0.5,
                  color: AppColors.lineGray,
                ),
              ),
              Text(
                dummyAdress,
                style: const TextStyle(fontSize: 14, height: 1.2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _titleField() {
    return TextField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      maxLines: 1,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.only(top: 5),
        hintText: '제목',
        hintStyle: AppTexts.titleStyle.copyWith(color: AppColors.textGray),
        border: InputBorder.none,
      ),
      style: AppTexts.titleStyle,
      onTap: () {},
    );
  }

  Widget _contentField() {
    return TextField(
      controller: _contentTEC,
      keyboardType: TextInputType.multiline,
      autocorrect: false,
      minLines: 2,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: '내용을 입력하세요.',
        hintStyle: AppTexts.bodyStyle.copyWith(color: AppColors.textGray),
        border: InputBorder.none,
      ),
      style: AppTexts.bodyStyle.copyWith(height: 1.3125),
      onTap: () {},
    );
  }
}
