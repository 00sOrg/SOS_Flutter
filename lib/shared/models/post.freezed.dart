// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get postId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get userNickname => throw _privateConstructorUsedError;
  String? get userProfilePictureURL => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get mediaURL => throw _privateConstructorUsedError;
  String? get roadAddress => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String? get disasterLevel => throw _privateConstructorUsedError;
  String? get disasterType => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;
  int get commentsCount => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  List<Comment>? get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {DateTime createdAt,
      int postId,
      String title,
      String? userNickname,
      String? userProfilePictureURL,
      String? content,
      String? mediaURL,
      String? roadAddress,
      double latitude,
      double longitude,
      String? disasterLevel,
      String? disasterType,
      int likesCount,
      int commentsCount,
      bool isLiked,
      List<Comment>? comments});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? postId = null,
    Object? title = null,
    Object? userNickname = freezed,
    Object? userProfilePictureURL = freezed,
    Object? content = freezed,
    Object? mediaURL = freezed,
    Object? roadAddress = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? disasterLevel = freezed,
    Object? disasterType = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? isLiked = null,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userNickname: freezed == userNickname
          ? _value.userNickname
          : userNickname // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfilePictureURL: freezed == userProfilePictureURL
          ? _value.userProfilePictureURL
          : userProfilePictureURL // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaURL: freezed == mediaURL
          ? _value.mediaURL
          : mediaURL // ignore: cast_nullable_to_non_nullable
              as String?,
      roadAddress: freezed == roadAddress
          ? _value.roadAddress
          : roadAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      disasterLevel: freezed == disasterLevel
          ? _value.disasterLevel
          : disasterLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      disasterType: freezed == disasterType
          ? _value.disasterType
          : disasterType // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime createdAt,
      int postId,
      String title,
      String? userNickname,
      String? userProfilePictureURL,
      String? content,
      String? mediaURL,
      String? roadAddress,
      double latitude,
      double longitude,
      String? disasterLevel,
      String? disasterType,
      int likesCount,
      int commentsCount,
      bool isLiked,
      List<Comment>? comments});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = null,
    Object? postId = null,
    Object? title = null,
    Object? userNickname = freezed,
    Object? userProfilePictureURL = freezed,
    Object? content = freezed,
    Object? mediaURL = freezed,
    Object? roadAddress = freezed,
    Object? latitude = null,
    Object? longitude = null,
    Object? disasterLevel = freezed,
    Object? disasterType = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? isLiked = null,
    Object? comments = freezed,
  }) {
    return _then(_$PostImpl(
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userNickname: freezed == userNickname
          ? _value.userNickname
          : userNickname // ignore: cast_nullable_to_non_nullable
              as String?,
      userProfilePictureURL: freezed == userProfilePictureURL
          ? _value.userProfilePictureURL
          : userProfilePictureURL // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaURL: freezed == mediaURL
          ? _value.mediaURL
          : mediaURL // ignore: cast_nullable_to_non_nullable
              as String?,
      roadAddress: freezed == roadAddress
          ? _value.roadAddress
          : roadAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      disasterLevel: freezed == disasterLevel
          ? _value.disasterLevel
          : disasterLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      disasterType: freezed == disasterType
          ? _value.disasterType
          : disasterType // ignore: cast_nullable_to_non_nullable
              as String?,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentsCount: null == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int,
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  _$PostImpl(
      {required this.createdAt,
      required this.postId,
      required this.title,
      this.userNickname,
      this.userProfilePictureURL,
      this.content,
      this.mediaURL,
      this.roadAddress,
      required this.latitude,
      required this.longitude,
      this.disasterLevel,
      this.disasterType,
      this.likesCount = 0,
      this.commentsCount = 0,
      this.isLiked = false,
      final List<Comment>? comments})
      : _comments = comments;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final DateTime createdAt;
  @override
  final int postId;
  @override
  final String title;
  @override
  final String? userNickname;
  @override
  final String? userProfilePictureURL;
  @override
  final String? content;
  @override
  final String? mediaURL;
  @override
  final String? roadAddress;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String? disasterLevel;
  @override
  final String? disasterType;
  @override
  @JsonKey()
  final int likesCount;
  @override
  @JsonKey()
  final int commentsCount;
  @override
  @JsonKey()
  final bool isLiked;
  final List<Comment>? _comments;
  @override
  List<Comment>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Post(createdAt: $createdAt, postId: $postId, title: $title, userNickname: $userNickname, userProfilePictureURL: $userProfilePictureURL, content: $content, mediaURL: $mediaURL, roadAddress: $roadAddress, latitude: $latitude, longitude: $longitude, disasterLevel: $disasterLevel, disasterType: $disasterType, likesCount: $likesCount, commentsCount: $commentsCount, isLiked: $isLiked, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userNickname, userNickname) ||
                other.userNickname == userNickname) &&
            (identical(other.userProfilePictureURL, userProfilePictureURL) ||
                other.userProfilePictureURL == userProfilePictureURL) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.mediaURL, mediaURL) ||
                other.mediaURL == mediaURL) &&
            (identical(other.roadAddress, roadAddress) ||
                other.roadAddress == roadAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.disasterLevel, disasterLevel) ||
                other.disasterLevel == disasterLevel) &&
            (identical(other.disasterType, disasterType) ||
                other.disasterType == disasterType) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdAt,
      postId,
      title,
      userNickname,
      userProfilePictureURL,
      content,
      mediaURL,
      roadAddress,
      latitude,
      longitude,
      disasterLevel,
      disasterType,
      likesCount,
      commentsCount,
      isLiked,
      const DeepCollectionEquality().hash(_comments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  factory _Post(
      {required final DateTime createdAt,
      required final int postId,
      required final String title,
      final String? userNickname,
      final String? userProfilePictureURL,
      final String? content,
      final String? mediaURL,
      final String? roadAddress,
      required final double latitude,
      required final double longitude,
      final String? disasterLevel,
      final String? disasterType,
      final int likesCount,
      final int commentsCount,
      final bool isLiked,
      final List<Comment>? comments}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  DateTime get createdAt;
  @override
  int get postId;
  @override
  String get title;
  @override
  String? get userNickname;
  @override
  String? get userProfilePictureURL;
  @override
  String? get content;
  @override
  String? get mediaURL;
  @override
  String? get roadAddress;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String? get disasterLevel;
  @override
  String? get disasterType;
  @override
  int get likesCount;
  @override
  int get commentsCount;
  @override
  bool get isLiked;
  @override
  List<Comment>? get comments;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
