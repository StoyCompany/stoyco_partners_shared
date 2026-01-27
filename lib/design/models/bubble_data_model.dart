import 'package:flutter/material.dart';

class BubbleData {
  BubbleData({
    required this.value,
    required this.color,
  });

  final double value;
  final Color color;
}

class BubblePosition {
  BubblePosition({
    required this.data,
    required this.radius,
    required this.offset,
    required this.angle,
  });

  final BubbleData data;
  final double radius;
  final Offset offset;
  final double angle;
}
