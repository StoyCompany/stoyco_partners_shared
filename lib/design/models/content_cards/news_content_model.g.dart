// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsContentModel _$NewsContentModelFromJson(Map<String, dynamic> json) =>
    NewsContentModel(
      id: json['id'] as String,
      contentImageUrl: json['contentImageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      publishDate: json['publishDate'] as String,
      likes: (json['likes'] as num).toInt(),
      shares: (json['shares'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
      views: (json['views'] as num).toInt(),
    );

Map<String, dynamic> _$NewsContentModelToJson(NewsContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contentImageUrl': instance.contentImageUrl,
      'title': instance.title,
      'description': instance.description,
      'publishDate': instance.publishDate,
      'likes': instance.likes,
      'shares': instance.shares,
      'comments': instance.comments,
      'views': instance.views,
    };
