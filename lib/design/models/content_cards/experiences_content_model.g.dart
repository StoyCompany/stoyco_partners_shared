// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiences_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperiencesContentModel _$ExperiencesContentModelFromJson(
  Map<String, dynamic> json,
) => ExperiencesContentModel(
  id: json['id'] as String,
  contentImageUrl: json['contentImageUrl'] as String,
  name: json['name'] as String,
  totalTickets: (json['totalTickets'] as num).toInt(),
  availableTickets: (json['availableTickets'] as num).toInt(),
  soldTickets: (json['soldTickets'] as num).toInt(),
  ticketPrice: (json['ticketPrice'] as num).toDouble(),
  totalRevenue: (json['totalRevenue'] as num).toDouble(),
  availableRevenue: (json['availableRevenue'] as num).toDouble(),
  soldRevenue: (json['soldRevenue'] as num).toDouble(),
  eventDate: json['eventDate'] as String,
  isActive: json['isActive'] as bool,
  currency: json['currency'] as String,
  finishDate: json['finishDate'] as String?,
);

Map<String, dynamic> _$ExperiencesContentModelToJson(
  ExperiencesContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'name': instance.name,
  'totalTickets': instance.totalTickets,
  'availableTickets': instance.availableTickets,
  'soldTickets': instance.soldTickets,
  'ticketPrice': instance.ticketPrice,
  'totalRevenue': instance.totalRevenue,
  'availableRevenue': instance.availableRevenue,
  'soldRevenue': instance.soldRevenue,
  'eventDate': instance.eventDate,
  'isActive': instance.isActive,
  'finishDate': instance.finishDate,
  'currency': instance.currency,
};
