import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/x_archive/x_post.dart';

class XPostRepository {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: dotenv.env['BASE_URL']!),
  );

  Future<List<XPost>> getPosts() async {
    final response = await _dio.get('/posts');
    return (response.data as List).map((post) => XPost.fromJson(post)).toList();
  }

  Future<XPost> getPost(String id) async {
    final response = await _dio.get('/posts/$id');
    return XPost.fromJson(response.data);
  }

  Future<XPost> createPost(XPost post) async {
    final response = await _dio.post(
      '/posts',
      data: post.toJson(),
    );
    return XPost.fromJson(response.data);
  }

  Future<void> deletePost(String id) async {
    await _dio.delete('/posts/$id');
  }

  Future<String> uploadImage(File imageFile) async {
    final formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(imageFile.path),
      },
    );
    final response = await _dio.post('/upload', data: formData);
    return response.data['url'];
  }

  Future<void> confirmImageAvailability(String imageUrl) async {
    bool imageAvailable = false;
    for (int i = 0; i < 5; i++) {
      try {
        final response = await _dio.head(imageUrl);
        if (response.statusCode == 200) {
          imageAvailable = true;
          break;
        }
      } catch (e) {
        // Wait and retry
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    if (!imageAvailable) {
      throw Exception('Image not available after upload.');
    }
  }
}

final postRepositoryProvider = Provider((ref) => XPostRepository());
