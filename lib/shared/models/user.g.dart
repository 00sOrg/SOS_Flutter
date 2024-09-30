// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      sex: json['sex'] as String?,
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      profilePicture: json['profilePicture'] as String?,
      height: json['height'] as String?,
      weight: json['weight'] as String?,
      bloodType: json['bloodType'] as String?,
      disease: json['disease'] as String?,
      medication: json['medication'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'nickname': instance.nickname,
      'phoneNumber': instance.phoneNumber,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'sex': instance.sex,
      'birthDate': instance.birthDate?.toIso8601String(),
      'profilePicture': instance.profilePicture,
      'height': instance.height,
      'weight': instance.weight,
      'bloodType': instance.bloodType,
      'disease': instance.disease,
      'medication': instance.medication,
      'address': instance.address,
    };
