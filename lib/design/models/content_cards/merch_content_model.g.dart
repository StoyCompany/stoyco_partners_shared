// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merch_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchContentModel _$MerchContentModelFromJson(Map<String, dynamic> json) =>
    MerchContentModel(
      id: json['id'] as String,
      contentImageUrl: json['contentImageUrl'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      cost: (json['cost'] as num).toDouble(),
      currency: json['currency'] as String,
      unitsSold: (json['unitsSold'] as num).toInt(),
      unitsAvailable: (json['unitsAvailable'] as num).toInt(),
      totalUnits: (json['totalUnits'] as num).toInt(),
      generatedRevenue: (json['generatedRevenue'] as num).toDouble(),
      availableInventoryValue: (json['availableInventoryValue'] as num)
          .toDouble(),
      totalInitialInventoryValue: (json['totalInitialInventoryValue'] as num)
          .toDouble(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$MerchContentModelToJson(MerchContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contentImageUrl': instance.contentImageUrl,
      'title': instance.title,
      'price': instance.price,
      'cost': instance.cost,
      'currency': instance.currency,
      'unitsSold': instance.unitsSold,
      'unitsAvailable': instance.unitsAvailable,
      'totalUnits': instance.totalUnits,
      'generatedRevenue': instance.generatedRevenue,
      'availableInventoryValue': instance.availableInventoryValue,
      'totalInitialInventoryValue': instance.totalInitialInventoryValue,
      'isActive': instance.isActive,
    };
