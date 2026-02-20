import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'cultural_assets_content_model.g.dart';

@JsonSerializable()
class CulturalAssetsContentModel extends ContentCardModel {
  const CulturalAssetsContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.stoycoCoins,
    required this.holders,
    required this.available,
  }) : super(contentType: ContentType.culturalAssets);

  factory CulturalAssetsContentModel.fromJson(Map<String, dynamic> json) =>
      _$CulturalAssetsContentModelFromJson(json);

  final String title;
  final int stoycoCoins;
  final int holders;
  final int available;

  Map<String, dynamic> toJson() => _$CulturalAssetsContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        title,
        stoycoCoins,
        holders,
        available,
      ];
}
