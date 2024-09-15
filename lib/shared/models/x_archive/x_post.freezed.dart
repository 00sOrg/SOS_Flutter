// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'x_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

XPost _$XPostFromJson(Map<String, dynamic> json) {
  return _XPost.fromJson(json);
}

/// @nodoc
mixin _$XPost {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $XPostCopyWith<XPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $XPostCopyWith<$Res> {
  factory $XPostCopyWith(XPost value, $Res Function(XPost) then) =
      _$XPostCopyWithImpl<$Res, XPost>;
  @useResult
  $Res call(
      {String id,
      String title,
      String address,
      String category,
      String? image,
      String content,
      DateTime createdAt});
}

/// @nodoc
class _$XPostCopyWithImpl<$Res, $Val extends XPost>
    implements $XPostCopyWith<$Res> {
  _$XPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? address = null,
    Object? category = null,
    Object? image = freezed,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$XPostImplCopyWith<$Res> implements $XPostCopyWith<$Res> {
  factory _$$XPostImplCopyWith(
          _$XPostImpl value, $Res Function(_$XPostImpl) then) =
      __$$XPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String address,
      String category,
      String? image,
      String content,
      DateTime createdAt});
}

/// @nodoc
class __$$XPostImplCopyWithImpl<$Res>
    extends _$XPostCopyWithImpl<$Res, _$XPostImpl>
    implements _$$XPostImplCopyWith<$Res> {
  __$$XPostImplCopyWithImpl(
      _$XPostImpl _value, $Res Function(_$XPostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? address = null,
    Object? category = null,
    Object? image = freezed,
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_$XPostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$XPostImpl implements _XPost {
  _$XPostImpl(
      {required this.id,
      required this.title,
      required this.address,
      required this.category,
      this.image,
      required this.content,
      required this.createdAt});

  factory _$XPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$XPostImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String address;
  @override
  final String category;
  @override
  final String? image;
  @override
  final String content;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'XPost(id: $id, title: $title, address: $address, category: $category, image: $image, content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$XPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, address, category, image, content, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$XPostImplCopyWith<_$XPostImpl> get copyWith =>
      __$$XPostImplCopyWithImpl<_$XPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$XPostImplToJson(
      this,
    );
  }
}

abstract class _XPost implements XPost {
  factory _XPost(
      {required final String id,
      required final String title,
      required final String address,
      required final String category,
      final String? image,
      required final String content,
      required final DateTime createdAt}) = _$XPostImpl;

  factory _XPost.fromJson(Map<String, dynamic> json) = _$XPostImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get address;
  @override
  String get category;
  @override
  String? get image;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$XPostImplCopyWith<_$XPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
