import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/write/viewmodels/write_viewmodel.dart';
import 'package:sos/features/write/views/widgets/write_cautions_block.dart';
import 'package:sos/features/write/views/widgets/write_submit_btn.dart';
import 'package:sos/features/write/views/widgets/write_image_picker.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/location_viewmodel.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _contentTEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _contentTEC.addListener(_handleContentChange);
  }

  @override
  void dispose() {
    _contentTEC.removeListener(_handleContentChange);
    _titleTEC.dispose();
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
    final viewModel = ref.watch(writeViewModelProvider.notifier);
    final location = ref.watch(locationProvider);

    return KeyboardDismisser(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: '사건/사고 게시물 작성',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            children: [
              _topArea(location),
              const SizedBox(height: 14),
              Expanded(child: _contentField()),
              if (_contentTEC.text.isEmpty) const WriteCautionsBlock(),
              const SizedBox(height: 16),
              WriteSubmitBtn(
                onTap: () async {
                  location.whenData(
                    (loc) {
                      viewModel.submitPost(
                        context: context,
                        title: _titleTEC.text,
                        content: _contentTEC.text,
                        location: loc,
                        type: PostType.other, // TODO: UI 구현 후 api 붙이기
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topArea(AsyncValue<Location> location) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WriteImagePicker(),
        const SizedBox(width: 16),
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
              location.when(
                data: (location) => Text(
                  location.roadAddress,
                  style: const TextStyle(fontSize: 14, height: 1.2),
                ),
                loading: () => const Text(
                  '주소를 가져오고 있어요',
                  style: TextStyle(fontSize: 14, height: 1.2),
                ),
                error: (error, stack) => Text('주소 오류: $error'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _titleField() {
    return TextField(
      controller: _titleTEC,
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
