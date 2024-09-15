import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/providers/secure_storage_provider.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class AuthRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;
  final FlutterSecureStorage secureStorage;

  AuthRepository(this.secureStorage);

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<void> setAccessToken(String token) async {
    await secureStorage.write(key: 'access_token', value: token);
  }

  Future<void> removeAccessToken() async {
    await secureStorage.delete(key: 'access_token');
  }

  Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await makePostRequest(url, body, 'loginUser');
      final token = jsonDecode(response.body)['data']['access_token'];
      await setAccessToken(token);
      return true;
    } catch (e) {
      LogUtil.e('loginUser 에러: $e');
      return false;
    }
  }

  Future<void> logoutUser() async {
    await removeAccessToken();
  }

  Future<bool> checkEmail(String email) async {
    final url = Uri.parse('$baseUrl/auth/check-email?email=$email');

    try {
      await makeGetRequest(url, 'checkEmail');
      return true;
    } catch (e) {
      LogUtil.e('checkEmail 에러: $e');
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

  Future<bool> signupUser(User user, String profilePicturePath) async {
    final fields = {
      'email': user.email,
      'password': user.password,
      'name': user.name,
      'nickname': user.nickname,
      'phoneNumber': user.phoneNumber,
      'sex': user.gender,
      'birthDate': user.birthDay.toIso8601String(),
    };

    final url = Uri.parse('$baseUrl/auth/register');

    try {
      await makeMultipartRequest(url, fields, 'signupUser', profilePicturePath);
      return true;
    } catch (e) {
      LogUtil.e('signupUser 에러: $e');
      return false;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final secureStorage = ref.read(secureStorageProvider);
  return AuthRepository(secureStorage);
});
