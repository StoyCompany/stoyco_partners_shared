// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_to_fund_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectsToFundContentModel _$ProjectsToFundContentModelFromJson(
  Map<String, dynamic> json,
) => ProjectsToFundContentModel(
  id: json['id'] as String,
  contentImageUrl: json['contentImageUrl'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  publishDate: DateTime.parse(json['publishDate'] as String),
  closeDate: DateTime.parse(json['closeDate'] as String),
  isActive: json['isActive'] as bool,
  stoycoCoins: (json['stoycoCoins'] as num).toInt(),
  donation: (json['donation'] as num).toInt(),
  likes: (json['likes'] as num).toInt(),
  shares: (json['shares'] as num).toInt(),
  comments: (json['comments'] as num).toInt(),
  views: (json['views'] as num).toInt(),
);

Map<String, dynamic> _$ProjectsToFundContentModelToJson(
  ProjectsToFundContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'title': instance.title,
  'description': instance.description,
  'publishDate': instance.publishDate.toIso8601String(),
  'closeDate': instance.closeDate.toIso8601String(),
  'isActive': instance.isActive,
  'stoycoCoins': instance.stoycoCoins,
  'donation': instance.donation,
  'likes': instance.likes,
  'shares': instance.shares,
  'comments': instance.comments,
  'views': instance.views,
};
