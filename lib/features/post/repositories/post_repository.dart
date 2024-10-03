import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class PostRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<Post> getOnePostbyId(int postId) async {
    final url = Uri.parse('$baseUrl/events/$postId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getOnePostbyId", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final postData = jsonResponse['data'];

      return Post.fromJson(postData);
    } catch (e) {
      LogUtil.e('getOnePostbyId 에러: $e');
      return Post(postId: 0, title: '', createdAt: DateTime.now());
    }
  }

  Future<bool> addCommentToPost(int postId, String comment) async {
    final url = Uri.parse('$baseUrl/events/comment');
    final body = {'eventId': postId, 'content': comment};

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePostRequest(url, body, 'addCommentToPost',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error adding comment: $e');
      return false;
    }
  }

  Future<bool> likePost(int postId) async {
    final url = Uri.parse('$baseUrl/events/like/$postId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePostRequest(url, null, 'likePost',
          accessToken: accessToken); // No body required
      final jsonResponse = jsonDecode(response.body);
      final postData = jsonResponse['data'];

      return postData['isLiked'] ?? false;
    } catch (e) {
      LogUtil.e('Error liking post: $e');
      return false;
    }
  }

  Future<List<Post>> getPostsByKeyword(String keyword) async {
    final url = Uri.parse('$baseUrl/events/map/search?keyword=$keyword');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response =
          await makeGetRequest(url, 'getPostsForMap', accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final events = jsonResponse['data']['events'] as List<dynamic>;
      final posts = events.map((event) => Post.fromJson(event)).toList();

      return posts;
    } catch (e) {
      LogUtil.e('Error getting posts for map: $e');
      return [];
    }
  }

  Future<List<Post>> getAllNearbyPosts(
      double latitude, double longitude) async {
    final url =
        Uri.parse('$baseUrl/events/nearby/all?lat=$latitude&lng=$longitude');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await makeGetRequest(url, "getAllNearbyPosts",
          accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final events = jsonResponse['data']['events'] as List<dynamic>;

      final posts = events.map((event) => Post.fromJson(event)).toList();

      return posts;
    } catch (e) {
      LogUtil.e('getAllNearbyPosts 에러: $e');
      return [];
    }
  }

  Future<List<Post>> getPostsForMap(
      String level, double latitude, double longitude, int zoom) async {
    if (!['primary', 'secondary', 'all'].contains(level)) {
      LogUtil.e('Invalid level: $level');
      return []; // Return null if the level is invalid
    }

    final url = Uri.parse(
        '$baseUrl/events/map?level=$level&lat=$latitude&lng=$longitude&zoom=$zoom');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getPostsForMap", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final events = jsonResponse['data']['events'] as List<dynamic>;
      final posts = events.map((event) => Post.fromJson(event)).toList();

      return posts;
    } catch (e) {
      LogUtil.e('getPostsForMap 에러: $e');
      return [];
    }
  }

  Future<Post> getPostOverviewById(int postId) async {
    final url = Uri.parse('$baseUrl/events/$postId/overview');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await makeGetRequest(url, "getPostOverviewById",
          accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final postData = jsonResponse['data'];

      return Post.fromJson(postData);
    } catch (e) {
      LogUtil.e('getPostOverviewById 에러: $e');
      return Post(postId: 0, title: '', createdAt: DateTime.now());
    }
  }

  Future<bool> deletePostById(int postId) async {
    final url = Uri.parse('$baseUrl/events/$postId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await makeDeleteRequest(url, "deletePostById",
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('deletePostById 에러: $e');
      return false;
    }
  }

  Future<bool> deleteCommentById(int commentId) async {
    final url = Uri.parse('$baseUrl/events/comment/$commentId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await makeDeleteRequest(url, "deleteCommentById",
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('deleteCommentById 에러: $e');
      return false;
    }
  }
}

final postRepositoryProvider = Provider<PostRepository>((ref) {
  // PostRepository의 인스턴스를 반환
  return PostRepository();
});
