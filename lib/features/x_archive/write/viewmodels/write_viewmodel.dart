import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos/shared/models/x_archive/x_post.dart';
import 'package:sos/shared/repositories/x_post_repository.dart';

class WriteViewModel extends StateNotifier<XPost> {
  final XPostRepository _repository;

  WriteViewModel(this._repository)
      : super(
          XPost(
            id: '',
            title: '',
            address: '',
            category: '',
            image: null,
            content: '',
            createdAt: DateTime.now(),
          ),
        );

  final ImagePicker _picker = ImagePicker();

  Future<void> createPost(String address) async {
    if (state.image != null) {
      final imageUrl = await _repository.uploadImage(File(state.image!));
      state = state.copyWith(image: imageUrl);
  }
    state = state.copyWith(address: address);  // address는 직접 입력 받는게 아니라 따로 추가해줌
    await _repository.createPost(state);
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateAddress(String address) {
    state = state.copyWith(address: address);
  }

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void updateContent(String content) {
    state = state.copyWith(content: content);
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(image: image.path);
    }
  }
}

final writeViewModelProvider = StateNotifierProvider<WriteViewModel, XPost>(
  (ref) {
    final repository = ref.watch(postRepositoryProvider);
    return WriteViewModel(repository);
  },
);
