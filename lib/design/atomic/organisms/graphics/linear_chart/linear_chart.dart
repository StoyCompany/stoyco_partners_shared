import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/chip_monotone_noise.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/graphics/linear_chart/linear_chart_data.dart';
import 'package:stoyco_partners_shared/design/models/chart_legend_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
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
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  // Tooltip state
  List<LineBarSpot> _touchedSpots = <LineBarSpot>[];

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
          maxValue = point.total.toDouble();
        }
      }
    }
    return maxValue;
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
              package: 'stoyco_partners_shared',
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
              package: 'stoyco_partners_shared',
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
                width: widget.data!.rangeX.length * StoycoScreenSize.width(context, 100),
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
                                                  package: 'stoyco_partners_shared',
                                                  fontSize: StoycoScreenSize.width(
                                                    context,
                                                    15,
                                                  ),
                                                  color: ColorFoundation.text.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: StoycoFontFamilyToken.gilroy,
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
                                                package: 'stoyco_partners_shared',
                                                fontSize: StoycoScreenSize.width(
                                                  context,
                                                  15,
                                                ),
                                                color: ColorFoundation.text.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: StoycoFontFamilyToken.apercu,
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
                                final List<LinearChartPoint> points = _getPointsForLine(config.key);

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
                                      points[index].total.toDouble(),
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
                                          return FlDotCirclePainter(
                                            radius: config.dotSize,
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
                                getTouchLineStart: (_, __) => -double.infinity,
                                getTouchLineEnd: (_, __) => double.infinity,
                                getTouchedSpotIndicator:
                                    (
                                      LineChartBarData barData,
                                      List<int> spotIndexes,
                                    ) {
                                      return spotIndexes.map((int index) {
                                        return TouchedSpotIndicatorData(
                                          FlLine(
                                            color: ColorFoundation.background.divider,
                                            strokeWidth: 1.5,
                                            dashArray: <int>[8, 4],
                                          ),
                                          const FlDotData(show: false),
                                        );
                                      }).toList();
                                    },
                                touchTooltipData: LineTouchTooltipData(
                                  // Deshabilitamos el tooltip nativo visual
                                  getTooltipColor: (_) => Colors.transparent,
                                  tooltipBorder: const BorderSide(color: Colors.transparent),
                                  tooltipPadding: EdgeInsets.zero,
                                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                                    // Devolver items vacíos pero con el mismo tamaño que touchedSpots
                                    return touchedSpots.map((_) => const LineTooltipItem('', TextStyle())).toList();
                                  },
                                ),
                                touchCallback:
                                    (
                                      FlTouchEvent event,
                                      LineTouchResponse? touchResponse,
                                    ) {
                                      setState(() {
                                        if (touchResponse?.lineBarSpots?.isNotEmpty ?? false) {
                                          _touchedSpots = touchResponse!.lineBarSpots!;
                                        } else {
                                          _touchedSpots = <LineBarSpot>[];
                                        }
                                      });
                                    },
                              ),
                            ),
                          );
                      },
                    ),
                    // Tooltip overlay personalizado
                    if (_touchedSpots.isNotEmpty)
                      _buildCustomTooltip(),
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
  
  Widget _buildCustomTooltip() {
    if (_touchedSpots.isEmpty || widget.data == null) {
      return const SizedBox.shrink();
    }
    
    // Usar el primer spot para calcular posición y obtener la fecha
    final LineBarSpot firstSpot = _touchedSpots.first;
    
    // Obtener todos los puntos para todas las líneas tocadas
    final List<_TooltipLineData> tooltipData = <_TooltipLineData>[];
    
    for (final LineBarSpot spot in _touchedSpots) {
      final List<LinearChartPoint> points = _getPointsForLine(
        widget.lineConfigs[spot.barIndex].key,
      );
      
      if (spot.spotIndex < points.length) {
        final LinearChartPoint point = points[spot.spotIndex];
        tooltipData.add(
          _TooltipLineData(
            point: point,
            color: widget.lineConfigs[spot.barIndex].color,
            label: widget.lineConfigs[spot.barIndex].displayLabel,
          ),
        );
      }
    }
    
    if (tooltipData.isEmpty) {
      return const SizedBox.shrink();
    }
    
    // Calcular posición del tooltip basado en las coordenadas del chart
    final double minY = widget.data!.rangeY.first;
    final double rangeMaxY = widget.data!.rangeY.last;
    final double dataMaxY = _calculateMaxValue();
    final double maxY = dataMaxY > rangeMaxY ? dataMaxY : rangeMaxY;
    
    // Dimensiones reales del área de dibujo del chart
    final double chartWidth = widget.data!.rangeX.length * StoycoScreenSize.width(context, 100);
    final double containerHeight = widget.height ?? StoycoScreenSize.height(context, 300);
    
    // Los paddings se aplican FUERA del Stack, así que el Stack empieza en (0,0)
    // Las dimensiones internas del LineChart consideran los títulos y márgenes
    final double reservedSizeLeft = 50; // Espacio para títulos del eje Y
    final double reservedSizeBottom = 40; // Espacio para títulos del eje X
    final double chartDrawingHeight = containerHeight - reservedSizeBottom;
    final double chartDrawingWidth = chartWidth - reservedSizeLeft;
    
    // Convertir coordenadas del chart a posición en pantalla
    final double spotX = firstSpot.spotIndex.toDouble();
    final double spotY = firstSpot.y;
    
    // Calcular dimensiones dinámicas del tooltip según cantidad de líneas
    final double tooltipWidth = StoycoScreenSize.width(context, 160);
    final double baseHeight = StoycoScreenSize.height(context, 40);
    final double lineHeight = StoycoScreenSize.height(context, 24);
    final double tooltipHeight = baseHeight + (tooltipData.length * lineHeight);
    
    // Calcular posición X del punto (proporción en el área de dibujo)
    final double maxX = (widget.data!.rangeX.length - 1).toDouble();
    final double xRatio = maxX > 0 ? spotX / maxX : 0;
    double pointX = reservedSizeLeft + (chartDrawingWidth * xRatio);
    
    // Calcular posición Y (invertida porque el canvas crece hacia abajo)
    final double yRange = maxY - minY;
    final double yRatio = yRange > 0 ? (spotY - minY) / yRange : 0;
    double pointY = chartDrawingHeight * (1 - yRatio);
    
    // POSICIONAMIENTO DEL TOOLTIP
    // Centrado horizontalmente sobre el punto
    double left = pointX - (tooltipWidth / 2);
    // Por encima del punto
    double top = pointY - tooltipHeight - StoycoScreenSize.height(context, 10);
    
    // Ajustar horizontalmente para que no se salga del contenedor scrollable
    final double minLeft = StoycoScreenSize.width(context, 4);
    final double maxLeftBound = chartWidth - tooltipWidth - StoycoScreenSize.width(context, 4);
    
    if (left < minLeft) {
      left = minLeft;
    }
    if (left > maxLeftBound) {
      left = maxLeftBound;
    }
    
    // Ajustar verticalmente
    if (top < StoycoScreenSize.height(context, 4)) {
      // Si se sale por arriba, mostrar debajo del punto
      top = pointY + StoycoScreenSize.height(context, 10);
    }
    
    // Si aún se sale por abajo
    if (top + tooltipHeight > containerHeight - StoycoScreenSize.height(context, 4)) {
      top = containerHeight - tooltipHeight - StoycoScreenSize.height(context, 4);
    }
    
    return Positioned(
      left: left,
      top: top,
      child: IgnorePointer(
        child: ChipMonotoneNoise(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Fecha
              Text(
                DatesFormats.formatDateDDMMYYYY(tooltipData.first.point.date),
                style: TextStyle(
                  package: 'stoyco_partners_shared',
                  fontSize: StoycoScreenSize.width(context, 13),
                  color: ColorFoundation.text.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: StoycoFontFamilyToken.apercu,
                ),
              ),
              Gap(StoycoScreenSize.height(context, 8)),
              // Valores de todas las líneas tocadas
              ...tooltipData.map((data) => Padding(
                padding: EdgeInsets.only(
                  bottom: StoycoScreenSize.height(context, 4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Círculo de color
                    Container(
                      width: StoycoScreenSize.width(context, 8),
                      height: StoycoScreenSize.width(context, 8),
                      decoration: BoxDecoration(
                        color: data.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Gap(StoycoScreenSize.width(context, 6)),
                    // Flecha de tendencia
                    if (data.point.trend != TrendType.neutral) ...<Widget>[
                      Transform.rotate(
                        angle: data.point.trend == TrendType.down ? 3.14159 : 0,
                        child: StoycoAssetsToken.lib.assets.icons.arrowUp.svg(
                          width: StoycoScreenSize.width(context, 10),
                          height: StoycoScreenSize.width(context, 10),
                          package: 'stoyco_partners_shared',
                        ),
                      ),
                      Gap(StoycoScreenSize.width(context, 4)),
                    ],
                    // Número
                    Text(
                      NumbersFormat.formatWithCommas(data.point.total.toDouble()),
                      style: TextStyle(
                        package: 'stoyco_partners_shared',
                        fontSize: StoycoScreenSize.width(context, 14),
                        color: ColorFoundation.text.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: StoycoFontFamilyToken.apercu,
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// Clase auxiliar para manejar los datos del tooltip
class _TooltipLineData {
  const _TooltipLineData({
    required this.point,
    required this.color,
    required this.label,
  });
  
  final LinearChartPoint point;
  final Color color;
  final String label;
}
