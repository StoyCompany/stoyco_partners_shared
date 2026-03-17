// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionContentModel _$SubscriptionContentModelFromJson(
  Map<String, dynamic> json,
) => SubscriptionContentModel(
  id: json['id'] as String,
  contentImageUrl: json['contentImageUrl'] as String,
  packageName: json['packageName'] as String,
  annualSubscribers: (json['annualSubscribers'] as num).toInt(),
  annualPackageValue: (json['annualPackageValue'] as num).toDouble(),
  monthlySubscribers: (json['monthlySubscribers'] as num).toInt(),
  monthlyPackageValue: (json['monthlyPackageValue'] as num).toDouble(),
  totalSubscribers: (json['totalSubscribers'] as num).toInt(),
  totalRevenue: (json['totalRevenue'] as num).toDouble(),
  currency: json['currency'] as String,
  exclusiveContentList: (json['exclusiveContentList'] as List<dynamic>?)
      ?.map((e) => ExclusiveContentData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SubscriptionContentModelToJson(
  SubscriptionContentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contentImageUrl': instance.contentImageUrl,
  'packageName': instance.packageName,
  'annualSubscribers': instance.annualSubscribers,
  'annualPackageValue': instance.annualPackageValue,
  'monthlySubscribers': instance.monthlySubscribers,
  'monthlyPackageValue': instance.monthlyPackageValue,
  'totalSubscribers': instance.totalSubscribers,
  'totalRevenue': instance.totalRevenue,
  'currency': instance.currency,
  'exclusiveContentList': instance.exclusiveContentList,
};

ExclusiveContentData _$ExclusiveContentDataFromJson(
  Map<String, dynamic> json,
) => ExclusiveContentData(
  name: json['name'] as String?,
  countContent: (json['countContent'] as num?)?.toInt(),
  views: (json['views'] as num?)?.toInt(),
  engagement: (json['engagement'] as num?)?.toDouble(),
  conversion: (json['conversion'] as num?)?.toDouble(),
);

Map<String, dynamic> _$ExclusiveContentDataToJson(
  ExclusiveContentData instance,
) => <String, dynamic>{
  'name': instance.name,
  'countContent': instance.countContent,
  'views': instance.views,
  'engagement': instance.engagement,
  'conversion': instance.conversion,
};
