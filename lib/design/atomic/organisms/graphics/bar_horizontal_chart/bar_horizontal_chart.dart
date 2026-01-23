import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/chip_monotone_noise.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/chart_legend/chart_legend.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/graphics/bar_horizontal_chart/bar_horizontal_chart_data.dart';
import 'package:stoyco_partners_shared/design/models/chart_legend_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class BarHorizontalChart extends StatefulWidget {
  const BarHorizontalChart({
    super.key,
    required this.data,
    required this.categoryConfigs,
    required this.rangeDate,
    required this.filtersSelector,
    this.height,
    this.barHeight = 24,
    this.barSpacing = 0,
    this.groupSpacing = 1,
    this.barBorderRadius = 4,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  final List<BarHorizontalGroupData> data;
  final List<BarHorizontalCategoryConfig> categoryConfigs;
  final String rangeDate;
  final List<String> filtersSelector;
  final double? height;
  final double barHeight;
  final double barSpacing;
  final double groupSpacing;
  final double barBorderRadius;
  final Duration animationDuration;

  @override
  State<BarHorizontalChart> createState() => _BarHorizontalChartState();
}

class _BarHorizontalChartState extends State<BarHorizontalChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(BarHorizontalChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<ChartLegendItemModel> get legendItems => widget.categoryConfigs
      .map(
        (BarHorizontalCategoryConfig config) => ChartLegendItemModel(
          color: config.color,
          label: config.displayLabel,
        ),
      )
      .toList();

  double _calculateMaxValue() {
    double maxValue = 0;
    for (final BarHorizontalGroupData group in widget.data) {
      double groupTotal = 0;
      for (final BarHorizontalCategoryConfig config in widget.categoryConfigs) {
        groupTotal += group.categories[config.key] ?? 0;
      }
      if (groupTotal > maxValue) {
        maxValue = groupTotal;
      }
    }
    return maxValue;
  }

  List<double> _calculateXAxisScale(double maxValue) {
    if (maxValue == 0) {
      return <double>[0, 0, 0, 0, 0];
    }

    // Redondear hacia arriba a un número "bonito"
    final double magnitude = math
        .pow(10, (math.log(maxValue) / math.ln10).floor())
        .toDouble();
    final double normalized = maxValue / magnitude;

    double niceMax;
    if (normalized <= 1.0) {
      niceMax = magnitude;
    } else if (normalized <= 2.0) {
      niceMax = 2 * magnitude;
    } else if (normalized <= 5.0) {
      niceMax = 5 * magnitude;
    } else {
      niceMax = 10 * magnitude;
    }

    // Generar 5 valores equidistantes
    final double step = niceMax / 4;
    return List<double>.generate(5, (int index) => step * index);
  }

  double _countVisibleBarsInGroup(BarHorizontalGroupData group) {
    return group.categories.values.where((double v) => v > 0).length.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final double maxValue = _calculateMaxValue();
    final List<double> xAxisScale = _calculateXAxisScale(maxValue);
    final double chartMaxValue = xAxisScale.last;

    double totalHeight = 0;
    for (final BarHorizontalGroupData group in widget.data) {
      final double visibleBars = _countVisibleBarsInGroup(group);
      final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
      totalHeight +=
          (visibleBars * widget.barHeight) +
          spacingInGroup +
          (widget.groupSpacing * 2);
    }
    final double calculatedHeight = totalHeight + 60;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: StoycoScreenSize.symmetric(
            context,
            horizontal: 16,
          ),
          child: SizedBox(
            width: StoycoScreenSize.screenWidth(context),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ChipMonotoneNoise(
                    message: widget.filtersSelector.join(', '),
                  ),
                ),
                Gap(StoycoScreenSize.width(context, 16)),
                Expanded(
                  child: ChipMonotoneNoise(
                    message: widget.rangeDate,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(StoycoScreenSize.height(context, 28)),
        ChartLegend(items: legendItems),
        Gap(StoycoScreenSize.height(context, 28)),
        SizedBox(
          height: widget.height ?? calculatedHeight,
          width: StoycoScreenSize.screenWidth(context) * 0.9,
          child: RepaintBoundary(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                const double yAxisWidth = 60;
                const double xAxisHeight = 40;
                final double chartWidth = constraints.maxWidth - yAxisWidth;
                final double chartHeight = constraints.maxHeight - xAxisHeight;

                return Column(
                  children: <Widget>[
                    // Chart area
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Y-axis (ranges)
                          SizedBox(
                            width: yAxisWidth,
                            child: Column(
                              children: widget.data.map((
                                BarHorizontalGroupData group,
                              ) {
                                final double visibleBars =
                                    _countVisibleBarsInGroup(group);
                                final double spacingInGroup =
                                    (visibleBars - 1) * widget.barSpacing;
                                final double groupHeight =
                                    (visibleBars * widget.barHeight) +
                                    spacingInGroup;
                                return SizedBox(
                                  height:
                                      groupHeight + (widget.groupSpacing * 2),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: widget.groupSpacing,
                                      bottom: widget.groupSpacing,
                                      right: StoycoScreenSize.width(context, 8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        group.range,
                                        style: TextStyle(
                                          fontSize: StoycoScreenSize.width(
                                            context,
                                            14,
                                          ),
                                          color:
                                              ColorFoundation.background.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              StoycoFontFamilyToken.gilroy,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // Bars area
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (BuildContext context, Widget? child) {
                                return CustomPaint(
                                  size: Size(chartWidth, chartHeight),
                                  painter: _BarHorizontalPainter(
                                    data: widget.data,
                                    categoryConfigs: widget.categoryConfigs,
                                    maxValue: chartMaxValue,
                                    barHeight: widget.barHeight,
                                    barSpacing: widget.barSpacing,
                                    groupSpacing: widget.groupSpacing,
                                    barBorderRadius: widget.barBorderRadius,
                                    animation: _animation,
                                    xAxisScale: xAxisScale,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // X-axis
                    Row(
                      children: <Widget>[
                        const SizedBox(width: yAxisWidth),
                        Expanded(
                          child: SizedBox(
                            height: xAxisHeight,
                            child: Stack(
                              children: xAxisScale.map((double value) {
                                final double position = value / chartMaxValue;
                                return Positioned(
                                  left:
                                      position *
                                      (constraints.maxWidth - yAxisWidth),
                                  child: Text(
                                    NumbersFormat.formatCompact(value),
                                    style: TextStyle(
                                      fontSize: StoycoScreenSize.width(
                                        context,
                                        15,
                                      ),
                                      color: ColorFoundation.background.fandom,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: StoycoFontFamilyToken.gilroy,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BarHorizontalPainter extends CustomPainter {
  _BarHorizontalPainter({
    required this.data,
    required this.categoryConfigs,
    required this.maxValue,
    required this.barHeight,
    required this.barSpacing,
    required this.groupSpacing,
    required this.barBorderRadius,
    required this.animation,
    required this.xAxisScale,
  }) : super(repaint: animation);

  final List<BarHorizontalGroupData> data;
  final List<BarHorizontalCategoryConfig> categoryConfigs;
  final double maxValue;
  final double barHeight;
  final double barSpacing;
  final double groupSpacing;
  final double barBorderRadius;
  final Animation<double> animation;
  final List<double> xAxisScale;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint separatorPaint = Paint()
      ..color = ColorFoundation.background.divider
      ..strokeWidth = groupSpacing
      ..strokeCap = StrokeCap.square;

    double currentY = 0;

    // Draw bars
    for (int groupIndex = 0; groupIndex < data.length; groupIndex++) {
      final BarHorizontalGroupData group = data[groupIndex];

      // Línea divisora al inicio del grupo
      final double lineY = currentY + (groupSpacing / 2);
      canvas.drawLine(
        Offset(0, lineY),
        Offset(size.width, lineY),
        separatorPaint,
      );
      currentY += groupSpacing;

      for (
        int categoryIndex = 0;
        categoryIndex < categoryConfigs.length;
        categoryIndex++
      ) {
        final BarHorizontalCategoryConfig config =
            categoryConfigs[categoryIndex];
        final double value = group.categories[config.key] ?? 0;

        if (value > 0) {
          final double barWidth =
              (value / maxValue) * size.width * animation.value;

          final Paint barPaint = Paint()
            ..color = config.color
            ..style = PaintingStyle.fill;

          final RRect barRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(0, currentY, barWidth, barHeight),
            Radius.circular(barBorderRadius),
          );

          canvas.drawRRect(barRect, barPaint);

          currentY += barHeight;

          // Agregar espaciado entre barras del mismo grupo (solo si no es la última barra visible)
          bool hasMoreVisibleBars = false;
          for (int j = categoryIndex + 1; j < categoryConfigs.length; j++) {
            if ((group.categories[categoryConfigs[j].key] ?? 0) > 0) {
              hasMoreVisibleBars = true;
              break;
            }
          }
          if (hasMoreVisibleBars) {
            currentY += barSpacing;
          }
        }
      }

      // Línea divisora al final del grupo
      final double endLineY = currentY + (groupSpacing / 2);
      canvas.drawLine(
        Offset(0, endLineY),
        Offset(size.width, endLineY),
        separatorPaint,
      );
      currentY += groupSpacing;
    }
  }

  @override
  bool shouldRepaint(_BarHorizontalPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value;
  }
}
