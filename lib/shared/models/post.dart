import 'package:freezed_annotation/freezed_annotation.dart';
import 'comment.dart';
// import 'user.dart'

part 'post.freezed.dart';
part 'post.g.dart';

//X_post 파일은 뭔지??

@freezed
class Post with _$Post {
  factory Post({
    required int postId,
    // required user,
    String? type,
    String? media,
    required String title,
    String? content,
    //location 클래스랑 겹치는데 -> 여기에 location을 같이둘까 따로둘까
    required DateTime createdAt,
    required double latitude,
    required double longitude,
    String? city,
    String? gu,
    String? dong,
    String? disasterLevel,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    List<Comment>? comments,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
