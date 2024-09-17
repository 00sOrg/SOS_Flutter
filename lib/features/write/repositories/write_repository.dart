import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/auth/repositories/auth_repository.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class WriteRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final AuthRepository authRepository;

  WriteRepository(this.authRepository);

  Future<bool> submitPost({
    required String title,
    String? content,
    required double latitude,
    required double longitude,
    required String address,
    required PostType type,
    String? mediaFilePath,
  }) async {
    final url = Uri.parse('$baseUrl/events');
    final fields = {
      'title': title,
      'content': content ?? '',
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'address': address,
      'type': type.name,
    };

    try {
      final accessToken = await authRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception('Unauthorized: Access token 없음');
      }

      await makeMultipartRequest(
        url,
        fields,
        'submitPost',
        mediaFilePath,
        accessToken: accessToken,
      );
      return true;
    } catch (e) {
      LogUtil.e('submitPost 에러: $e');
      return false;
    }
  }
}

final writeRepositoryProvider = Provider<WriteRepository>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return WriteRepository(authRepository);
});
