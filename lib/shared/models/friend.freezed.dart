// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Friend _$FriendFromJson(Map<String, dynamic> json) {
  return _Friend.fromJson(json);
}

/// @nodoc
mixin _$Friend {
  int get favoriteMemberId => throw _privateConstructorUsedError;
  bool? get isAccepted => throw _privateConstructorUsedError;
  String? get lastLocation => throw _privateConstructorUsedError;
  String get modifiedNickname => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FriendCopyWith<Friend> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendCopyWith<$Res> {
  factory $FriendCopyWith(Friend value, $Res Function(Friend) then) =
      _$FriendCopyWithImpl<$Res, Friend>;
  @useResult
  $Res call(
      {int favoriteMemberId,
      bool? isAccepted,
      String? lastLocation,
      String modifiedNickname,
      String nickname,
      String? profilePicture});
}

/// @nodoc
class _$FriendCopyWithImpl<$Res, $Val extends Friend>
    implements $FriendCopyWith<$Res> {
  _$FriendCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteMemberId = null,
    Object? isAccepted = freezed,
    Object? lastLocation = freezed,
    Object? modifiedNickname = null,
    Object? nickname = null,
    Object? profilePicture = freezed,
  }) {
    return _then(_value.copyWith(
      favoriteMemberId: null == favoriteMemberId
          ? _value.favoriteMemberId
          : favoriteMemberId // ignore: cast_nullable_to_non_nullable
              as int,
      isAccepted: freezed == isAccepted
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastLocation: freezed == lastLocation
          ? _value.lastLocation
          : lastLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedNickname: null == modifiedNickname
          ? _value.modifiedNickname
          : modifiedNickname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendImplCopyWith<$Res> implements $FriendCopyWith<$Res> {
  factory _$$FriendImplCopyWith(
          _$FriendImpl value, $Res Function(_$FriendImpl) then) =
      __$$FriendImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int favoriteMemberId,
      bool? isAccepted,
      String? lastLocation,
      String modifiedNickname,
      String nickname,
      String? profilePicture});
}

/// @nodoc
class __$$FriendImplCopyWithImpl<$Res>
    extends _$FriendCopyWithImpl<$Res, _$FriendImpl>
    implements _$$FriendImplCopyWith<$Res> {
  __$$FriendImplCopyWithImpl(
      _$FriendImpl _value, $Res Function(_$FriendImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favoriteMemberId = null,
    Object? isAccepted = freezed,
    Object? lastLocation = freezed,
    Object? modifiedNickname = null,
    Object? nickname = null,
    Object? profilePicture = freezed,
  }) {
    return _then(_$FriendImpl(
      favoriteMemberId: null == favoriteMemberId
          ? _value.favoriteMemberId
          : favoriteMemberId // ignore: cast_nullable_to_non_nullable
              as int,
      isAccepted: freezed == isAccepted
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool?,
      lastLocation: freezed == lastLocation
          ? _value.lastLocation
          : lastLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedNickname: null == modifiedNickname
          ? _value.modifiedNickname
          : modifiedNickname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendImpl implements _Friend {
  _$FriendImpl(
      {required this.favoriteMemberId,
      this.isAccepted,
      this.lastLocation,
      required this.modifiedNickname,
      required this.nickname,
      this.profilePicture});

  factory _$FriendImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendImplFromJson(json);

  @override
  final int favoriteMemberId;
  @override
  final bool? isAccepted;
  @override
  final String? lastLocation;
  @override
  final String modifiedNickname;
  @override
  final String nickname;
  @override
  final String? profilePicture;

  @override
  String toString() {
    return 'Friend(favoriteMemberId: $favoriteMemberId, isAccepted: $isAccepted, lastLocation: $lastLocation, modifiedNickname: $modifiedNickname, nickname: $nickname, profilePicture: $profilePicture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendImpl &&
            (identical(other.favoriteMemberId, favoriteMemberId) ||
                other.favoriteMemberId == favoriteMemberId) &&
            (identical(other.isAccepted, isAccepted) ||
                other.isAccepted == isAccepted) &&
            (identical(other.lastLocation, lastLocation) ||
                other.lastLocation == lastLocation) &&
            (identical(other.modifiedNickname, modifiedNickname) ||
                other.modifiedNickname == modifiedNickname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, favoriteMemberId, isAccepted,
      lastLocation, modifiedNickname, nickname, profilePicture);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      __$$FriendImplCopyWithImpl<_$FriendImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendImplToJson(
      this,
    );
  }
}

abstract class _Friend implements Friend {
  factory _Friend(
      {required final int favoriteMemberId,
      final bool? isAccepted,
      final String? lastLocation,
      required final String modifiedNickname,
      required final String nickname,
      final String? profilePicture}) = _$FriendImpl;

  factory _Friend.fromJson(Map<String, dynamic> json) = _$FriendImpl.fromJson;

  @override
  int get favoriteMemberId;
  @override
  bool? get isAccepted;
  @override
  String? get lastLocation;
  @override
  String get modifiedNickname;
  @override
  String get nickname;
  @override
  String? get profilePicture;
  @override
  @JsonKey(ignore: true)
  _$$FriendImplCopyWith<_$FriendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
