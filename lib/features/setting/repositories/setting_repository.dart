import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/auth/repositories/auth_repository.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class SettingRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final AuthRepository authRepository;

  // final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  SettingRepository(this.authRepository);

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
      // final accessToken = await secureStorage.read(key: 'access_token');
      final accessToken = await authRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception('Unauthorized: Access token 없음');
      }

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

  Future<bool> updateHealthInfo(
    String? height,
    String? weight,
    String? bloodType,
    String? disease,
    String? medication,
  ) async {
    final url = Uri.parse('$baseUrl/members/detail');
    final body = {
      'height': height,
      'weight': weight,
      'bloodType': bloodType,
      'disease': disease,
      'medication': medication,
    };

    LogUtil.d('Request fields: ${jsonEncode(body)}');

    try {
      final accessToken = await authRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception('Unauthorized: Access token 없음');
      }

      final response = await makePatchRequest(
        url,
        body,
        'updateHealthInfo',
        accessToken: accessToken,
      );
      LogUtil.d('updateHealthInfo 성공; ${jsonDecode(response.body.toString())}');
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error updating user health info: $e');
      return false;
    }
  }

  Future<List<Board>> getMyBoardList() async {
    final url = Uri.parse('$baseUrl/events');

    try {
      final accessToken = await authRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception('Unauthorized: Access token 없음');
      }

      final response = await makeGetRequest(
        url,
        'getMyBoardList',
        accessToken: accessToken,
      );

      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        final List events = responseBody['data']['events'];

        return events.map((event) => Board.fromJson(event)).toList();
      } else {
        throw Exception('My Board list fetch 실패');
      }
    } catch (e) {
      LogUtil.e('getMyBoardList 에러: $e');
      return [];
    }
  }
}

final settingRepositoryProvider = Provider<SettingRepository>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return SettingRepository(authRepository);
});
