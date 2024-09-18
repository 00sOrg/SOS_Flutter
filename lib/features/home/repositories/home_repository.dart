import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class HomeRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<List<Post>?> getAllNearbyPosts(
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
      return null;
    }
  }
}
