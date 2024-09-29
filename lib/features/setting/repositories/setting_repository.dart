import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class SettingRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  // Todo: 사용자 정보 수정에 연결
  Future<bool> updateUserInfo(String? nickname, String? password, String? sex,
      DateTime? birthDate, String? media) async {
    final url = Uri.parse('$baseUrl/members/update');
    final body = {
      'nickname': nickname,
      'password': password,
      'sex': sex,
      'birthDate': birthDate?.toIso8601String(),
    };

    LogUtil.d('Request fields: ${jsonEncode(body)}');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response = await makeMultipartRequest(
        url,
        body,
        'updateUserProfile',
        media,
        method: 'PATCH',
        accessToken: accessToken,
      );
      LogUtil.d('updateUserinfo 성공; ${jsonDecode(response.body.toString())}');
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error updating user info: $e');
      return false;
    }
  }

  Future<bool> checkNickname(String nickname) async {
    final url = Uri.parse('$baseUrl/auth/check-nickname?nickname=$nickname');

    try {
      await makeGetRequest(url, 'checkNickname');
      return true;
    } catch (e) {
      LogUtil.e('checkEmail 에러: $e');
      return false;
    }
  }
}
