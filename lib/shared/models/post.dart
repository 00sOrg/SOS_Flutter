import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos/shared/models/user.dart';
import 'comment.dart';
// import 'user.dart'

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    required DateTime createdAt,
    required int postId,
    required String title,
    String? userNickname,
    String? userProfilePictureURL,
    String? content,
    String? mediaURL,
    String? roadAddress,
    required double latitude,
    required double longitude,
    String? disasterLevel,
    String? disasterType,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    @Default(false) bool isLiked,
    List<Comment>? comments,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
