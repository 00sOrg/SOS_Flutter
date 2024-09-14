import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/http_helpers.dart';

class PostRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<bool> getOnePostbyId(String id) async {
    final url = Uri.parse('$baseUrl/events/$id');

    return makeGetRequest(url, "getOnePostbyId");
  }
}
