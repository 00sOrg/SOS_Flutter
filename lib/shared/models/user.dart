import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

//User id -1은 사용자가 없음을 의미합니다.
@freezed
class User with _$User {
  factory User({
    //member info
    int? memberId,
    String? email,
    String? password, //Todo: 비밀번호는 필요한가?
    String? name,
    String? nickname,
    String? phoneNumber,
    double? latitude,
    double? longitude,
    // String? device,

    //member detail info
    String? sex,
    DateTime? birthDate,
    String? profilePicture,
    String? height,
    String? weight,
    String? bloodType,
    String? disease,
    String? medication,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
