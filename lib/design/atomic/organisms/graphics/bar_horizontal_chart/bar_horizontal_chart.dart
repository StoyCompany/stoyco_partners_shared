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
    // Validar que maxValue no sea NaN ni infinito
    if (maxValue.isNaN || maxValue.isInfinite) {
      maxValue = 0;
    }
    return maxValue;
  }

  List<double> _calculateXAxisScale(double maxValue) {
    if (maxValue == 0 || maxValue.isNaN || maxValue.isInfinite) {
      return <double>[0, 0, 0, 0, 0];
    }

    // Redondear hacia arriba a un número "bonito"
    final double magnitude = math.pow(10, (math.log(maxValue) / math.ln10).floor()).toDouble();
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

    // Generar máximo 5 valores equidistantes
    final double step = niceMax / 5;
    return List<double>.generate(5, (int index) => step * index);
  }

  bool _hasDataInRange(List<double> xAxisScale) {
    if (xAxisScale.isEmpty || xAxisScale.first == 0) {
      return true; // Si comienza en 0, siempre hay datos
    }

    final double minRange = xAxisScale.first;
    
    // Verificar si algún grupo tiene al menos un valor mayor al rango mínimo
    for (final BarHorizontalGroupData group in widget.data) {
      for (final double value in group.categories.values) {
        if (value >= minRange) {
          return true;
        }
      }
    }
    
    return false;
  }

  double _countVisibleBarsInGroup(BarHorizontalGroupData group) {
    return group.categories.values.where((double v) => v > 0).length.toDouble();
  }

  double _calculateGroupTotal(BarHorizontalGroupData group) {
    return group.categories.values.fold(0.0, (double sum, double value) => sum + value);
  }

  Widget _buildTooltipContent(BarHorizontalGroupData group) {
    final double total = _calculateGroupTotal(group);
    final List<Widget> items = <Widget>[];

    // Nombre del rango
    items.add(
      Text(
        group.range,
        style: TextStyle(
          fontSize: StoycoScreenSize.width(context, 16),
          color: ColorFoundation.text.white,
          fontWeight: FontWeight.bold,
          fontFamily: StoycoFontFamilyToken.gilroy,
        ),
      ),
    );

    items.add(Gap(StoycoScreenSize.height(context, 4)));

    // Valores por categoría
    for (final BarHorizontalCategoryConfig config in widget.categoryConfigs) {
      final double value = group.categories[config.key] ?? 0;
      if (value > 0) {
        items.add(
          Text(
            '${config.displayLabel}: ${NumbersFormat.formatWithCommas(value)}',
            style: TextStyle(
              fontSize: StoycoScreenSize.width(context, 14),
              color: ColorFoundation.text.white,
              fontWeight: FontWeight.w400,
              fontFamily: StoycoFontFamilyToken.gilroy,
            ),
          ),
        );
      }
    }

    items.add(Gap(StoycoScreenSize.height(context, 4)));

    // Total
    items.add(
      Text(
        'Total: ${NumbersFormat.formatWithCommas(total)}',
        style: TextStyle(
          fontSize: StoycoScreenSize.width(context, 14),
          color: ColorFoundation.text.white,
          fontWeight: FontWeight.bold,
          fontFamily: StoycoFontFamilyToken.gilroy,
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
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

    final double maxValue = _calculateMaxValue();
    final List<double> xAxisScale = widget.xAxisValues ?? _calculateXAxisScale(maxValue);
    
    // Validar que los xAxisValues tengan máximo 5 elementos
    final List<double> validatedXAxisScale = xAxisScale.length > 5 
        ? xAxisScale.sublist(0, 5) 
        : xAxisScale;
    
    // Verificar si hay datos en el rango proporcionado
    if (!_hasDataInRange(validatedXAxisScale)) {
      return SizedBox(
        height: StoycoScreenSize.height(context, 200),
        child: Center(
          child: Text(
            'Datos no encontrados en el rango suministrado',
            style: TextStyle(
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

    // Invertir el orden de los datos para que el primer elemento esté abajo
    final List<BarHorizontalGroupData> reversedData = widget.data.reversed.toList();

    // Altura mínima por grupo para evitar que se corte el texto
    const double minGroupHeight = 60.0;

    double totalHeight = 0;
    for (final BarHorizontalGroupData group in reversedData) {
      final double visibleBars = _countVisibleBarsInGroup(group);
      final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
      final double calculatedGroupHeight = (visibleBars * widget.barHeight) + spacingInGroup;
      final double groupHeight = math.max(calculatedGroupHeight, minGroupHeight);
      totalHeight += groupHeight + (widget.groupSpacing * 2);
    }
    final double calculatedHeight = totalHeight + 60;

    return Column(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ChartLegend(items: legendItems),
        ),
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

                return Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                          SizedBox(
                            width: yAxisWidth,
                            child: Column(
                              children: reversedData.asMap().entries.map((
                                MapEntry<int, BarHorizontalGroupData> entry,
                              ) {
                                final BarHorizontalGroupData group = entry.value;
                                final double visibleBars = _countVisibleBarsInGroup(group);
                                final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
                                final double calculatedGroupHeight = (visibleBars * widget.barHeight) + spacingInGroup;
                                final double groupHeight = math.max(calculatedGroupHeight, minGroupHeight);

                                return SizedBox(
                                  height: groupHeight + (widget.groupSpacing * 2),
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
                                          color: ColorFoundation.background.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: StoycoFontFamilyToken.gilroy,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          // Bars area con GestureDetector
                          Expanded(
                            child: Stack(
                              children: <Widget>[
                                // Barras animadas
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (BuildContext context, Widget? child) {
                                    return CustomPaint(
                                      size: Size(chartWidth, chartHeight),
                                      painter: _BarHorizontalPainter(
                                        data: reversedData,
                                        categoryConfigs: widget.categoryConfigs,
                                        maxValue: chartMaxValue,
                                        barHeight: widget.barHeight,
                                        barSpacing: widget.barSpacing,
                                        groupSpacing: widget.groupSpacing,
                                        barBorderRadius: widget.barBorderRadius,
                                        animation: _animation,
                                        xAxisScale: xAxisScale,
                                        minGroupHeight: minGroupHeight,
                                      ),
                                    );
                                  },
                                ),
                                // GestureDetectors para cada grupo
                                ...reversedData.asMap().entries.map((
                                  MapEntry<int, BarHorizontalGroupData> entry,
                                ) {
                                  final int index = entry.key;
                                  final BarHorizontalGroupData group = entry.value;
                                  
                                  // Calcular la posici\u00f3n Y del grupo
                                  double yPosition = 0;
                                  for (int i = 0; i < index; i++) {
                                    final double visibleBars = _countVisibleBarsInGroup(reversedData[i]);
                                    final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
                                    final double calculatedGroupHeight = (visibleBars * widget.barHeight) + spacingInGroup;
                                    final double groupHeight = math.max(calculatedGroupHeight, minGroupHeight);
                                    yPosition += groupHeight + (widget.groupSpacing * 2);
                                  }
                                  
                                  final double visibleBars = _countVisibleBarsInGroup(group);
                                  final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
                                  final double calculatedGroupHeight = (visibleBars * widget.barHeight) + spacingInGroup;
                                  final double groupHeight = math.max(calculatedGroupHeight, minGroupHeight);

                                  return Positioned(
                                    left: 0,
                                    top: yPosition,
                                    width: chartWidth,
                                    height: groupHeight + (widget.groupSpacing * 2),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedGroupIndex = _selectedGroupIndex == index ? null : index;
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
                                  left: position.isNaN || position.isInfinite
                                      ? 0
                                      : position * (constraints.maxWidth - yAxisWidth),
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
                ),
                // Tooltip encima de todo
                if (_selectedGroupIndex != null)
                  Builder(
                    builder: (BuildContext context) {
                      // Calcular la posición Y del grupo seleccionado
                      double yPosition = 0;
                      for (int i = 0; i < _selectedGroupIndex!; i++) {
                        final double visibleBars = _countVisibleBarsInGroup(reversedData[i]);
                        final double spacingInGroup = (visibleBars - 1) * widget.barSpacing;
                        final double calculatedGroupHeight = (visibleBars * widget.barHeight) + spacingInGroup;
                        final double groupHeight = math.max(calculatedGroupHeight, minGroupHeight);
                        yPosition += groupHeight + (widget.groupSpacing * 2);
                      }
                      
                      // Obtener altura del grupo seleccionado
                      final double selectedVisibleBars = _countVisibleBarsInGroup(reversedData[_selectedGroupIndex!]);
                      final double selectedSpacingInGroup = (selectedVisibleBars - 1) * widget.barSpacing;
                      final double selectedCalculatedGroupHeight = (selectedVisibleBars * widget.barHeight) + selectedSpacingInGroup;
                      final double selectedGroupHeight = math.max(selectedCalculatedGroupHeight, minGroupHeight);
                      
                      // Altura estimada del tooltip (ajustar según contenido)
                      const double estimatedTooltipHeight = 150.0;
                      
                      // Calcular el centro del grupo seleccionado
                      final double groupCenterY = yPosition + (selectedGroupHeight + (widget.groupSpacing * 2)) / 2;
                      
                      // Centrar el tooltip en el grupo
                      double desiredTop = groupCenterY - (estimatedTooltipHeight / 2);
                      
                      // Asegurar que el tooltip no se salga por arriba
                      double finalTop = math.max(0, desiredTop);
                      
                      // Si se sale por abajo, ajustar
                      if (finalTop + estimatedTooltipHeight > chartHeight) {
                        finalTop = chartHeight - estimatedTooltipHeight;
                      }
                      
                      return Positioned(
                        left: yAxisWidth,
                        right: 0,
                        top: finalTop,
                        child: Center(
                          child: ChipMonotoneNoise(
                            child: _buildTooltipContent(reversedData[_selectedGroupIndex!]),
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

  double _countVisibleBarsInGroup(BarHorizontalGroupData group) {
    return group.categories.values.where((double v) => v > 0).length.toDouble();
  }

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
      
      // Calcular altura del grupo
      final double visibleBars = _countVisibleBarsInGroup(group);
      final double spacingInGroup = (visibleBars - 1) * barSpacing;
      final double calculatedGroupHeight = (visibleBars * barHeight) + spacingInGroup;
      final double groupHeight = math.max(calculatedGroupHeight, minGroupHeight);

      // Línea divisora al inicio del grupo
      final double lineY = currentY + (groupSpacing / 2);
      canvas.drawLine(
        Offset(0, lineY),
        Offset(size.width, lineY),
        separatorPaint,
      );
      currentY += groupSpacing;
      
      // Centrar las barras verticalmente dentro del grupo si el grupo es más alto que las barras
      final double verticalOffset = (groupHeight - calculatedGroupHeight) / 2;
      double barY = currentY + verticalOffset;

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
            Rect.fromLTWH(0, barY, barWidth, barHeight),
            Radius.circular(barBorderRadius),
          );

          canvas.drawRRect(barRect, barPaint);

          barY += barHeight;

          // Agregar espaciado entre barras del mismo grupo (solo si no es la última barra visible)
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
      
      // Avanzar al siguiente grupo
      currentY += groupHeight;

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
