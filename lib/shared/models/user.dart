import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    String? profilePicture,
    required String name,
    required String email,
    required String password,
    required String nickname,
    required String phoneNumber,
    required String gender,
    required DateTime birthDay,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
