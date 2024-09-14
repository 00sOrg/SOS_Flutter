// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: (json['postId'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String?,
      media: json['media'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      type: json['type'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      roadAddress: json['roadAddress'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      disasterLevel: json['disasterLevel'] as String?,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'content': instance.content,
      'media': instance.media,
      'user': instance.user,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'roadAddress': instance.roadAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'disasterLevel': instance.disasterLevel,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'comments': instance.comments,
    };
