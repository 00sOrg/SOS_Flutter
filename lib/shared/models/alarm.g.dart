// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmImpl _$$AlarmImplFromJson(Map<String, dynamic> json) => _$AlarmImpl(
      notificationId: (json['notificationId'] as num).toInt(),
      notificationType: json['notificationType'] as String,
      isRead: json['isRead'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      referenceId: (json['referenceId'] as num).toInt(),
      notificationMessage: json['notificationMessage'] as String,
      apiUrl: json['apiUrl'] as String,
    );

Map<String, dynamic> _$$AlarmImplToJson(_$AlarmImpl instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'notificationType': instance.notificationType,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt.toIso8601String(),
      'referenceId': instance.referenceId,
      'notificationMessage': instance.notificationMessage,
      'apiUrl': instance.apiUrl,
    };
