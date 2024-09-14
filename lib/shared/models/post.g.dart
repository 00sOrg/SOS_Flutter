// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      createdAt: DateTime.parse(json['createdAt'] as String),
      postId: (json['postId'] as num).toInt(),
      title: json['title'] as String,
      userNickname: json['userNickname'] as String?,
      userProfilePictureURL: json['userProfilePictureURL'] as String?,
      content: json['content'] as String?,
      mediaURL: json['mediaURL'] as String?,
      roadAddress: json['roadAddress'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      disasterLevel: json['disasterLevel'] as String?,
      disasterType: json['disasterType'] as String?,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'postId': instance.postId,
      'title': instance.title,
      'userNickname': instance.userNickname,
      'userProfilePictureURL': instance.userProfilePictureURL,
      'content': instance.content,
      'mediaURL': instance.mediaURL,
      'roadAddress': instance.roadAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'disasterLevel': instance.disasterLevel,
      'disasterType': instance.disasterType,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'isLiked': instance.isLiked,
      'comments': instance.comments,
    };
