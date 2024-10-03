import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/write/viewmodels/write_viewmodel.dart';
import 'package:sos/features/write/views/widgets/write_cautions_block.dart';
import 'package:sos/features/write/views/widgets/write_choice_chip.dart';
import 'package:sos/features/write/views/widgets/write_submit_btn.dart';
import 'package:sos/features/write/views/widgets/write_image_picker.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/location_viewmodel.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class WritePage extends ConsumerStatefulWidget {
  final XFile? camImg;
  const WritePage({this.camImg, super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _contentTEC = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  PostType _selectedPostType = PostType.none;
  bool _isSubmitting = false; // 버튼이 눌렸는지 여부를 추적하는 플래그

  @override
  void initState() {
    super.initState();
    _contentTEC.addListener(_handleContentChange);
    _contentFocusNode.addListener(_handleContentChange);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.camImg != null) {
        ref.read(writeViewModelProvider.notifier).setCamImg(widget.camImg!);
      } else {
        debugPrint('No image from custom camera');
      }
    });
  }

  @override
  void dispose() {
    _contentTEC.removeListener(_handleContentChange);
    _contentFocusNode.removeListener(_handleFocusChange);
    _contentFocusNode.dispose();
    _titleTEC.dispose();
    _contentTEC.dispose();
    super.dispose();
  }

  void _handleContentChange() {
    setState(() {
      // 텍스트필드 내용 변하면 리빌드 트리거함
    });
  }

  void _handleFocusChange() {
    setState(() {
      // 리빌드 트리거
    });
  }

  void _onPostTypeSelected(PostType postType) {
    setState(() {
      if (_selectedPostType == postType) {
        _selectedPostType = PostType.none;
      } else {
        _selectedPostType = postType;
      }
    });
  }

  void _submitPost(AsyncValue<Location> location, WriteViewModel viewModel,
      BuildContext context) async {
    if (_isSubmitting) return; // 이미 제출 중이라면 중복 처리 방지
    setState(() {
      _isSubmitting = true; // 제출 중 상태로 변경
    });

    location.whenData((loc) async {
      await viewModel.submitPost(
        context: context,
        title: _titleTEC.text,
        content: _contentTEC.text,
        location: loc,
        type: _selectedPostType,
      );

      setState(() {
        _isSubmitting = false; // 제출 완료 후 다시 버튼 활성화
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(writeViewModelProvider.notifier);
    final location = ref.watch(locationViewModelProvider);

    return KeyboardDismisser(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: '사건/사고 게시물 작성',
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              children: [
                _topArea(location),
                const SizedBox(height: 14),
                _buildPostTypeButtons(),
                const SizedBox(height: 16),
                Expanded(child: _contentField()),
                // if (_contentTEC.text.isEmpty) const WriteCautionsBlock(),
                if (!_contentFocusNode.hasFocus && !_contentTEC.text.isNotEmpty)
                  const WriteCautionsBlock(),
                // const SizedBox(height: 16),
                // if (_contentTEC.text.isNotEmpty) _buildPostTypeButtons(),
                const SizedBox(height: 25),
                WriteSubmitBtn(
                  onTap: _isSubmitting // 제출 중일 때는 비활성화
                      ? () {}
                      : () => _submitPost(location, viewModel, context),
                ),
                const SizedBox(height: 16),
              ],
            ),
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
      focusNode: _contentFocusNode,
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

  Widget _buildPostTypeButtons() {
    const List<String> postTypeTexts = [
      '사고',
      '화재',
      '태풍',
      '지진',
      '전쟁',
      '홍수',
      '교통사고',
      // '기타'
    ];
    const List<PostType> postTypes = [
      PostType.accident,
      PostType.fire,
      PostType.typhoon,
      PostType.earthquake,
      PostType.war,
      PostType.flood,
      PostType.carAccident,
      // PostType.other,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(postTypes.length, (idx) {
          final isSelected = _selectedPostType == postTypes[idx];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: WriteChoiceChip(
              label: postTypeTexts[idx],
              isSelected: isSelected,
              onSelected: (bool selected) {
                _onPostTypeSelected(postTypes[idx]);
              },
            ),
          );
        }),
      ),
    );
  }
}
