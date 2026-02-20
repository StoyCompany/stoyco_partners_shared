// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicContentModel _$MusicContentModelFromJson(Map<String, dynamic> json) =>
    MusicContentModel(
      id: json['id'] as String,
      contentImageUrl: json['contentImageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      shares: (json['shares'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
      views: (json['views'] as num).toInt(),
      totalDonatedStoyCoins: (json['totalDonatedStoyCoins'] as num).toInt(),
      tracksCount: (json['tracksCount'] as num).toInt(),
      tracks: (json['tracks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MusicContentModelToJson(MusicContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contentImageUrl': instance.contentImageUrl,
      'title': instance.title,
      'description': instance.description,
      'shares': instance.shares,
      'comments': instance.comments,
      'views': instance.views,
      'totalDonatedStoyCoins': instance.totalDonatedStoyCoins,
      'tracksCount': instance.tracksCount,
      'tracks': instance.tracks,
    };
