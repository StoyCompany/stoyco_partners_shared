// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoContentModel _$VideoContentModelFromJson(Map<String, dynamic> json) =>
    VideoContentModel(
      id: json['id'] as String,
      contentImageUrl: json['contentImageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      views: (json['views'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      shares: (json['shares'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
      publishDate: json['publishDate'] as String,
    );

Map<String, dynamic> _$VideoContentModelToJson(VideoContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contentImageUrl': instance.contentImageUrl,
      'title': instance.title,
      'description': instance.description,
      'views': instance.views,
      'likes': instance.likes,
      'shares': instance.shares,
      'comments': instance.comments,
      'publishDate': instance.publishDate,
    };
