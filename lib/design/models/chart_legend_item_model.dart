import 'package:flutter/material.dart';

/// Data model for a chart legend item.
class ChartLegendItemModel {
  const ChartLegendItemModel({
    required this.color,
    required this.label,
    this.value = '',
  });

  /// The color indicator for this legend item.
  final Color color;

  /// The label text displayed next to the color indicator.
  final String label;

  /// The value displayed below (e.g., "20%").
  final String value;
}
