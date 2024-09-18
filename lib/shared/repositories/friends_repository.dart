import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class FriendsRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<List<Friend>> getFriendsList() async {
    final url = Uri.parse('$baseUrl/members/favorites');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getFriendsList", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final favoritesData = jsonResponse['data']['favorites'] as List;

      return favoritesData.map((friend) => Friend.fromJson(friend)).toList();
    } catch (e) {
      LogUtil.e('getFriendsList 에러: $e');
      return [];
    }
  }

  Future<bool> addFriend(String nickname) async {
    final url = Uri.parse('$baseUrl/members/favorite/$nickname');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePostRequest(url, null, 'addFriend',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error adding friend: $e');
      return false;
    }
  }

  Future<bool> acceptFriendRequest(int requesterId) async {
    final url = Uri.parse('$baseUrl/members/favorite/accept/$requesterId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePostRequest(url, null, 'acceptFriendRequest',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error accept Friend Request: $e');
      return false;
    }
  }

  Future<bool> rejectFriendRequest(int requesterId) async {
    final url = Uri.parse('$baseUrl/members/favorite/reject/$requesterId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePostRequest(url, null, 'rejectFriendRequest',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error reject Friend Request: $e');
      return false;
    }
  }
}
