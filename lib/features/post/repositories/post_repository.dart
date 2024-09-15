import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class PostRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<Post?> getOnePostbyId(String id) async {
    final url = Uri.parse('$baseUrl/events/$id');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getOnePostbyId", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final postData = jsonResponse['data'];

      return Post.fromJson(postData);
    } catch (e) {
      LogUtil.e('getOnePostbyId 에러: $e');
      return null;
    }
  }
}
