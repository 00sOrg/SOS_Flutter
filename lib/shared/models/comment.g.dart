// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      commentId: (json['id'] as num).toInt(),
      content: json['content'] as String,
      userId: (json['memberId'] as num).toInt(),
      userNickname: json['memberNickname'] as String,
      userProfilePictureURL: json['memberProfile'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'id': instance.commentId,
      'content': instance.content,
      'memberId': instance.userId,
      'memberNickname': instance.userNickname,
      'memberProfile': instance.userProfilePictureURL,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
