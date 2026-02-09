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
  capacity: (json['capacity'] as num).toInt(),
  totalTickets: (json['totalTickets'] as num).toInt(),
  courtesyTickets: (json['courtesyTickets'] as num).toInt(),
  availableTickets: (json['availableTickets'] as num).toInt(),
  ticketPrice: (json['ticketPrice'] as num).toDouble(),
  eventDate: json['eventDate'] as String,
  isFinished: json['isFinished'] as bool,
  finishDate: json['finishDate'] as String?,
);

Map<String, dynamic> _$ExperiencesContentModelToJson(
  ExperiencesContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'name': instance.name,
  'capacity': instance.capacity,
  'totalTickets': instance.totalTickets,
  'courtesyTickets': instance.courtesyTickets,
  'availableTickets': instance.availableTickets,
  'ticketPrice': instance.ticketPrice,
  'eventDate': instance.eventDate,
  'isFinished': instance.isFinished,
  'finishDate': instance.finishDate,
};
