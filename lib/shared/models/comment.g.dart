// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentImpl _$$CommentImplFromJson(Map<String, dynamic> json) =>
    _$CommentImpl(
      postId: (json['postId'] as num).toInt(),
      profilePic: json['profilePic'] as String?,
      userName: json['userName'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CommentImplToJson(_$CommentImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'profilePic': instance.profilePic,
      'userName': instance.userName,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
