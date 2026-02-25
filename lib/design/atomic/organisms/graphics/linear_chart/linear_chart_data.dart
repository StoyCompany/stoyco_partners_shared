import 'package:flutter/material.dart';

enum TrendType {
  neutral,
  down,
  up;

  static TrendType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'neutral':
        return TrendType.neutral;
      case 'down':
        return TrendType.down;
      case 'up':
        return TrendType.up;
      default:
        return TrendType.neutral;
    }
  }
}

class LinearChartData {
  const LinearChartData({
    required this.dateStart,
    required this.dateEnd,
    required this.rangeX,
    required this.rangeY,
    required this.pointsFan,
    required this.pointsMember,
    required this.pointsSuperfan,
    required this.pointsMonetizedFan,
  });

  factory LinearChartData.fromJson(Map<String, dynamic> json) {
    return LinearChartData(
      dateStart: DateTime.parse(json['dateStart'] as String),
      dateEnd: DateTime.parse(json['dateEnd'] as String),
      rangeX: (json['rangeX'] as List<dynamic>)
          .map((dynamic e) => e.toString())
          .toList(),
      rangeY: (json['rangeY'] as List<dynamic>)
          .map((dynamic e) => (e as num).toDouble())
          .toList(),
      pointsFan: (json['pointsFan'] as List<dynamic>)
          .map(
            (dynamic e) => LinearChartPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      pointsMember: (json['pointsMember'] as List<dynamic>)
          .map(
            (dynamic e) => LinearChartPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      pointsSuperfan: (json['pointsSuperfan'] as List<dynamic>)
          .map(
            (dynamic e) => LinearChartPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      pointsMonetizedFan: (json['pointsMonetizedFan'] as List<dynamic>)
          .map(
            (dynamic e) => LinearChartPoint.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final DateTime dateStart;
  final DateTime dateEnd;
  final List<String> rangeX;
  final List<double> rangeY;
  final List<LinearChartPoint> pointsFan;
  final List<LinearChartPoint> pointsMember;
  final List<LinearChartPoint> pointsSuperfan;
  final List<LinearChartPoint> pointsMonetizedFan;
}

class LinearChartPoint {
  const LinearChartPoint({
    required this.total,
    required this.trend,
    required this.date,
  });

  factory LinearChartPoint.fromJson(Map<String, dynamic> json) {
    return LinearChartPoint(
      total: json['total'] as int,
      trend: TrendType.fromString(json['trend'] as String),
      date: DateTime.parse(json['date'] as String),
    );
  }

  final int total;
  final TrendType trend;
  final DateTime date;
}

class LinearChartLineConfig {
  const LinearChartLineConfig({
    required this.key,
    required this.displayLabel,
    required this.color,
    this.strokeWidth = 1.0,
    this.dotSize = 3.0,
    this.touchRadius = 12.0,
  });

  final String key;
  final String displayLabel;
  final Color color;
  final double strokeWidth;
  final double dotSize;
  final double touchRadius;
}
