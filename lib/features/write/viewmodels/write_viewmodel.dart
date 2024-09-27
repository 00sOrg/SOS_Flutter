import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos/features/write/repositories/write_repository.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/log_util.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class WriteViewModel extends StateNotifier<Post> {
  final WriteRepository writeRepository;

  WriteViewModel(this.writeRepository)
      : super(
          Post(
            postId: -1,
            title: '',
            roadAddress: '',
            latitude: 0,
            longitude: 0,
            createdAt: DateTime.now(),
            mediaURL: null,
          ),
        );

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(mediaURL: image.path);
    }
  }

  void setCamImg(XFile image) {
    state = state.copyWith(mediaURL: image.path);
  }

  Future<void> takeImg(BuildContext context) async {
    // GoRouter.of(context).push('/custom-camera');
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      state = state.copyWith(mediaURL: image.path);
    }
  }

  void clearImagePicker() {
    state = state.copyWith(mediaURL: null);
  }

  Future<void> submitPost({
    required BuildContext context,
    required String title,
    String? content,
    required Location location,
    required PostType type,
  }) async {
    try {
      bool success = await writeRepository.submitPost(
        title: title,
        content: content ?? '',
        latitude: location.latitude,
        longitude: location.longitude,
        address: location.roadAddress,
        type: type,
        mediaFilePath: state.mediaURL,
      );
      if (success) {
        debugPrint('게시물 작성 성공');
        debugPrint('TODO: 작성 후 지도로 가서 작성한 게시물 보이게? 해야됨');
        clearImagePicker();
        GoRouter.of(context).go('/home');
      } else {
        debugPrint('게시물 작성 실패');
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(text: '게시물 작성에 실패했습니다'),
        );
      }
    } catch (e) {
      LogUtil.e('submitPost 에러: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: '게시물 작성 중 문제가 발생했습니다'),
      );
    }
  }

  @override
  void dispose() {
    clearImagePicker();
    super.dispose();
  }
}

final writeViewModelProvider =
    StateNotifierProvider<WriteViewModel, Post>((ref) {
  final writeRepository = ref.read(writeRepositoryProvider);
  return WriteViewModel(writeRepository);
});
