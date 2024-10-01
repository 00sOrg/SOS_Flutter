// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
      eventId: (json['eventId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      eventLevel: json['eventLevel'] as String?,
      eventType: json['eventType'] as String?,
      title: json['title'] as String,
      content: json['content'] as String?,
      media: json['media'] as String?,
      keywords: (json['keywords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'id': instance.id,
      'eventLevel': instance.eventLevel,
      'eventType': instance.eventType,
      'title': instance.title,
      'content': instance.content,
      'media': instance.media,
      'keywords': instance.keywords,
    };
