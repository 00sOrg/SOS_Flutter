import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class PostRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<bool> getOnePostbyId(String id) async {
    final url = Uri.parse('$baseUrl/events/$id');

    try {
      await makeGetRequest(url, "getOnePostbyId");
      return true;
    } catch (e) {
      LogUtil.e('getOnePostbyId 에러: $e');
      return false;
    }
  }
}
