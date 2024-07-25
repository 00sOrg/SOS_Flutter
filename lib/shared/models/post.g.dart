// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      address: json['address'] as String,
      category: json['category'] as String,
      image: json['image'] as String?,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'address': instance.address,
      'category': instance.category,
      'image': instance.image,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
