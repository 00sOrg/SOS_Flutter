import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/alarm.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class AlarmRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<List<Alarm>> getAlarms() async {
    final url = Uri.parse('$baseUrl/alarm');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');

      final response =
          await makeGetRequest(url, "getAlarms", accessToken: accessToken);
      final jsonResponse = jsonDecode(response.body);
      final notifications =
          jsonResponse['data']['notifications'] as List<dynamic>;

      final alarms = notifications
          .map((notification) => Alarm.fromJson(notification))
          .toList();

      return alarms;
    } catch (e) {
      LogUtil.e('getAlarms 에러: $e');
      return [];
    }
  }

  Future<bool> patchReadAlarm(int alarmId) async {
    final url = Uri.parse('$baseUrl/alarm/$alarmId');

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      final response = await makePatchRequest(url, null, 'postReadAlarm',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error postReadAlarm: $e');
      return false;
    }
  }
}
