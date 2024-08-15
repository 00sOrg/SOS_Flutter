// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: (json['postId'] as num).toInt(),
      type: json['type'] as String?,
      media: json['media'] as String?,
      title: json['title'] as String,
      content: json['content'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['city'] as String?,
      gu: json['gu'] as String?,
      dong: json['dong'] as String?,
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
      'type': instance.type,
      'media': instance.media,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
      'gu': instance.gu,
      'dong': instance.dong,
      'disasterLevel': instance.disasterLevel,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'comments': instance.comments,
    };
