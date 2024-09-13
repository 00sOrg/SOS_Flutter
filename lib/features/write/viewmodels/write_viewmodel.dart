import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:sos/shared/models/post.dart';

class WriteViewModel extends StateNotifier<Post> {
  WriteViewModel()
      : super(
          Post(
            postId: -1,
            title: '',
            createdAt: DateTime.now(),
            roadAddress: '',
            latitude: 0,
            longitude: 0,
          ),
        );

  Future<void> submitPost(BuildContext context, String title, String content,
      double latitude, double longitude, File? mediaFile) async {
    //
  }
}

final writeViewModelProvider =
    StateNotifierProvider<WriteViewModel, Post>((ref) {
  return WriteViewModel();
});
