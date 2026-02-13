import 'package:flutter/material.dart';

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
    required this.label,
    required this.male,
    required this.female,
    required this.nonBinary,
    required this.other,
    required this.noData,
  });

  factory LinearChartPoint.fromJson(Map<String, dynamic> json) {
    return LinearChartPoint(
      label: json['label'] as String,
      male: (json['male'] as num).toDouble(),
      female: (json['female'] as num).toDouble(),
      nonBinary: (json['nonBinary'] as num).toDouble(),
      other: (json['other'] as num).toDouble(),
      noData: (json['noData'] as num).toDouble(),
    );
  }

  final String label;
  final double male;
  final double female;
  final double nonBinary;
  final double other;
  final double noData;

  double get total => male + female + nonBinary + other + noData;
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
