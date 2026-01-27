import 'package:flutter/widgets.dart';

class PieChartSectionData {
  const PieChartSectionData({
    required this.value,
    required this.color,
    this.label,
  });

  final double value;
  final Color color;
  final String? label;
}
