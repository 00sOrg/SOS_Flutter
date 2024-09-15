// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'x_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$XPostImpl _$$XPostImplFromJson(Map<String, dynamic> json) => _$XPostImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      address: json['address'] as String,
      category: json['category'] as String,
      image: json['image'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$XPostImplToJson(_$XPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'category': instance.category,
      'image': instance.image,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
