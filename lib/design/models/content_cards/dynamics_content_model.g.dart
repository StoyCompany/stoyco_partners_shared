// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamics_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicsContentModel _$DynamicsContentModelFromJson(
  Map<String, dynamic> json,
) => DynamicsContentModel(
  id: json['id'] as String,
  contentImageUrl: json['contentImageUrl'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  publishDate: DateTime.parse(json['publishDate'] as String),
  uniqueParticipants: (json['uniqueParticipants'] as num).toInt(),
  likes: (json['likes'] as num).toInt(),
  shares: (json['shares'] as num).toInt(),
  comments: (json['comments'] as num).toInt(),
  views: (json['views'] as num).toInt(),
);

Map<String, dynamic> _$DynamicsContentModelToJson(
  DynamicsContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'title': instance.title,
  'description': instance.description,
  'publishDate': instance.publishDate.toIso8601String(),
  'uniqueParticipants': instance.uniqueParticipants,
  'likes': instance.likes,
  'shares': instance.shares,
  'comments': instance.comments,
  'views': instance.views,
};
