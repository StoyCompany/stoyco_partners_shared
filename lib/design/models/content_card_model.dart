import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'content_card_model.g.dart';

//Todo: general model for content cards. Review how to handle for different types of content.

@JsonSerializable()
class ContentCardModel extends Equatable {
  const ContentCardModel({
    required this.contentImageUrl,
    required this.contentTitle,
    required this.contentDescription,
    required this.contentDate,
    required this.contentLikes,
    required this.contentShares,
    required this.contentViews,
  });

  factory ContentCardModel.fromJson(Map<String, dynamic> json) =>
      _$ContentCardModelFromJson(json);

  final String contentImageUrl;
  final String contentTitle;
  final String contentDescription;
  final String contentDate;
  final String contentLikes;
  final String contentShares;
  final String contentViews;

  Map<String, dynamic> toJson() => _$ContentCardModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
    contentImageUrl,
    contentTitle,
    contentDescription,
    contentDate,
    contentLikes,
    contentShares,
    contentViews,
  ];
}
