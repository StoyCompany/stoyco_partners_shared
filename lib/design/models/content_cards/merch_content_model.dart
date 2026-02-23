import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'merch_content_model.g.dart';

@JsonSerializable()
class MerchContentModel extends ContentCardModel {
  const MerchContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.price,
    required this.cost,
    required this.currency,
    required this.unitsSold,
    required this.unitsAvailable,
    required this.totalUnits,
    required this.generatedRevenue,
    required this.availableInventoryValue,
    required this.totalInitialInventoryValue,
    required this.isActive,
  }) : super(contentType: ContentType.merch);

  factory MerchContentModel.fromJson(Map<String, dynamic> json) =>
      _$MerchContentModelFromJson(json);

  final String title;
  final double price;
  final double cost;
  final String currency;
  final int unitsSold;
  final int unitsAvailable;
  final int totalUnits;
  final double generatedRevenue;
  final double availableInventoryValue;
  final double totalInitialInventoryValue;
  final bool isActive;

  Map<String, dynamic> toJson() => _$MerchContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        title,
        price,
        cost,
        currency,
        unitsSold,
        unitsAvailable,
        totalUnits,
        generatedRevenue,
        availableInventoryValue,
        totalInitialInventoryValue,
        isActive,
      ];
}
