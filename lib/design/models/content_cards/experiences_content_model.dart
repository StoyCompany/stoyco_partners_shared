import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'experiences_content_model.g.dart';

@JsonSerializable()
class ExperiencesContentModel extends ContentCardModel {
  const ExperiencesContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.name,
    required this.capacity,
    required this.totalTickets,
    required this.courtesyTickets,
    required this.availableTickets,
    required this.ticketPrice,
    required this.eventDate,
    required this.isFinished,
    this.finishDate,
  }) : super(contentType: ContentType.experiences);

  final String name;
  final int capacity;
  final int totalTickets;
  final int courtesyTickets;
  final int availableTickets;
  final double ticketPrice;
  final String eventDate;
  final bool isFinished;
  final String? finishDate;

  factory ExperiencesContentModel.fromJson(Map<String, dynamic> json) =>
      _$ExperiencesContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperiencesContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
    ...super.props,
    name,
    capacity,
    totalTickets,
    courtesyTickets,
    availableTickets,
    ticketPrice,
    eventDate,
    isFinished,
    finishDate,
  ];
}
