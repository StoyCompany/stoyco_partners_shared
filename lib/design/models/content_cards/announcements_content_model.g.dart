// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcements_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementsContentModel _$AnnouncementsContentModelFromJson(
  Map<String, dynamic> json,
) => AnnouncementsContentModel(
  id: json['id'] as String,
  contentImageUrl: json['contentImageUrl'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  status: $enumDecode(_$AnnouncementStatusEnumMap, json['status']),
  closeDate: json['closeDate'] as String,
  participants: (json['participants'] as num).toInt(),
  likes: (json['likes'] as num).toInt(),
  shares: (json['shares'] as num).toInt(),
  comments: (json['comments'] as num).toInt(),
  views: (json['views'] as num).toInt(),
);

Map<String, dynamic> _$AnnouncementsContentModelToJson(
  AnnouncementsContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'title': instance.title,
  'description': instance.description,
  'status': _$AnnouncementStatusEnumMap[instance.status]!,
  'closeDate': instance.closeDate,
  'participants': instance.participants,
  'likes': instance.likes,
  'shares': instance.shares,
  'comments': instance.comments,
  'views': instance.views,
};

const _$AnnouncementStatusEnumMap = {
  AnnouncementStatus.open: 'open',
  AnnouncementStatus.closed: 'closed',
};
