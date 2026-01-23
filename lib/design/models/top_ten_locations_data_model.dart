import 'package:flutter/material.dart';

class TopTenLocationsData {
  TopTenLocationsData({
    required this.codeFlag,
    required this.nameLocation,
    required this.values,
  }) : total = values.fold<double>(
      0,
      (double sum, TopTenLocationsValue v) => sum + v.value,
    );

  final String codeFlag;
  final String nameLocation;
  final List<TopTenLocationsValue> values;
  final double total;
}

class TopTenLocationsValue {
  TopTenLocationsValue({
    required this.value,
    required this.colorValue,
    required this.nameCategory,
  });

  final double value;
  final Color colorValue;
  final String nameCategory;
}
