import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class RescueRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage;

  RescueRepository(this.secureStorage);

  Future<bool> requestHelp(double lat, double lng) async {
    final url = Uri.parse('$baseUrl/alarm/help/request');
    final body = {
      'lat': lat.toString(),
      'lng': lng.toString(),
    };

    try {
      final accessToken = await secureStorage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception('Access token is missing');
      }

      final response = await makePostRequest(url, body, 'requestHelp',
          accessToken: accessToken);
      return response.statusCode == 200;
    } catch (e) {
      LogUtil.e('Error requesting help: $e');
      return false;
    }
  }
}

final rescueRepositoryProvider = Provider<RescueRepository>((ref) {
  return RescueRepository(const FlutterSecureStorage());
});