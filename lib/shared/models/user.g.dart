// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      profilePicture: json['profilePicture'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      gender: json['gender'] as String?,
      birthDay: json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'profilePicture': instance.profilePicture,
      'id': instance.id,
      'name': instance.name,
      'password': instance.password,
      'email': instance.email,
      'nickname': instance.nickname,
      'phoneNumber': instance.phoneNumber,
      'gender': instance.gender,
      'birthDay': instance.birthDay?.toIso8601String(),
      'address': instance.address,
    };
