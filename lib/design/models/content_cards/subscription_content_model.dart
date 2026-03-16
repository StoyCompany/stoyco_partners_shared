import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'subscription_content_model.g.dart';

@JsonSerializable()
class SubscriptionContentModel extends ContentCardModel {
  const SubscriptionContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.packageName,
    required this.annualSubscribers,
    required this.annualPackageValue,
    required this.monthlySubscribers,
    required this.monthlyPackageValue,
    required this.totalSubscribers,
    required this.totalRevenue,
    required this.currency,
  }) : super(contentType: ContentType.suscriptions);
  factory SubscriptionContentModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubscriptionContentModelToJson(this);

  final String packageName;
  final int annualSubscribers;
  final double annualPackageValue;
  final int monthlySubscribers;
  final double monthlyPackageValue;
  final int totalSubscribers;
  final double totalRevenue;
  final String currency;

  @override
  List<Object?> get props =>
      super.props +
      <Object?>[
        packageName,
        annualSubscribers,
        annualPackageValue,
        monthlySubscribers,
        monthlyPackageValue,
        totalSubscribers,
        totalRevenue,
      ];
}
