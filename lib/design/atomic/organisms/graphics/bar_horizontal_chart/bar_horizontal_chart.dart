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


/// A horizontal bar chart widget for visualizing grouped data with multiple categories per group.
///
/// Each group is rendered as a set of horizontal bars, one for each category, with configurable colors and labels.
/// The chart supports animated transitions, tooltips, and responsive sizing.
///
/// Example usage:
/// ```dart
/// BarHorizontalChart(
///   data: [...],
///   categoryConfigs: [...],
/// )
/// ```
class BarHorizontalChart extends StatefulWidget {
  /// Creates a horizontal bar chart.
  ///
  /// [data] is the list of groups to display.
  /// [categoryConfigs] defines the categories and their colors/labels.
  /// [height] optionally sets the chart height.
  /// [barHeight] sets the height of each bar.
  /// [barSpacing] sets the spacing between bars within a group.
  /// [groupSpacing] sets the spacing between groups.
  /// [barBorderRadius] sets the border radius for bars.
  /// [animationDuration] controls the animation duration.
  /// [xAxisValues] optionally overrides the calculated X axis scale.
  const BarHorizontalChart({
    super.key,
    required this.data,
    required this.categoryConfigs,
    this.height,
    this.barHeight = 24,
    this.barSpacing = 0,
    this.groupSpacing = 1,
    this.barBorderRadius = 4,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.xAxisValues,
  });

  final List<BarHorizontalGroupData> data;
  final List<BarHorizontalCategoryConfig> categoryConfigs;
  final double? height;
  final double barHeight;
  final List<double>? xAxisValues;
  final double barSpacing;
  final double groupSpacing;
  final double barBorderRadius;
  final Duration animationDuration;

  @override
  State<BarHorizontalChart> createState() => _BarHorizontalChartState();
}

