import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'dynamics_content_model.g.dart';

@JsonSerializable()
class DynamicsContentModel extends ContentCardModel {
  const DynamicsContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.description,
    required this.publishDate,
    required this.uniqueParticipants,
    required this.likes,
    required this.shares,
    required this.comments,
    required this.views,
  }) : super(contentType: ContentType.dynamics);

  factory DynamicsContentModel.fromJson(Map<String, dynamic> json) =>
      _$DynamicsContentModelFromJson(json);

  final String title;
  final String description;
  final DateTime publishDate;
  final int uniqueParticipants;
  final int likes;
  final int shares;
  final int comments;
  final int views;

  Map<String, dynamic> toJson() => _$DynamicsContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        title,
        description,
        publishDate,
        uniqueParticipants,
        likes,
        shares,
        comments,
        views,
      ];
}
