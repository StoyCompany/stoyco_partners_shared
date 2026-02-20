// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultural_assets_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CulturalAssetsContentModel _$CulturalAssetsContentModelFromJson(
  Map<String, dynamic> json,
) => CulturalAssetsContentModel(
  id: json['id'] as String,
  contentImageUrl: json['contentImageUrl'] as String,
  title: json['title'] as String,
  stoycoCoins: (json['stoycoCoins'] as num).toInt(),
  holders: (json['holders'] as num).toInt(),
  available: (json['available'] as num).toInt(),
);

Map<String, dynamic> _$CulturalAssetsContentModelToJson(
  CulturalAssetsContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'title': instance.title,
  'stoycoCoins': instance.stoycoCoins,
  'holders': instance.holders,
  'available': instance.available,
};
