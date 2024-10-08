// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Board _$BoardFromJson(Map<String, dynamic> json) {
  return _Board.fromJson(json);
}

/// @nodoc
mixin _$Board {
  int? get eventId => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String? get eventLevel => throw _privateConstructorUsedError;
  String? get eventType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get media => throw _privateConstructorUsedError;
  List<String>? get keywords => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BoardCopyWith<Board> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardCopyWith<$Res> {
  factory $BoardCopyWith(Board value, $Res Function(Board) then) =
      _$BoardCopyWithImpl<$Res, Board>;
  @useResult
  $Res call(
      {int? eventId,
      int? id,
      String? eventLevel,
      String? eventType,
      String title,
      String? content,
      String? media,
      List<String>? keywords});
}

/// @nodoc
class _$BoardCopyWithImpl<$Res, $Val extends Board>
    implements $BoardCopyWith<$Res> {
  _$BoardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? id = freezed,
    Object? eventLevel = freezed,
    Object? eventType = freezed,
    Object? title = null,
    Object? content = freezed,
    Object? media = freezed,
    Object? keywords = freezed,
  }) {
    return _then(_value.copyWith(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      eventLevel: freezed == eventLevel
          ? _value.eventLevel
          : eventLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      keywords: freezed == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoardImplCopyWith<$Res> implements $BoardCopyWith<$Res> {
  factory _$$BoardImplCopyWith(
          _$BoardImpl value, $Res Function(_$BoardImpl) then) =
      __$$BoardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? eventId,
      int? id,
      String? eventLevel,
      String? eventType,
      String title,
      String? content,
      String? media,
      List<String>? keywords});
}

/// @nodoc
class __$$BoardImplCopyWithImpl<$Res>
    extends _$BoardCopyWithImpl<$Res, _$BoardImpl>
    implements _$$BoardImplCopyWith<$Res> {
  __$$BoardImplCopyWithImpl(
      _$BoardImpl _value, $Res Function(_$BoardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? id = freezed,
    Object? eventLevel = freezed,
    Object? eventType = freezed,
    Object? title = null,
    Object? content = freezed,
    Object? media = freezed,
    Object? keywords = freezed,
  }) {
    return _then(_$BoardImpl(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as int?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      eventLevel: freezed == eventLevel
          ? _value.eventLevel
          : eventLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      eventType: freezed == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      media: freezed == media
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as String?,
      keywords: freezed == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardImpl implements _Board {
  const _$BoardImpl(
      {this.eventId,
      this.id,
      this.eventLevel,
      this.eventType,
      required this.title,
      this.content,
      this.media,
      final List<String>? keywords})
      : _keywords = keywords;

  factory _$BoardImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardImplFromJson(json);

  @override
  final int? eventId;
  @override
  final int? id;
  @override
  final String? eventLevel;
  @override
  final String? eventType;
  @override
  final String title;
  @override
  final String? content;
  @override
  final String? media;
  final List<String>? _keywords;
  @override
  List<String>? get keywords {
    final value = _keywords;
    if (value == null) return null;
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Board(eventId: $eventId, id: $id, eventLevel: $eventLevel, eventType: $eventType, title: $title, content: $content, media: $media, keywords: $keywords)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardImpl &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventLevel, eventLevel) ||
                other.eventLevel == eventLevel) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.media, media) || other.media == media) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      eventId,
      id,
      eventLevel,
      eventType,
      title,
      content,
      media,
      const DeepCollectionEquality().hash(_keywords));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardImplCopyWith<_$BoardImpl> get copyWith =>
      __$$BoardImplCopyWithImpl<_$BoardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardImplToJson(
      this,
    );
  }
}

abstract class _Board implements Board {
  const factory _Board(
      {final int? eventId,
      final int? id,
      final String? eventLevel,
      final String? eventType,
      required final String title,
      final String? content,
      final String? media,
      final List<String>? keywords}) = _$BoardImpl;

  factory _Board.fromJson(Map<String, dynamic> json) = _$BoardImpl.fromJson;

  @override
  int? get eventId;
  @override
  int? get id;
  @override
  String? get eventLevel;
  @override
  String? get eventType;
  @override
  String get title;
  @override
  String? get content;
  @override
  String? get media;
  @override
  List<String>? get keywords;
  @override
  @JsonKey(ignore: true)
  _$$BoardImplCopyWith<_$BoardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
