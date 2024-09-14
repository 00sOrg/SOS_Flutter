// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      postId: (json['postId'] as num).toInt(),
      content: json['content'] as String,
      userId: (json['userId'] as num).toInt(),
      userNickname: json['userNickname'] as String,
      userProfilePictureURL: json['userProfilePictureURL'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'content': instance.content,
      'userId': instance.userId,
      'userNickname': instance.userNickname,
      'userProfilePictureURL': instance.userProfilePictureURL,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
