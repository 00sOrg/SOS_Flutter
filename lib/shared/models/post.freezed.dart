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
  @JsonKey(name: 'id')
  int get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'memberNickname')
  String? get userNickname => throw _privateConstructorUsedError;
  @JsonKey(name: 'memberProfile')
  String? get userProfilePictureURL => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String? get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'media')
  String? get mediaURL => throw _privateConstructorUsedError;
  @JsonKey(name: 'address')
  String? get roadAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'likeCount')
  int get likesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'commentCount')
  int get commentsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'liked')
  bool get isLiked => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'eventLevel')
  String? get disasterLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'eventType')
  String? get disasterType => throw _privateConstructorUsedError;
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
      {@JsonKey(name: 'id') int postId,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'memberNickname') String? userNickname,
      @JsonKey(name: 'memberProfile') String? userProfilePictureURL,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'media') String? mediaURL,
      @JsonKey(name: 'address') String? roadAddress,
      @JsonKey(name: 'likeCount') int likesCount,
      @JsonKey(name: 'commentCount') int commentsCount,
      @JsonKey(name: 'liked') bool isLiked,
      DateTime? createdAt,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'eventLevel') String? disasterLevel,
      @JsonKey(name: 'eventType') String? disasterType,
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
    Object? postId = null,
    Object? title = freezed,
    Object? userNickname = freezed,
    Object? userProfilePictureURL = freezed,
    Object? content = freezed,
    Object? mediaURL = freezed,
    Object? roadAddress = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? isLiked = null,
    Object? createdAt = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? disasterLevel = freezed,
    Object? disasterType = freezed,
    Object? comments = freezed,
  }) {
    return _then(_value.copyWith(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      disasterLevel: freezed == disasterLevel
          ? _value.disasterLevel
          : disasterLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      disasterType: freezed == disasterType
          ? _value.disasterType
          : disasterType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {@JsonKey(name: 'id') int postId,
      @JsonKey(name: 'title') String? title,
      @JsonKey(name: 'memberNickname') String? userNickname,
      @JsonKey(name: 'memberProfile') String? userProfilePictureURL,
      @JsonKey(name: 'content') String? content,
      @JsonKey(name: 'media') String? mediaURL,
      @JsonKey(name: 'address') String? roadAddress,
      @JsonKey(name: 'likeCount') int likesCount,
      @JsonKey(name: 'commentCount') int commentsCount,
      @JsonKey(name: 'liked') bool isLiked,
      DateTime? createdAt,
      double? latitude,
      double? longitude,
      @JsonKey(name: 'eventLevel') String? disasterLevel,
      @JsonKey(name: 'eventType') String? disasterType,
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
    Object? postId = null,
    Object? title = freezed,
    Object? userNickname = freezed,
    Object? userProfilePictureURL = freezed,
    Object? content = freezed,
    Object? mediaURL = freezed,
    Object? roadAddress = freezed,
    Object? likesCount = null,
    Object? commentsCount = null,
    Object? isLiked = null,
    Object? createdAt = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? disasterLevel = freezed,
    Object? disasterType = freezed,
    Object? comments = freezed,
  }) {
    return _then(_$PostImpl(
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      disasterLevel: freezed == disasterLevel
          ? _value.disasterLevel
          : disasterLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      disasterType: freezed == disasterType
          ? _value.disasterType
          : disasterType // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {@JsonKey(name: 'id') required this.postId,
      @JsonKey(name: 'title') this.title,
      @JsonKey(name: 'memberNickname') this.userNickname,
      @JsonKey(name: 'memberProfile') this.userProfilePictureURL,
      @JsonKey(name: 'content') this.content,
      @JsonKey(name: 'media') this.mediaURL,
      @JsonKey(name: 'address') this.roadAddress,
      @JsonKey(name: 'likeCount') this.likesCount = 0,
      @JsonKey(name: 'commentCount') this.commentsCount = 0,
      @JsonKey(name: 'liked') this.isLiked = false,
      this.createdAt,
      this.latitude,
      this.longitude,
      @JsonKey(name: 'eventLevel') this.disasterLevel,
      @JsonKey(name: 'eventType') this.disasterType,
      final List<Comment>? comments})
      : _comments = comments;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int postId;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'memberNickname')
  final String? userNickname;
  @override
  @JsonKey(name: 'memberProfile')
  final String? userProfilePictureURL;
  @override
  @JsonKey(name: 'content')
  final String? content;
  @override
  @JsonKey(name: 'media')
  final String? mediaURL;
  @override
  @JsonKey(name: 'address')
  final String? roadAddress;
  @override
  @JsonKey(name: 'likeCount')
  final int likesCount;
  @override
  @JsonKey(name: 'commentCount')
  final int commentsCount;
  @override
  @JsonKey(name: 'liked')
  final bool isLiked;
  @override
  final DateTime? createdAt;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'eventLevel')
  final String? disasterLevel;
  @override
  @JsonKey(name: 'eventType')
  final String? disasterType;
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
    return 'Post(postId: $postId, title: $title, userNickname: $userNickname, userProfilePictureURL: $userProfilePictureURL, content: $content, mediaURL: $mediaURL, roadAddress: $roadAddress, likesCount: $likesCount, commentsCount: $commentsCount, isLiked: $isLiked, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, disasterLevel: $disasterLevel, disasterType: $disasterType, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
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
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.disasterLevel, disasterLevel) ||
                other.disasterLevel == disasterLevel) &&
            (identical(other.disasterType, disasterType) ||
                other.disasterType == disasterType) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      postId,
      title,
      userNickname,
      userProfilePictureURL,
      content,
      mediaURL,
      roadAddress,
      likesCount,
      commentsCount,
      isLiked,
      createdAt,
      latitude,
      longitude,
      disasterLevel,
      disasterType,
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
      {@JsonKey(name: 'id') required final int postId,
      @JsonKey(name: 'title') final String? title,
      @JsonKey(name: 'memberNickname') final String? userNickname,
      @JsonKey(name: 'memberProfile') final String? userProfilePictureURL,
      @JsonKey(name: 'content') final String? content,
      @JsonKey(name: 'media') final String? mediaURL,
      @JsonKey(name: 'address') final String? roadAddress,
      @JsonKey(name: 'likeCount') final int likesCount,
      @JsonKey(name: 'commentCount') final int commentsCount,
      @JsonKey(name: 'liked') final bool isLiked,
      final DateTime? createdAt,
      final double? latitude,
      final double? longitude,
      @JsonKey(name: 'eventLevel') final String? disasterLevel,
      @JsonKey(name: 'eventType') final String? disasterType,
      final List<Comment>? comments}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get postId;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'memberNickname')
  String? get userNickname;
  @override
  @JsonKey(name: 'memberProfile')
  String? get userProfilePictureURL;
  @override
  @JsonKey(name: 'content')
  String? get content;
  @override
  @JsonKey(name: 'media')
  String? get mediaURL;
  @override
  @JsonKey(name: 'address')
  String? get roadAddress;
  @override
  @JsonKey(name: 'likeCount')
  int get likesCount;
  @override
  @JsonKey(name: 'commentCount')
  int get commentsCount;
  @override
  @JsonKey(name: 'liked')
  bool get isLiked;
  @override
  DateTime? get createdAt;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'eventLevel')
  String? get disasterLevel;
  @override
  @JsonKey(name: 'eventType')
  String? get disasterType;
  @override
  List<Comment>? get comments;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
