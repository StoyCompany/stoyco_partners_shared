import 'package:flutter/material.dart';

/// Data model for a bar horizontal chart group.
class BarHorizontalGroupData {
  const BarHorizontalGroupData({
    required this.range,
    required this.categories,
  });

  /// The range label (e.g., "18", "19-30", "31-35")
  final String range;
  
  /// Map of category name to value (e.g., {"male": 400, "female": 400})
  final Map<String, double> categories;
}

/// Configuration for a category in the chart.
class BarHorizontalCategoryConfig {
  const BarHorizontalCategoryConfig({
    required this.key,
    required this.color,
    this.label,
  });

  /// The key that matches the category in the data
  final String key;
  
  /// The color for this category's bars
  final Color color;
  
  /// Optional display label (defaults to key if not provided)
  final String? label;
  
  String get displayLabel => label ?? key;
}
