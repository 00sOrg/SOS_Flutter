import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sos/shared/models/user.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sos/shared/repositories/user_repository.dart';
import 'package:sos/shared/utils/log_util.dart';

class UserViewModel extends StateNotifier<User> {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final UserRepository userRepository = UserRepository();

  // 초기 User 상태를 기본값으로 설정
  UserViewModel()
      : super(User(
          name: 'Unknown',
          profilePicture: null,
          email: null,
          nickname: null,
          memberId: null,
        )) {
    _initialize();
  }

  Future<void> _initialize() async {
    final accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      final userId = decodedToken['id'];
      state = state.copyWith(memberId: userId);
    }

    await loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final user = await userRepository.getUserDetail();
    state = state.copyWith(
      memberId: state.memberId,
      name: user.name,
      email: user.email,
      nickname: user.nickname,
      profilePicture: user.profilePicture,
      sex: user.sex,
      height: user.height != null ? user.height.toString() : null,
      weight: user.weight != null ? user.weight.toString() : null,
      bloodType: user.bloodType,
      disease: user.disease,
      medication: user.medication,
      phoneNumber: user.phoneNumber,
      birthDate: user.birthDate,
    );
  }

  Future<void> updateUserLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await userRepository.postUserLocation(
        position.latitude, position.longitude);
  }

  Future<void> printDecodedToken() async {
    final accessToken = await secureStorage.read(key: 'access_token');

    if (accessToken != null) {
      try {
        Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);

        debugPrint('Decoded Token: $decodedToken');

        decodedToken.forEach((key, value) {
          debugPrint('$key: $value');
        });
      } catch (e) {
        LogUtil.e('Error decoding token: $e');
      }
    } else {
      LogUtil.e('No access token found');
    }
  }
}

final userViewModelProvider = StateNotifierProvider<UserViewModel, User>((ref) {
  return UserViewModel();
});
