import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:sos/shared/models/user.dart'; // 여건 되면
import 'comment.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    @JsonKey(name: 'id') required int postId,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'memberNickname') String? userNickname,
    @JsonKey(name: 'memberProfile') String? userProfilePictureURL,
    @JsonKey(name: 'content') String? content,
    @JsonKey(name: 'media') String? mediaURL,
    @JsonKey(name: 'address') String? roadAddress,
    @Default(0) @JsonKey(name: 'likeCount') int likesCount,
    @Default(0) @JsonKey(name: 'commentCount') int commentsCount,
    @Default(false) @JsonKey(name: 'liked') bool isLiked,
    DateTime? createdAt,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'eventLevel') String? disasterLevel,
    @JsonKey(name: 'eventType') String? disasterType,
    List<Comment>? comments,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
