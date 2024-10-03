// User repository
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class UserRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<User> getUserByNickname(String nickname) async {
    final url = Uri.parse('$baseUrl/members/search?nickname=$nickname');

    final accessToken = await secureStorage.read(key: 'access_token');

    final response = await makeGetRequestForSearch(url, "searchUserByNickname",
        accessToken: accessToken);

    if (response.statusCode != 200) {
      return User(memberId: -1, nickname: '사용자 없음');
    }

    final jsonResponse = jsonDecode(response.body);
    final userData = jsonResponse['data'];

    final user = User(
      memberId: userData['memberId'] as int,
      nickname: userData['memberNickname'] as String,
      profilePicture: userData['memberProfile'] as String?,
      address: userData['address'] as String,
    );

    return user;
  }

  Future<bool> postUserLocation(double latitude, double longitude) async {
    try {
      final url = Uri.parse(
          '$baseUrl/members/location/update?lat=$latitude&lng=$longitude');

      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await makePostRequest(url, null, "postUserLocation",
          accessToken: accessToken);

      if (response.statusCode != 200) {
        return false;
      }

      return true;
    } catch (e) {
      // Handle the error appropriately here
      LogUtil.e('Error posting user location: $e');
      return false;
    }
  }

  Future<User> getUserById(int id) async {
    final url = Uri.parse('$baseUrl/members/$id');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getUserById", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final user = User.fromJson(jsonResponse['data']);

      return user;
    } catch (e) {
      LogUtil.e('getUserById 에러: $e');
      return User(memberId: -1, nickname: '사용자 없음');
    }
  }

  Future<User> getUserDetail() async {
    final url = Uri.parse('$baseUrl/members/detail');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getUserDetail", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final user = User.fromJson(jsonResponse['data']);

      return user;
    } catch (e) {
      LogUtil.e('getUserDetail 에러: $e');
      return User(memberId: -1, nickname: '사용자 없음');
    }
  }
}
