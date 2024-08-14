import 'package:freezed_annotation/freezed_annotation.dart';

part 'x_post.freezed.dart';
part 'x_post.g.dart';

@freezed
class XPost with _$XPost {
  factory XPost({
    required String id,
    required String title,
    required String address,
    required String category,
    String? image,
    required String content,
    required DateTime createdAt,
  }) = _XPost;

  factory XPost.fromJson(Map<String, dynamic> json) => _$XPostFromJson(json);
}