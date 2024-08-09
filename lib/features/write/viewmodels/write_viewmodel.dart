import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/models/post.dart';

class WriteViewModel extends StateNotifier<Post> {

  WriteViewModel()
      : super(
          Post(
            userName: '',
            content: '',
            createdAt: DateTime.now(),
          ),
        );

  void dummySubmitButtonTap(BuildContext context) {
    log('SUBIT PRESSED');
    GoRouter.of(context).go('/board');
  }
}

final writeViewModelProvider = StateNotifierProvider<WriteViewModel, Post>(
  (ref) {
    // final repository = ref.watch(postRepositoryProvider);
    return WriteViewModel();
  },
);
