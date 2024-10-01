import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class PostRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<Post> getOnePostbyId(String postId) async {
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

  // events/map/search -> TODO: 어떻게 검색으로 띄울지 고민
  Future<List<Post>> getPostsForMap(String keyword) async {
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
}