/// State for [BarHorizontalChart]. Handles animation, selection, and layout calculations.
class _BarHorizontalChartState extends State<BarHorizontalChart>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int? _selectedGroupIndex;

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

  /// Returns the legend items for the chart, based on category configs.
  List<ChartLegendItemModel> get legendItems => widget.categoryConfigs
      .map(
        (BarHorizontalCategoryConfig config) => ChartLegendItemModel(
          color: config.color,
          label: config.displayLabel,
        ),
      )
      .toList();

  /// Calculates the maximum value among all bars, used for scaling.
  double _calculateMaxValue() {
    double maxValue = 0;
    for (final BarHorizontalGroupData group in widget.data) {
      for (final BarHorizontalCategoryConfig config in widget.categoryConfigs) {
        // Instead of summing (groupTotal), evaluate each bar individually
        final double value = group.categories[config.key] ?? 0;
        if (value > maxValue) {
          maxValue = value;
        }
      }
    }
    if (maxValue.isNaN || maxValue.isInfinite) {
      maxValue = 0;
    }
    return maxValue;
  }

  /// Generates a "nice" X axis scale based on the max value, for better tick spacing.
  List<double> _calculateXAxisScale(double maxValue) {
    if (maxValue == 0 || maxValue.isNaN || maxValue.isInfinite) {
      return <double>[0, 0, 0, 0, 0];
    }

    final double magnitude = math
        .pow(10, (math.log(maxValue) / math.ln10).floor())
        .toDouble();
    final double normalized = maxValue / magnitude;

    double niceMax;
    if (normalized <= 1.0) {
      niceMax = magnitude;
    } else if (normalized <= 2.0) {
      niceMax = 2 * magnitude;
    }
    else if (normalized <= 5.0) {
      niceMax = 5 * magnitude;
    }
    else {
      niceMax = 10 * magnitude;
    }
    // Divide into 4 segments to generate 5 points (e.g., 0, 25, 50, 75, 100)
    final double step = niceMax / 4;
    return List<double>.generate(5, (int index) => step * index);
  }

  /// Checks if there is any data within the X axis range.
  bool _hasDataInRange(List<double> xAxisScale) {
    if (xAxisScale.isEmpty || xAxisScale.first == 0) {
      return true;
    }

    final double minRange = xAxisScale.first;

    for (final BarHorizontalGroupData group in widget.data) {
      for (final double value in group.categories.values) {
        if (value >= minRange) {
          return true;
        }
      }
    }

    return false;
  }

  /// Returns the number of visible (non-zero) bars in a group.
  double _countVisibleBarsInGroup(BarHorizontalGroupData group) {
    return group.categories.values.where((double v) => v > 0).length.toDouble();
  }

  /// Calculates the total value for a group (sum of all categories).
  double _calculateGroupTotal(BarHorizontalGroupData group) {
    return group.categories.values.fold(
      0.0,
      (double sum, double value) => sum + value,
    );
  }

  /// Builds the tooltip widget for a group, showing category values and total.
  Widget _buildTooltipContent(BarHorizontalGroupData group) {
    final double total = _calculateGroupTotal(group);
    final List<Widget> items = <Widget>[];
    final bool isNE = group.range.contains('N/E');

    items.add(
      Text(
        isNE ? 'No especificado' : group.range,
        style: TextStyle(
          package: 'stoyco_partners_shared',
          fontSize: StoycoScreenSize.width(context, 16),
          color: ColorFoundation.text.white,
          fontWeight: FontWeight.bold,
          fontFamily: StoycoFontFamilyToken.gilroy,
        ),
      ),
    );

    items.add(Gap(StoycoScreenSize.height(context, 4)));

    if (!isNE) {
      for (final BarHorizontalCategoryConfig config in widget.categoryConfigs) {
        final double value = group.categories[config.key] ?? 0;
        if (value > 0) {
          items.add(
            Text(
              '${config.displayLabel}: ${NumbersFormat.formatWithCommas(value)}',
              style: TextStyle(
                package: 'stoyco_partners_shared',
                fontSize: StoycoScreenSize.width(context, 14),
                color: ColorFoundation.text.white,
                fontWeight: FontWeight.w400,
                fontFamily: StoycoFontFamilyToken.apercu,
              ),
            ),
          );
        }
      }
    }

    items.add(Gap(StoycoScreenSize.height(context, 4)));

    items.add(
      Text(
        'Total: ${NumbersFormat.formatWithCommas(total)}',
        style: TextStyle(
          package: 'stoyco_partners_shared',
          fontSize: StoycoScreenSize.width(context, 14),
          color: ColorFoundation.text.white,
          fontWeight: FontWeight.bold,
          fontFamily: StoycoFontFamilyToken.apercu,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  /// Builds the main chart widget, including legend, axes, bars, and tooltips.
  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return SizedBox(
        height: StoycoScreenSize.height(context, 200),
        child: Center(
          child: Text(
            'Sin datos disponibles',
            style: TextStyle(
              package: 'stoyco_partners_shared',
              fontSize: StoycoScreenSize.width(context, 16),
              color: ColorFoundation.text.fandom,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.apercu,
            ),
          ),
        ),
      );
    }

    final double maxValue = _calculateMaxValue();
    final List<double> xAxisScale = widget.xAxisValues ?? _calculateXAxisScale(maxValue);

    final List<double> validatedXAxisScale = xAxisScale;

    if (!_hasDataInRange(validatedXAxisScale)) {
      return SizedBox(
        height: StoycoScreenSize.height(context, 200),
        child: Center(
          child: Text(
            'Datos no encontrados en el rango suministrado',
            style: TextStyle(
              package: 'stoyco_partners_shared',
              fontSize: StoycoScreenSize.width(context, 16),
              color: ColorFoundation.text.fandom,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final double chartMaxValue = validatedXAxisScale.last;

    final List<BarHorizontalGroupData> reversedData = widget.data.reversed
        .toList();

    const double minGroupHeight = 60.0;

    double totalHeight = 0;
    for (final BarHorizontalGroupData group in reversedData) {
      final double visibleBars = _countVisibleBarsInGroup(group);
      final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
      final double calculatedGroupHeight =
          (visibleBars * widget.barHeight) + spacingInGroup;
      final double groupHeight = math.max(
        calculatedGroupHeight,
        minGroupHeight,
      );
      totalHeight += groupHeight + (widget.groupSpacing * 2);
    }
    final double calculatedHeight = totalHeight + 60;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: StoycoScreenSize.width(context, 16),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ChartLegend(items: legendItems),
          ),
        ),
        Gap(StoycoScreenSize.height(context, 28)),
        SizedBox(
          height: widget.height ?? calculatedHeight,
          width: StoycoScreenSize.screenWidth(context) * 0.9,
          child: RepaintBoundary(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                const double yAxisWidth = 70;
                const double xAxisHeight = 40;

                final int segments = validatedXAxisScale.length > 1
                    ? validatedXAxisScale.length - 1
                    : 1;
                final double minRequiredWidth = segments * 100.0;

                final double scrollableChartWidth = math.max(
                  constraints.maxWidth - yAxisWidth,
                  minRequiredWidth,
                );

                final double chartHeight = constraints.maxHeight - xAxisHeight;

                return Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: yAxisWidth,
                          child: Column(
                            children: reversedData.asMap().entries.map((
                              MapEntry<int, BarHorizontalGroupData> entry,
                            ) {
                              final BarHorizontalGroupData group = entry.value;
                              final double visibleBars =
                                  _countVisibleBarsInGroup(group);
                              final double spacingInGroup =
                                  (visibleBars - 1) * widget.barSpacing;
                              final double calculatedGroupHeight =
                                  (visibleBars * widget.barHeight) +
                                  spacingInGroup;
                              final double groupHeight = math.max(
                                calculatedGroupHeight,
                                minGroupHeight,
                              );

                              return SizedBox(
                                height: groupHeight + (widget.groupSpacing * 2),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: widget.groupSpacing,
                                    bottom: widget.groupSpacing,
                                    right: StoycoScreenSize.width(context, 12),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      group.range,
                                      style: TextStyle(
                                        package: 'stoyco_partners_shared',
                                        fontSize: StoycoScreenSize.width(
                                          context,
                                          14,
                                        ),
                                        color: ColorFoundation.background.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            StoycoFontFamilyToken.apercu,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: StoycoScreenSize.fromLTRB(context, right: 30),
                              child: SizedBox(
                                width: scrollableChartWidth,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: Stack(
                                        children: <Widget>[
                                          AnimatedBuilder(
                                            animation: _animation,
                                            builder:
                                                (
                                                  BuildContext context,
                                                  Widget? child,
                                                ) {
                                                  return CustomPaint(
                                                    size: Size(
                                                      scrollableChartWidth,
                                                      chartHeight,
                                                    ),
                                                    painter:
                                                        _BarHorizontalPainter(
                                                          data: reversedData,
                                                          categoryConfigs: widget
                                                              .categoryConfigs,
                                                          maxValue: chartMaxValue,
                                                          barHeight:
                                                              widget.barHeight,
                                                          barSpacing:
                                                              widget.barSpacing,
                                                          groupSpacing:
                                                              widget.groupSpacing,
                                                          barBorderRadius: widget
                                                              .barBorderRadius,
                                                          animation: _animation,
                                                          xAxisScale: xAxisScale,
                                                          minGroupHeight:
                                                              minGroupHeight,
                                                          selectedGroupIndex:
                                                              _selectedGroupIndex,
                                                        ),
                                                  );
                                                },
                                          ),
                                          ...reversedData.asMap().entries.map((
                                            MapEntry<int, BarHorizontalGroupData>
                                            entry,
                                          ) {
                                            final int index = entry.key;
                                            final BarHorizontalGroupData group =
                                                entry.value;
                              
                                            double yPosition = 0;
                                            for (int i = 0; i < index; i++) {
                                              final double visibleBars =
                                                  _countVisibleBarsInGroup(
                                                    reversedData[i],
                                                  );
                                              final double spacingInGroup =
                                                  (visibleBars - 1) *
                                                  widget.barSpacing;
                                              final double calculatedGroupHeight =
                                                  (visibleBars *
                                                      widget.barHeight) +
                                                  spacingInGroup;
                                              final double groupHeight = math.max(
                                                calculatedGroupHeight,
                                                minGroupHeight,
                                              );
                                              yPosition +=
                                                  groupHeight +
                                                  (widget.groupSpacing * 2);
                                            }
                              
                                            final double visibleBars =
                                                _countVisibleBarsInGroup(group);
                                            final double spacingInGroup =
                                                (visibleBars - 1) *
                                                widget.barSpacing;
                                            final double calculatedGroupHeight =
                                                (visibleBars * widget.barHeight) +
                                                spacingInGroup;
                                            final double groupHeight = math.max(
                                              calculatedGroupHeight,
                                              minGroupHeight,
                                            );
                              
                                            return Positioned(
                                              left: 0,
                                              top: yPosition,
                                              width: scrollableChartWidth,
                                              height:
                                                  groupHeight +
                                                  (widget.groupSpacing * 2),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedGroupIndex =
                                                        _selectedGroupIndex ==
                                                            index
                                                        ? null
                                                        : index;
                                                  });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: xAxisHeight,
                                      width: scrollableChartWidth,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: validatedXAxisScale.map((
                                          double value,
                                        ) {
                                          final double percent =
                                              chartMaxValue == 0
                                              ? 0
                                              : value / chartMaxValue;
                              
                                          final Widget label = Text(
                                            NumbersFormat.formatCompact(value),
                                            style: TextStyle(
                                              package: 'stoyco_partners_shared',
                                              fontSize: StoycoScreenSize.width(
                                                context,
                                                14,
                                              ),
                                              color: ColorFoundation
                                                  .background
                                                  .fandom,
                                              fontWeight: FontWeight.w400,
                                              fontFamily:
                                                  StoycoFontFamilyToken.apercu,
                                            ),
                                          );
                                          if (percent <= 0.0) {
                                            return Positioned(
                                              left: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: label,
                                              ),
                                            );
                                          }
                                          else {
                                            final double leftPosition =
                                                percent * scrollableChartWidth;
                                            return Positioned(
                                              left: leftPosition,
                                              top: 0,
                                              bottom: 0,
                                              child: FractionalTranslation(
                                                translation: const Offset(
                                                  -0.5,
                                                  0.0,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: label,
                                                ),
                                              ),
                                            );
                                          }
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_selectedGroupIndex != null)
                      Builder(
                        builder: (BuildContext context) {
                          double yPosition = 0;
                          for (int i = 0; i < _selectedGroupIndex!; i++) {
                            final double visibleBars = _countVisibleBarsInGroup(
                              reversedData[i],
                            );
                            final double spacingInGroup =
                                (visibleBars - 1) * widget.barSpacing;
                            final double calculatedGroupHeight =
                                (visibleBars * widget.barHeight) +
                                spacingInGroup;
                            final double groupHeight = math.max(
                              calculatedGroupHeight,
                              minGroupHeight,
                            );
                            yPosition +=
                                groupHeight + (widget.groupSpacing * 2);
                          }

                          final double selectedVisibleBars =
                              _countVisibleBarsInGroup(
                                reversedData[_selectedGroupIndex!],
                              );
                          final double selectedSpacingInGroup =
                              (selectedVisibleBars - 1) * widget.barSpacing;
                          final double selectedCalculatedGroupHeight =
                              (selectedVisibleBars * widget.barHeight) +
                              selectedSpacingInGroup;
                          final double selectedGroupHeight = math.max(
                            selectedCalculatedGroupHeight,
                            minGroupHeight,
                          );

                          const double estimatedTooltipHeight = 150.0;
                          final double groupCenterY =
                              yPosition +
                              (selectedGroupHeight +
                                      (widget.groupSpacing * 2)) /
                                  2;
                          final double desiredTop =
                              groupCenterY - (estimatedTooltipHeight / 2);

                          double finalTop = math.max(0, desiredTop);
                          if (finalTop + estimatedTooltipHeight > chartHeight) {
                            finalTop = chartHeight - estimatedTooltipHeight;
                          }

                          return Positioned(
                            left: yAxisWidth,
                            right: 0,
                            top: finalTop,
                            child: Center(
                              child: ChipMonotoneNoise(
                                child: _buildTooltipContent(
                                  reversedData[_selectedGroupIndex!],
                                ),
                              ),
                            ),
                          );
                        },
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

/// Custom painter for drawing the horizontal bars and group separators.
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
    required this.minGroupHeight,
    this.selectedGroupIndex,
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
  final double minGroupHeight;
  final int? selectedGroupIndex;

  /// Returns the number of visible (non-zero) bars in a group.
  double _countVisibleBarsInGroup(BarHorizontalGroupData group) {
    return group.categories.values.where((double v) => v > 0).length.toDouble();
  }

  /// Draws a vertical dashed line (used for highlighting selected bars).
  void _drawDashedLine(Canvas canvas, Offset p1, Offset p2, Paint paint) {
    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    double startY = p1.dy;

    while (startY < p2.dy) {
      final double endY = startY + dashWidth;
      canvas.drawLine(
        Offset(p1.dx, startY),
        Offset(p1.dx, endY > p2.dy ? p2.dy : endY),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  /// Paints the bars, separators, and selection highlights.
  @override
  void paint(Canvas canvas, Size size) {
    final Paint separatorPaint = Paint()
      ..color = ColorFoundation.background.divider
      ..strokeWidth = groupSpacing
      ..strokeCap = StrokeCap.square;

    double currentY = 0;

    for (int groupIndex = 0; groupIndex < data.length; groupIndex++) {
      final BarHorizontalGroupData group = data[groupIndex];

      final double visibleBars = _countVisibleBarsInGroup(group);
      final double spacingInGroup = (visibleBars - 1) * barSpacing;
      final double calculatedGroupHeight =
          (visibleBars * barHeight) + spacingInGroup;
      final double groupHeight = math.max(
        calculatedGroupHeight,
        minGroupHeight,
      );

      final double lineY = currentY + (groupSpacing / 2);
      canvas.drawLine(
        Offset(0, lineY),
        Offset(size.width, lineY),
        separatorPaint,
      );
      currentY += groupSpacing;

      final double verticalOffset = (groupHeight - calculatedGroupHeight) / 2;
      double barY = currentY + verticalOffset;

      final bool isNE = group.range.contains('N/E');

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
            ..color = isNE ? ColorFoundation.text.grey4 : config.color
            ..style = PaintingStyle.fill;

          final RRect barRect = RRect.fromRectAndRadius(
            Rect.fromLTWH(0, barY, barWidth, barHeight),
            Radius.circular(barBorderRadius),
          );

          canvas.drawRRect(barRect, barPaint);

          if (groupIndex == selectedGroupIndex) {
            final Paint dashedPaint = Paint()
              ..color = isNE
                  ? ColorFoundation.text.grey4.withOpacity(0.5)
                  : config.color.withOpacity(0.5)
              ..strokeWidth = 1.5
              ..style = PaintingStyle.stroke;

            _drawDashedLine(
              canvas,
              Offset(barWidth, 0),
              Offset(barWidth, size.height),
              dashedPaint,
            );
          }

          barY += barHeight;

          bool hasMoreVisibleBars = false;
          for (int j = categoryIndex + 1; j < categoryConfigs.length; j++) {
            if ((group.categories[categoryConfigs[j].key] ?? 0) > 0) {
              hasMoreVisibleBars = true;
              break;
            }
          }
          if (hasMoreVisibleBars) {
            barY += barSpacing;
          }
        }
      }

      currentY += groupHeight;
      final double endLineY = currentY + (groupSpacing / 2);
      canvas.drawLine(
        Offset(0, endLineY),
        Offset(size.width, endLineY),
        separatorPaint,
      );
      currentY += groupSpacing;
    }
  }

  /// Determines when the painter should repaint (on animation or selection changes).
  @override
  bool shouldRepaint(_BarHorizontalPainter oldDelegate) {
    // IMPORTANT: Tell Flutter to repaint when animation or selection changes
    return oldDelegate.animation.value != animation.value ||
        oldDelegate.selectedGroupIndex != selectedGroupIndex;
  }
}
