import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sos/shared/models/user.dart';
import 'package:sos/shared/utils/http_helpers.dart';
import 'package:sos/shared/utils/log_util.dart';

class AuthRepository {
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<bool> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final body = {
      'email': email,
      'password': password,
    };

    return makePostRequest(url, body, 'loginUser');
  }

  Future<bool> checkEmail(String email) async {
    final url = Uri.parse('$baseUrl/auth/check-email?email=$email');
    return makeGetRequest(url, 'checkEmail');
  }

  Future<bool> checkNickname(String nickname) async {
    final url = Uri.parse('$baseUrl/auth/check-nickname?nickname=$nickname');
    return makeGetRequest(url, 'checkNickname');
  }

  Future<bool> signupUser(User user, String profilePicturePath) async {
    final url = Uri.parse('$baseUrl/auth/register');

    try {
      var request = http.MultipartRequest('POST', url);

      request.fields['email'] = user.email;
      request.fields['password'] = user.password;
      request.fields['name'] = user.name;
      request.fields['nickname'] = user.nickname;
      request.fields['phoneNumber'] = user.phoneNumber;
      request.fields['sex'] = user.gender;
      request.fields['birthDate'] = user.birthDay.toIso8601String();

      if (profilePicturePath.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('media', profilePicturePath));
      }

      final response = await request.send();
      final resData = await http.Response.fromStream(response);

      return handleResponse(resData, 'signupUser');
    } catch (e) {
      LogUtil.e('signupUser 에러: $e');
      return false;
    }
  }
}
