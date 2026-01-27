// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentCardModel _$ContentCardModelFromJson(Map<String, dynamic> json) =>
    ContentCardModel(
      contentImageUrl: json['contentImageUrl'] as String,
      contentTitle: json['contentTitle'] as String,
      contentDescription: json['contentDescription'] as String,
      contentDate: json['contentDate'] as String,
      contentLikes: json['contentLikes'] as String,
      contentShares: json['contentShares'] as String,
      contentViews: json['contentViews'] as String,
    );

Map<String, dynamic> _$ContentCardModelToJson(ContentCardModel instance) =>
    <String, dynamic>{
      'contentImageUrl': instance.contentImageUrl,
      'contentTitle': instance.contentTitle,
      'contentDescription': instance.contentDescription,
      'contentDate': instance.contentDate,
      'contentLikes': instance.contentLikes,
      'contentShares': instance.contentShares,
      'contentViews': instance.contentViews,
    };
