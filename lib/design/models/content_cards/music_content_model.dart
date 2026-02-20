import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'music_content_model.g.dart';

@JsonSerializable()
class MusicContentModel extends ContentCardModel {
  const MusicContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.description,
    required this.shares,
    required this.comments,
    required this.views,
    required this.totalDonatedStoyCoins,
    required this.tracksCount,
    required this.tracks,
  }) : super(contentType: ContentType.music);

  factory MusicContentModel.fromJson(Map<String, dynamic> json) =>
      _$MusicContentModelFromJson(json);

  final String title;
  final String description;
  final int shares;
  final int comments;
  final int views;
  final int totalDonatedStoyCoins;
  final int tracksCount;
  final List<String> tracks;

  Map<String, dynamic> toJson() => _$MusicContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        title,
        description,
        shares,
        comments,
        views,
        totalDonatedStoyCoins,
        tracksCount,
        tracks,
      ];
}
