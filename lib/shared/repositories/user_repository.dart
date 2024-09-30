// User repository
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/utils/http_helpers.dart';

class UserRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<User> getUserByNickname(String nickname) async {
    final url = Uri.parse('$baseUrl/members/search?nickname=$nickname');

    final accessToken = await secureStorage.read(key: 'access_token');

    final response = await makeGetRequestForSearch(url, "searchUserByNickname",
        accessToken: accessToken);

    if (response.statusCode != 200) {
      return User(id: -1, nickname: '사용자 없음');
    }

    final jsonResponse = jsonDecode(response.body);
    final userData = jsonResponse['data'];

    final user = User(
      id: userData['memberId'] as int,
      nickname: userData['memberNickname'] as String,
      profilePicture: userData['memberProfile'] as String?,
      address: userData['address'] as String,
    );

    return user;
  }
}
