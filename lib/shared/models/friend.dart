import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sos/shared/enums/status_enum.dart';

part 'friend.freezed.dart';
part 'friend.g.dart';

@freezed
class Friend with _$Friend {
  factory Friend({
    required int id,
    required String name,
    required String address,
    @Default(FriendStatus.stranger) FriendStatus status,
    String? profilePicture,
    String? nickName,
  }) = _Friend;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);
}
