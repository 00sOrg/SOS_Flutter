import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sos/shared/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sos/shared/repositories/user_repository.dart';
import 'package:sos/shared/utils/log_util.dart';

// JWT token을 이용하여 payload를 decode하여 사용자 정보를 가져오는 방식으로 변경
class UserViewModel extends StateNotifier<User> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final UserRepository userRepository = UserRepository();

  // 초기 User 상태를 기본값으로 설정
  UserViewModel()
      : super(User(
          name: 'Unknown',
          profilePicture: null,
          email: null,
          nickname: null,
        ));

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

  Future<void> updateUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await userRepository.postUserLocation(
        position.latitude, position.longitude);
  }
}

final userViewModelProvider =
    StateNotifierProvider<UserViewModel, User?>((ref) {
  return UserViewModel();
});
