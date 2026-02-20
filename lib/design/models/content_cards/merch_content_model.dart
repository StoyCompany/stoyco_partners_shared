import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'merch_content_model.g.dart';

@JsonSerializable()
class MerchContentModel extends ContentCardModel {
  const MerchContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.description,
    required this.publishDate,
    required this.likes,
    required this.shares,
    required this.comments,
    required this.views,
  }) : super(contentType: ContentType.merch);

  factory MerchContentModel.fromJson(Map<String, dynamic> json) =>
      _$MerchContentModelFromJson(json);

  final String title;
  final String description;
  final String publishDate;
  final int likes;
  final int shares;
  final int comments;
  final int views;

  Map<String, dynamic> toJson() => _$MerchContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        title,
        description,
        publishDate,
        likes,
        shares,
        comments,
        views,
      ];
}
