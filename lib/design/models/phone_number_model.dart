import 'package:equatable/equatable.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_number_model.g.dart';

/// A class that represents a phone number.
///
/// It contains a [Country] and a [String] number.
@JsonSerializable()
class PhoneNumber extends Equatable {
  /// Creates a [PhoneNumber].
  const PhoneNumber({this.selectedCountry, this.number});

  /// The selected country of the phone number.
  @JsonKey(toJson: _countryToJson, fromJson: _countryFromJson)
  final Country? selectedCountry;

  /// The number of the phone number.
  final String? number;

  /// Creates a copy of this [PhoneNumber] but with the given fields replaced with the new values.
  PhoneNumber copyWith({Country? selectedCountry, String? phoneNumber}) =>
      PhoneNumber(
        selectedCountry: selectedCountry ?? this.selectedCountry,
        number: phoneNumber ?? number,
      );

  /// Returns true if the phone number is valid.
  ///
  /// A phone number is valid if it has a country and a number.
  bool get isValid {
    if (number == null || number!.isEmpty || selectedCountry == null) {
      return false;
    }

    if (number!.length < selectedCountry!.minLength ||
        number!.length > selectedCountry!.maxLength) {
      return false;
    }

    return true;
  }

  /// Returns true if the country of the phone number is valid.
  bool get isValidCountry => selectedCountry != null;

  /// Returns true if the number of the phone number is valid.
  bool get isValidNumber {
    if (number == null) {
      return true;
    } else if (number!.isEmpty) {
      return false;
    } else if (selectedCountry == null) {
      return false;
    } else if (number!.length < selectedCountry!.minLength) {
      return false;
    } else if (number!.length > selectedCountry!.maxLength) {
      return false;
    }
    return true;
  }

  /// Returns true if the number of the phone number is empty.
  bool get numberIsEmpty => number != null && number!.isEmpty;

  /// Returns true if the country of the phone number is empty.
  bool get countryIsEmpty => selectedCountry == null;

  /// Returns the full phone number with country code.
  String? get fullPhoneNumber {
    if (selectedCountry == null || number == null || number!.isEmpty) {
      return null;
    }
    return '+${selectedCountry!.dialCode}$number';
  }

  // JSON Serialization
  factory PhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);

  // Country serialization helpers
  static Map<String, dynamic>? _countryToJson(Country? country) {
    if (country == null) return null;
    return {
      'name': country.name,
      'flag': country.flag,
      'code': country.code,
      'dialCode': country.dialCode,
      'minLength': country.minLength,
      'maxLength': country.maxLength,
    };
  }

  static Country? _countryFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Country(
      name: json['name'] as String,
      flag: json['flag'] as String,
      code: json['code'] as String,
      dialCode: json['dialCode'] as String,
      minLength: json['minLength'] as int,
      maxLength: json['maxLength'] as int,
      nameTranslations: {},
    );
  }

  @override
  List<Object?> get props => [selectedCountry?.code, number];
}
