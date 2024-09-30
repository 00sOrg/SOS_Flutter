// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
      favoriteMemberId: (json['favoriteMemberId'] as num).toInt(),
      isAccepted: json['isAccepted'] as bool?,
      lastLocation: json['lastLocation'] as String?,
      modifiedNickname: json['modifiedNickname'] as String,
      nickname: json['nickname'] as String,
      profilePicture: json['profilePicture'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
    <String, dynamic>{
      'favoriteMemberId': instance.favoriteMemberId,
      'isAccepted': instance.isAccepted,
      'lastLocation': instance.lastLocation,
      'modifiedNickname': instance.modifiedNickname,
      'nickname': instance.nickname,
      'profilePicture': instance.profilePicture,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
