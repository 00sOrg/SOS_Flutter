// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      memberId: (json['memberId'] as num?)?.toInt(),
      postId: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      userNickname: json['memberNickname'] as String?,
      userProfilePictureURL: json['memberProfile'] as String?,
      content: json['content'] as String?,
      mediaURL: json['media'] as String?,
      roadAddress: json['address'] as String?,
      likesCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentCount'] as num?)?.toInt() ?? 0,
      isLiked: json['liked'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      disasterLevel: json['eventLevel'] as String?,
      disasterType: json['eventType'] as String?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
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
      'createdAt': instance.createdAt?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'eventLevel': instance.disasterLevel,
      'eventType': instance.disasterType,
      'keywords': instance.keywords,
      'comments': instance.comments,
    };
