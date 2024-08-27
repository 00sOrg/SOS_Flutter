// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      profilePicture: json['profilePicture'] as String?,
      email: json['email'] as String,
      password: json['password'] as String,
      nickname: json['nickname'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      birthDay: DateTime.parse(json['birthDay'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'email': instance.email,
      'password': instance.password,
      'nickname': instance.nickname,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'birthDay': instance.birthDay.toIso8601String(),
    };
