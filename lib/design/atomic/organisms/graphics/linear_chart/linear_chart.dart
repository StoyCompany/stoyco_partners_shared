import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/chip_monotone_noise.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/graphics/linear_chart/linear_chart_data.dart';
import 'package:stoyco_partners_shared/design/models/chart_legend_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class LinearChart extends StatefulWidget {
  const LinearChart({
    super.key,
    this.data,
    required this.lineConfigs,
    this.height,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  final LinearChartData? data;
  final List<LinearChartLineConfig> lineConfigs;
  final double? height;
  final Duration animationDuration;

  @override
  State<LinearChart> createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart>
    with SingleTickerProviderStateMixin {
  int? _touchedSpotIndex;
  String? _touchedLineKey;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<ChartLegendItemModel> get legendItems => widget.lineConfigs
      .map(
        (LinearChartLineConfig config) => ChartLegendItemModel(
          color: config.color,
          label: config.displayLabel,
        ),
      )
      .toList();

  List<LinearChartPoint> _getPointsForLine(String lineKey) {
    if (widget.data == null) {
      return <LinearChartPoint>[];
    }

    switch (lineKey) {
      case 'fan':
        return widget.data!.pointsFan;
      case 'member':
        return widget.data!.pointsMember;
      case 'superfan':
        return widget.data!.pointsSuperfan;
      case 'monetizedFan':
        return widget.data!.pointsMonetizedFan;
      default:
        return <LinearChartPoint>[];
    }
  }

  double _calculateMaxValue() {
    double maxValue = 0;
    for (final LinearChartLineConfig config in widget.lineConfigs) {
      final List<LinearChartPoint> points = _getPointsForLine(config.key);
      for (final LinearChartPoint point in points) {
        if (point.total > maxValue) {
          maxValue = point.total;
        }
      }
    }
    return maxValue;
  }

  Widget _buildTooltipContent(LinearChartPoint point) {
    final List<Widget> items = <Widget>[];

    items.add(
      Text(
        point.label,
        style: TextStyle(
          fontSize: StoycoScreenSize.width(context, 16),
          color: ColorFoundation.text.white,
          fontWeight: FontWeight.bold,
          fontFamily: StoycoFontFamilyToken.gilroy,
        ),
      ),
    );

    items.add(Gap(StoycoScreenSize.height(context, 8)));

    final Map<String, double> values = <String, double>{
      'Male': point.male,
      'Female': point.female,
      'Non-Binary': point.nonBinary,
      'Other': point.other,
      'No Data': point.noData,
    };

    values.forEach((String key, double value) {
      if (value > 0) {
        items.add(
          Text(
            '$key: ${NumbersFormat.formatWithCommas(value)}',
            style: TextStyle(
              fontSize: StoycoScreenSize.width(context, 14),
              color: ColorFoundation.text.white,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
          ),
        );
      }
    });

    items.add(Gap(StoycoScreenSize.height(context, 8)));

    items.add(
      Text(
        'Total: ${NumbersFormat.formatWithCommas(point.total)}',
        style: TextStyle(
          fontSize: StoycoScreenSize.width(context, 14),
          color: ColorFoundation.text.white,
          fontWeight: FontWeight.bold,
          fontFamily: StoycoFontFamilyToken.gilroy,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null || widget.data!.rangeX.isEmpty) {
      return SizedBox(
        height: StoycoScreenSize.height(context, 200),
        child: Center(
          child: Text(
            'Sin datos disponibles',
            style: TextStyle(
              fontSize: StoycoScreenSize.width(context, 16),
              color: ColorFoundation.text.fandom,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
          ),
        ),
      );
    }

    bool hasData = false;
    for (final LinearChartLineConfig config in widget.lineConfigs) {
      final List<LinearChartPoint> points = _getPointsForLine(config.key);
      if (points.isNotEmpty &&
          points.any((LinearChartPoint p) => p.total > 0)) {
        hasData = true;
        break;
      }
    }

    if (!hasData) {
      return SizedBox(
        height: StoycoScreenSize.height(context, 200),
        child: Center(
          child: Text(
            'Sin datos disponibles',
            style: TextStyle(
              fontSize: StoycoScreenSize.width(context, 16),
              color: ColorFoundation.text.fandom,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
          ),
        ),
      );
    }

    final double minY = widget.data!.rangeY.first;
    final double rangeMaxY = widget.data!.rangeY.last;
    final double dataMaxY = _calculateMaxValue();
    final double maxY = dataMaxY > rangeMaxY ? dataMaxY : rangeMaxY;

    return Column(
      children: <Widget>[
        SizedBox(
          height: widget.height ?? StoycoScreenSize.height(context, 300),
          child: SizedBox(
            width: StoycoScreenSize.screenWidth(context),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width:
                    widget.data!.rangeX.length *
                    StoycoScreenSize.width(context, 100),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: StoycoScreenSize.width(context, 16),
                    right: StoycoScreenSize.width(context, 32),
                    top: StoycoScreenSize.height(context, 20),
                    bottom: StoycoScreenSize.height(context, 10),
                  ),
                  child: Stack(
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (BuildContext context, Widget? child) {
                          return LineChart(
                            LineChartData(
                              minY: minY,
                              maxY: maxY,
                              minX: 0,
                              maxX: (widget.data!.rangeX.length - 1).toDouble(),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                checkToShowHorizontalLine: (double value) {
                                  return true;
                                },
                                horizontalInterval:
                                    widget.data!.rangeY.isNotEmpty &&
                                        widget.data!.rangeY.length > 1
                                    ? (maxY - minY) /
                                          (widget.data!.rangeY.length - 1)
                                    : (maxY - minY) / 4,
                                getDrawingHorizontalLine: (double value) {
                                  return FlLine(
                                    color: ColorFoundation.background.white,
                                    strokeWidth: 0.5,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    interval: 1,
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
                                          final int index = value.toInt();
                                          if (index >= 0 &&
                                              index <
                                                  widget.data!.rangeX.length) {
                                            String label =
                                                widget.data!.rangeX[index];
                                            if (label.isNotEmpty) {
                                              label =
                                                  label[0].toUpperCase() +
                                                  label.substring(1);
                                            }
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              child: Text(
                                                label,
                                                style: TextStyle(
                                                  fontSize:
                                                      StoycoScreenSize.width(
                                                        context,
                                                        15,
                                                      ),
                                                  color: ColorFoundation
                                                      .text
                                                      .white,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily:
                                                      StoycoFontFamilyToken
                                                          .gilroy,
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 50,
                                    interval: widget.data!.rangeY.length > 1
                                        ? (maxY - minY) /
                                              (widget.data!.rangeY.length - 1)
                                        : 1,
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                            child: Text(
                                              NumbersFormat.formatCompact(
                                                value,
                                              ),
                                              style: TextStyle(
                                                fontSize:
                                                    StoycoScreenSize.width(
                                                      context,
                                                      15,
                                                    ),
                                                color:
                                                    ColorFoundation.text.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    StoycoFontFamilyToken
                                                        .gilroy,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          );
                                        },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: widget.lineConfigs.map((
                                LinearChartLineConfig config,
                              ) {
                                final List<LinearChartPoint> points =
                                    _getPointsForLine(config.key);

                                if (points.isEmpty) {
                                  return LineChartBarData(spots: <FlSpot>[]);
                                }

                                final int pointsToShow =
                                    (_animation.value * points.length).ceil();

                                return LineChartBarData(
                                  show: true,
                                  spots: List<FlSpot>.generate(
                                    pointsToShow,
                                    (int index) => FlSpot(
                                      index.toDouble(),
                                      points[index].total,
                                    ),
                                  ),
                                  isCurved: true,
                                  curveSmoothness: 0.3,
                                  color: config.color,
                                  barWidth: config.strokeWidth,
                                  isStrokeCapRound: true,
                                  preventCurveOverShooting: true,
                                  dotData: FlDotData(
                                    show: true,
                                    getDotPainter:
                                        (
                                          FlSpot spot,
                                          double percent,
                                          LineChartBarData barData,
                                          int index,
                                        ) {
                                          final bool isTouched =
                                              _touchedLineKey == config.key &&
                                              _touchedSpotIndex == index;
                                          return FlDotCirclePainter(
                                            radius: isTouched
                                                ? config.dotSize * 1.8
                                                : config.dotSize,
                                            color: ColorFoundation
                                                .background
                                                .white,
                                            strokeWidth: 1,
                                            strokeColor: config.color,
                                          );
                                        },
                                  ),
                                  belowBarData: BarAreaData(show: false),
                                );
                              }).toList(),
                              lineTouchData: LineTouchData(
                                enabled: true,
                                touchSpotThreshold: 15,
                                getTouchedSpotIndicator:
                                    (
                                      LineChartBarData barData,
                                      List<int> spotIndexes,
                                    ) {
                                      return spotIndexes.map((int index) {
                                        return const TouchedSpotIndicatorData(
                                          FlLine(
                                            color: Color(0xFFA397BE),
                                            strokeWidth: 1,
                                            dashArray: <int>[2, 2],
                                          ),
                                          FlDotData(show: false),
                                        );
                                      }).toList();
                                    },
                                touchTooltipData: LineTouchTooltipData(
                                  getTooltipColor: (LineBarSpot spot) =>
                                      Colors.transparent,
                                  getTooltipItems:
                                      (List<LineBarSpot> touchedSpots) {
                                        return touchedSpots.map((
                                          LineBarSpot spot,
                                        ) {
                                          return const LineTooltipItem(
                                            '',
                                            TextStyle(),
                                          );
                                        }).toList();
                                      },
                                ),
                                touchCallback:
                                    (
                                      FlTouchEvent event,
                                      LineTouchResponse? touchResponse,
                                    ) {
                                      if (event is FlTapUpEvent &&
                                          touchResponse?.lineBarSpots != null) {
                                        final LineBarSpot spot =
                                            touchResponse!.lineBarSpots!.first;
                                        setState(() {
                                          if (_touchedSpotIndex ==
                                                  spot.spotIndex &&
                                              _touchedLineKey ==
                                                  widget
                                                      .lineConfigs[spot
                                                          .barIndex]
                                                      .key) {
                                            _touchedSpotIndex = null;
                                            _touchedLineKey = null;
                                          } else {
                                            _touchedSpotIndex = spot.spotIndex;
                                            _touchedLineKey = widget
                                                .lineConfigs[spot.barIndex]
                                                .key;
                                          }
                                        });
                                      }
                                    },
                              ),
                            ),
                          );
                        },
                      ),
                      if (_touchedSpotIndex != null && _touchedLineKey != null)
                        Builder(
                          builder: (BuildContext context) {
                            final List<LinearChartPoint> points =
                                _getPointsForLine(_touchedLineKey!);
                            if (_touchedSpotIndex! >= points.length) {
                              return const SizedBox();
                            }

                            final LinearChartPoint point =
                                points[_touchedSpotIndex!];

                            return Positioned.fill(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: StoycoScreenSize.height(context, 20),
                                  ),
                                  child: ChipMonotoneNoise(
                                    child: _buildTooltipContent(point),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
