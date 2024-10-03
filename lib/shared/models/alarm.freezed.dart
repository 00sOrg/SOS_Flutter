// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return _Alarm.fromJson(json);
}

/// @nodoc
mixin _$Alarm {
  int get notificationId => throw _privateConstructorUsedError;
  String get notificationType => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get referenceId => throw _privateConstructorUsedError;
  String get notificationMessage => throw _privateConstructorUsedError;
  String get apiUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmCopyWith<Alarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmCopyWith<$Res> {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) then) =
      _$AlarmCopyWithImpl<$Res, Alarm>;
  @useResult
  $Res call(
      {int notificationId,
      String notificationType,
      bool isRead,
      DateTime createdAt,
      int referenceId,
      String notificationMessage,
      String apiUrl});
}

/// @nodoc
class _$AlarmCopyWithImpl<$Res, $Val extends Alarm>
    implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? notificationType = null,
    Object? isRead = null,
    Object? createdAt = null,
    Object? referenceId = null,
    Object? notificationMessage = null,
    Object? apiUrl = null,
  }) {
    return _then(_value.copyWith(
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int,
      notificationType: null == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as int,
      notificationMessage: null == notificationMessage
          ? _value.notificationMessage
          : notificationMessage // ignore: cast_nullable_to_non_nullable
              as String,
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmImplCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$$AlarmImplCopyWith(
          _$AlarmImpl value, $Res Function(_$AlarmImpl) then) =
      __$$AlarmImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int notificationId,
      String notificationType,
      bool isRead,
      DateTime createdAt,
      int referenceId,
      String notificationMessage,
      String apiUrl});
}

/// @nodoc
class __$$AlarmImplCopyWithImpl<$Res>
    extends _$AlarmCopyWithImpl<$Res, _$AlarmImpl>
    implements _$$AlarmImplCopyWith<$Res> {
  __$$AlarmImplCopyWithImpl(
      _$AlarmImpl _value, $Res Function(_$AlarmImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = null,
    Object? notificationType = null,
    Object? isRead = null,
    Object? createdAt = null,
    Object? referenceId = null,
    Object? notificationMessage = null,
    Object? apiUrl = null,
  }) {
    return _then(_$AlarmImpl(
      notificationId: null == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int,
      notificationType: null == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      referenceId: null == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as int,
      notificationMessage: null == notificationMessage
          ? _value.notificationMessage
          : notificationMessage // ignore: cast_nullable_to_non_nullable
              as String,
      apiUrl: null == apiUrl
          ? _value.apiUrl
          : apiUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmImpl implements _Alarm {
  const _$AlarmImpl(
      {required this.notificationId,
      required this.notificationType,
      required this.isRead,
      required this.createdAt,
      required this.referenceId,
      required this.notificationMessage,
      required this.apiUrl});

  factory _$AlarmImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmImplFromJson(json);

  @override
  final int notificationId;
  @override
  final String notificationType;
  @override
  final bool isRead;
  @override
  final DateTime createdAt;
  @override
  final int referenceId;
  @override
  final String notificationMessage;
  @override
  final String apiUrl;

  @override
  String toString() {
    return 'Alarm(notificationId: $notificationId, notificationType: $notificationType, isRead: $isRead, createdAt: $createdAt, referenceId: $referenceId, notificationMessage: $notificationMessage, apiUrl: $apiUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmImpl &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.notificationMessage, notificationMessage) ||
                other.notificationMessage == notificationMessage) &&
            (identical(other.apiUrl, apiUrl) || other.apiUrl == apiUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, notificationId, notificationType,
      isRead, createdAt, referenceId, notificationMessage, apiUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmImplCopyWith<_$AlarmImpl> get copyWith =>
      __$$AlarmImplCopyWithImpl<_$AlarmImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmImplToJson(
      this,
    );
  }
}

abstract class _Alarm implements Alarm {
  const factory _Alarm(
      {required final int notificationId,
      required final String notificationType,
      required final bool isRead,
      required final DateTime createdAt,
      required final int referenceId,
      required final String notificationMessage,
      required final String apiUrl}) = _$AlarmImpl;

  factory _Alarm.fromJson(Map<String, dynamic> json) = _$AlarmImpl.fromJson;

  @override
  int get notificationId;
  @override
  String get notificationType;
  @override
  bool get isRead;
  @override
  DateTime get createdAt;
  @override
  int get referenceId;
  @override
  String get notificationMessage;
  @override
  String get apiUrl;
  @override
  @JsonKey(ignore: true)
  _$$AlarmImplCopyWith<_$AlarmImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
