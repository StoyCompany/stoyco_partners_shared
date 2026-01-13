// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneNumber _$PhoneNumberFromJson(Map<String, dynamic> json) => PhoneNumber(
  selectedCountry: PhoneNumber._countryFromJson(
    json['selectedCountry'] as Map<String, dynamic>?,
  ),
  number: json['number'] as String?,
);

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber instance) =>
    <String, dynamic>{
      'selectedCountry': PhoneNumber._countryToJson(instance.selectedCountry),
      'number': instance.number,
    };
