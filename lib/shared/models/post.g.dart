// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      postId: (json['id'] as num).toInt(),
      title: json['title'] as String,
      userNickname: json['memberNickname'] as String?,
      userProfilePictureURL: json['memberProfile'] as String?,
      content: json['content'] as String?,
      mediaURL: json['media'] as String?,
      roadAddress: json['address'] as String?,
      likesCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isLiked: json['liked'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      disasterLevel: json['disasterLevel'] as String?,
      disasterType: json['disasterType'] as String?,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.postId,
      'title': instance.title,
      'memberNickname': instance.userNickname,
      'memberProfile': instance.userProfilePictureURL,
      'content': instance.content,
      'media': instance.mediaURL,
      'address': instance.roadAddress,
      'likeCount': instance.likesCount,
      'commentCount': instance.commentsCount,
      'liked': instance.isLiked,
      'createdAt': instance.createdAt.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'disasterLevel': instance.disasterLevel,
      'disasterType': instance.disasterType,
      'comments': instance.comments,
    };
