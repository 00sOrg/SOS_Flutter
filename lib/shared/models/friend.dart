import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend.freezed.dart';
part 'friend.g.dart';

@freezed
class Friend with _$Friend {
  factory Friend({
    required int favoriteMemberId,
    required bool isAccepted,
    String? lastLocation,
    required String modifiedNickname,
    required String nickname,
    String? profilePicture,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}
