import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class SettingRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Todo: 사용자 정보 수정에 연결
  Future<bool> updateUserInfo(String? nickname, String? password, String? sex,
      DateTime? birthDate, String? media) async {
    final url = Uri.parse('$baseUrl/members/update');
    final body = {
      'nickname': nickname,
      'password': password,
      'sex': sex,
      'birthDate': birthDate?.toIso8601String(),
      'media': media,
    };

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePatchRequest(url, body, 'postReadAlarm',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error updating user info: $e');
      return false;
    }
  }
}
