import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'projects_to_fund_content_model.g.dart';

@JsonSerializable()
class ProjectsToFundContentModel extends ContentCardModel {
  const ProjectsToFundContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.description,
    required this.publishDate,
    required this.closeDate,
    required this.isActive,
    required this.stoycoCoins,
    required this.donation,
    required this.likes,
    required this.shares,
    required this.comments,
    required this.views,
  }) : super(contentType: ContentType.projectsToFund);

  factory ProjectsToFundContentModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectsToFundContentModelFromJson(json);

  final String title;
  final String description;
  final DateTime publishDate;
  final DateTime closeDate;
  final bool isActive;
  final int stoycoCoins;
  final int donation;
  final int likes;
  final int shares;
  final int comments;
  final int views;

  Map<String, dynamic> toJson() => _$ProjectsToFundContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        title,
        description,
        publishDate,
        stoycoCoins,
        donation,
        likes,
        shares,
        comments,
        views,
      ];
}
