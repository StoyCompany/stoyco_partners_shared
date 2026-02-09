import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'video_content_model.g.dart';

@JsonSerializable()
class VideoContentModel extends ContentCardModel {
  const VideoContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.description,
    required this.views,
    required this.likes,
    required this.shares,
    required this.publishDate,
  }) : super(contentType: ContentType.video);
  factory VideoContentModel.fromJson(Map<String, dynamic> json) =>
      _$VideoContentModelFromJson(json);

  final String title;
  final String description;
  final int views;
  final int likes;
  final int shares;
  final String publishDate;

  Map<String, dynamic> toJson() => _$VideoContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
    ...super.props,
    title,
    description,
    views,
    likes,
    shares,
    publishDate,
  ];
}
