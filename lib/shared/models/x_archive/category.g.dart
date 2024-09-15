// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      text: json['text'] as String,
      iconPath: json['iconPath'] as String,
      iconPathColored: json['iconPathColored'] as String,
      color: const ColorConverter().fromJson((json['color'] as num).toInt()),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'iconPath': instance.iconPath,
      'iconPathColored': instance.iconPathColored,
      'color': const ColorConverter().toJson(instance.color),
    };
