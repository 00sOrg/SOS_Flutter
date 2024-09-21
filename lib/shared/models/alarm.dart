import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm.freezed.dart';
part 'alarm.g.dart';

@freezed
class Alarm with _$Alarm {
  const factory Alarm({
    required int notificationId,
    required String notificationType,
    required String isRead,
    required DateTime createdAt,
    required int referenceId,
    required String notificationMessage,
    required String apiUrl,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}
