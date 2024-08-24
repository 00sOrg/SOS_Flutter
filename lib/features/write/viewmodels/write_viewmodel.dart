import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/models/comment.dart';

class WriteViewModel extends StateNotifier<Comment> {
  WriteViewModel()
      : super(
          Comment(
            postId: 0,
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

final writeViewModelProvider = StateNotifierProvider<WriteViewModel, Comment>(
  (ref) {
    // final repository = ref.watch(postRepositoryProvider);
    return WriteViewModel();
  },
);
