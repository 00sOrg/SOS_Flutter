import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    @JsonKey(name: 'id') required int commentId,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'memberId') required int userId,
    @JsonKey(name: 'memberNickname') required String userNickname,
    @JsonKey(name: 'memberProfile') String? userProfilePictureURL,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') DateTime? updatedAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
