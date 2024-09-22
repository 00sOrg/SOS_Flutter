import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sos/shared/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sos/shared/utils/log_util.dart';

// JWT token을 이용하여 payload를 decode하여 사용자 정보를 가져오는 방식으로 변경
class UserViewModel extends StateNotifier<User?> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  UserViewModel() : super(null);

  Future<User> loadUserInfo() async {
    final accessToken = await secureStorage.read(key: 'access_token');
    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

      final user = User(
        name: decodedToken['name'],
        profilePicture: decodedToken['profilePicture'],
        email: decodedToken['email'],
        nickname: decodedToken['nickname'],
      );

      state = user;

      return user;
    } else {
      LogUtil.e('No access token found');
      return User(name: '사용자를 찾을 수 없습니다.');
    }
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, User?>((ref) {
  return UserViewModel();
});
