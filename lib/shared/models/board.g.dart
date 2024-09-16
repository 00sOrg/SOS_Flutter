// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
      eventId: (json['eventId'] as num).toInt(),
      title: json['title'] as String,
      content: json['content'] as String?,
      media: json['media'] as String?,
    );

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'title': instance.title,
      'content': instance.content,
      'media': instance.media,
    };
