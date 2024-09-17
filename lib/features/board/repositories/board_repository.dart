import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/auth/repositories/auth_repository.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class BoardRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final AuthRepository authRepository;

  BoardRepository(this.authRepository);

  Future<List<Board>> getBoardList() async {
    final url = Uri.parse('$baseUrl/events/feeds');

    try {
      final accessToken = await authRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception('Unauthorized: Access token 없음');
      }

      final response = await makeGetRequest(
        url,
        'getBoardList',
        accessToken: accessToken,
      );

      final responseBody = jsonDecode(response.body);
      if (responseBody['success'] == true) {
        final List events = responseBody['data']['events'];

        return events.map((event) => Board.fromJson(event)).toList();
      } else {
        throw Exception('Board list fetch 실패');
      }
    } catch (e) {
      LogUtil.e('getBoardList 에러: $e');
      return [];
    }
  }
}

final boardRepositoryProvider = Provider<BoardRepository>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return BoardRepository(authRepository);
});
