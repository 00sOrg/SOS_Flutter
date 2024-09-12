// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendImpl _$$FriendImplFromJson(Map<String, dynamic> json) => _$FriendImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: json['address'] as String?,
      status: $enumDecodeNullable(_$FriendStatusEnumMap, json['status']) ??
          FriendStatus.stranger,
      profilePicture: json['profilePicture'] as String?,
      nickName: json['nickName'] as String?,
    );

Map<String, dynamic> _$$FriendImplToJson(_$FriendImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'status': _$FriendStatusEnumMap[instance.status]!,
      'profilePicture': instance.profilePicture,
      'nickName': instance.nickName,
    };

const _$FriendStatusEnumMap = {
  FriendStatus.pending: 'pending',
  FriendStatus.friend: 'friend',
  FriendStatus.stranger: 'stranger',
};
