import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos/shared/models/user.dart';
import 'comment.dart';
// import 'user.dart'

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  factory Post({
    required int postId,
    required String title,
    String? content,
    String? mediaUrl,
    User? user,
    String? type,
    //location 클래스랑 겹치는데 -> 여기에 location을 같이둘까 따로둘까
    required DateTime createdAt,
    String? roadAddress,
    required double latitude,
    required double longitude,
    String? disasterLevel,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    List<Comment>? comments,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
