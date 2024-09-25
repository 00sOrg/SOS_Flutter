import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    String? profilePicture,
    int? id,
    String? name,
    String? password,
    String? email,
    String? nickname,
    String? phoneNumber,
    String? gender,
    DateTime? birthDay,
    String? address,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
