import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'experiences_content_model.g.dart';

@JsonSerializable()
class ExperiencesContentModel extends ContentCardModel {
  const ExperiencesContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.name,
    required this.totalTickets,
    required this.availableTickets,
    required this.soldTickets,
    required this.ticketPrice,
    required this.totalRevenue,
    required this.availableRevenue,
    required this.soldRevenue,
    required this.eventDate,
    required this.isActive,
    required this.currency,
    this.finishDate,
  }) : super(contentType: ContentType.experiences);

  factory ExperiencesContentModel.fromJson(Map<String, dynamic> json) =>
      _$ExperiencesContentModelFromJson(json);

  final String name;
  final int totalTickets;
  final int availableTickets;
  final int soldTickets;
  final double ticketPrice;
  final double totalRevenue;
  final double availableRevenue;
  final double soldRevenue;
  final String eventDate;
  final bool isActive;
  final String? finishDate;
  final String currency;

  Map<String, dynamic> toJson() => _$ExperiencesContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
    ...super.props,
    name,
    totalTickets,
    availableTickets,
    soldTickets,
    ticketPrice,
    totalRevenue,
    availableRevenue,
    soldRevenue,
    eventDate,
    isActive,
    finishDate,
    currency,
  ];
}
