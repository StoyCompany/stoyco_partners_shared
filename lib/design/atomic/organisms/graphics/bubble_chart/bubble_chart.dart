import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/bubble_tooltip.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/graphics/bubble_chart/bubble_chart_painter.dart';
import 'package:stoyco_partners_shared/design/models/bubble_data_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class BubbleChart extends StatefulWidget {
  const BubbleChart({
    super.key,
    required this.total,
    required this.data,
    this.logo,
    this.animationDuration = const Duration(milliseconds: 2000),
    this.width,
    this.height,
    this.minSpacing = 8.0,
    this.minCenterRadius = 80.0,
  });

  final double total;
  final List<BubbleData> data;
  final Widget? logo;
  final Duration animationDuration;
  final double? width;
  final double? height;
  final double minSpacing;
  final double minCenterRadius;

  @override
  State<BubbleChart> createState() => _BubbleChartState();
}

class _BubbleChartState extends State<BubbleChart>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _tooltipController;
  late Animation<double> _animation;
  late Animation<double> _tooltipAnimation;
  List<BubblePosition> _bubblePositions = <BubblePosition>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _tooltipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    _tooltipAnimation = CurvedAnimation(
      parent: _tooltipController,
      curve: Curves.easeOutCubic,
    );

    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _tooltipController.forward();
      }
    });

    _calculateBubblePositions();
    _controller.forward();
  }

  @override
  void didUpdateWidget(BubbleChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Compare length and total first for quick checks
    if (oldWidget.data.length != widget.data.length ||
        oldWidget.total != widget.total) {
      _calculateBubblePositions();
      _tooltipController.reset();
      _controller
        ..reset()
        ..forward();
      return;
    }

    // Deep comparison of bubble values and colors
    bool hasChanged = false;
    for (int i = 0; i < widget.data.length; i++) {
      if (oldWidget.data[i].value != widget.data[i].value ||
          oldWidget.data[i].color != widget.data[i].color) {
        hasChanged = true;
        break;
      }
    }

    if (hasChanged) {
      _calculateBubblePositions();
      _tooltipController.reset();
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _tooltipController.dispose();
    super.dispose();
  }

  void _calculateBubblePositions() {
    final List<BubbleData> sortedData = List<BubbleData>.from(widget.data)
      ..sort((BubbleData a, BubbleData b) => b.value.compareTo(a.value));

    if (sortedData.isEmpty) {
      _bubblePositions = <BubblePosition>[];
      return;
    }

    final double maxContainerRadius = (widget.width ?? 280) / 2;
    final double maxValue = sortedData.first.value;
    final double minValue = sortedData.last.value;
    final double valueRange = maxValue - minValue;

    final double proportion = maxValue / widget.total;
    final double centerRadius = proportion >= 0.95
        ? maxContainerRadius * 0.95
        : math.max(maxContainerRadius * proportion, widget.minCenterRadius);

    const double logoSafeZone = 0.3;
    final double startRadius = centerRadius * logoSafeZone;
    final double maxAllowedRadius = centerRadius * 0.95;
    final double availableRadius = maxAllowedRadius - startRadius;

    _bubblePositions = <BubblePosition>[];
    double previousRadius = startRadius;

    for (int i = sortedData.length - 1; i >= 0; i--) {
      final BubbleData data = sortedData[i];

      final double itemProportion = valueRange > 0
          ? (data.value - minValue) / valueRange
          : 1.0;

      final double calculatedRadius =
          startRadius + (availableRadius * itemProportion);
      final double radius = math.max(
        calculatedRadius,
        previousRadius + widget.minSpacing,
      );
      final double finalRadius = math.min(radius, maxAllowedRadius);

      _bubblePositions.add(
        BubblePosition(
          data: data,
          radius: finalRadius,
          offset: Offset.zero,
          angle: 0,
        ),
      );

      previousRadius = finalRadius;
    }
  }

  double _calculateRadius(double maxValue) {
    if (widget.data.isEmpty) {
      return widget.minCenterRadius;
    }

    final double maxContainerRadius = (widget.width ?? 280) / 2;
    final double sortedMaxValue = widget.data
        .map((BubbleData d) => d.value)
        .reduce((double a, double b) => a > b ? a : b);

    final double proportion = sortedMaxValue / widget.total;

    if (proportion >= 0.95) {
      return maxContainerRadius * 0.95;
    }

    final double calculatedRadius = maxContainerRadius * proportion;
    return math.max(calculatedRadius, widget.minCenterRadius);
  }

  @override
  Widget build(BuildContext context) {
    // Validar si la lista está vacía o si la suma de todos los valores es 0
    final bool isEmpty = widget.data.isEmpty;
    final double totalValue = widget.data.fold<double>(
      0,
      (double sum, BubbleData item) => sum + item.value,
    );

    if (isEmpty || totalValue == 0) {
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

    return SizedBox(
      width: widget.width ?? 280,
      height: widget.height ?? 280,
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double centerRadius = _calculateRadius(widget.total);

            final double maxValue = widget.data.isNotEmpty
                ? widget.data
                      .map((BubbleData d) => d.value)
                      .reduce((double a, double b) => a > b ? a : b)
                : 0.0;

            final Offset center = Offset(
              constraints.maxWidth / 2,
              constraints.maxHeight / 2,
            );

            return Stack(
              children: <Widget>[
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: BubbleChartPainter(
                    bubbles: _bubblePositions,
                    animation: _animation,
                    centerRadius: centerRadius,
                    total: widget.total,
                    maxValue: maxValue,
                  ),
                ),
                Positioned.fill(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (BuildContext context, Widget? child) {
                        final double logoSize = centerRadius * 0.6;
                        return Transform.scale(
                          scale: _animation.value,
                          child: Opacity(
                            opacity: _animation.value,
                            child: SizedBox(
                              width: logoSize,
                              height: logoSize,
                              child:
                                  widget.logo ??
                                  StoycoAssetsToken
                                      .lib
                                      .assets
                                      .icons
                                      .common
                                      .stoyco
                                      .svg(package: 'stoyco_partners_shared'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ..._bubblePositions.asMap().entries.map((
                  MapEntry<int, BubblePosition> entry,
                ) {
                  final int index = entry.key;
                  final BubblePosition bubble = entry.value;
                  const double angleRange = math.pi;
                  final double baseAngle = _bubblePositions.length > 1
                      ? -angleRange / 2 +
                            (angleRange / (_bubblePositions.length - 1)) * index
                      : 0;
                  final double angle = baseAngle;

                  return AnimatedBuilder(
                    animation: _tooltipAnimation,
                    builder: (BuildContext context, Widget? child) {
                      final double maxContainerRadius =
                          (widget.width ?? 280) / 2;
                      final double distanceFromCenter = bubble.radius;
                      final double remainingSpace =
                          maxContainerRadius - distanceFromCenter;
                      final double lineLength = remainingSpace > 66
                          ? 66
                          : remainingSpace * 0.7;

                      return Opacity(
                        opacity: _tooltipAnimation.value,
                        child: Transform.scale(
                          scale: 0.8 + (_tooltipAnimation.value * 0.2),
                          child: Transform.translate(
                            offset: Offset(
                              20 * (1 - _tooltipAnimation.value),
                              0,
                            ),
                            child: BubbleTooltip(
                              value: NumbersFormat.formatCompact(
                                bubble.data.value,
                              ),
                              lineStartOffset:
                                  center +
                                  Offset(
                                    bubble.radius * math.cos(angle),
                                    bubble.radius * math.sin(angle),
                                  ),
                              lineEndOffset:
                                  center +
                                  Offset(
                                    bubble.radius * math.cos(angle) +
                                        lineLength,
                                    bubble.radius * math.sin(angle),
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _tooltipAnimation,
                    builder: (BuildContext context, Widget? child) {
                      final double maxRadius =
                          math.min(
                            constraints.maxWidth,
                            constraints.maxHeight,
                          ) /
                          2;
                      const double angle = -math.pi / 2; // Hacia arriba
                      const double lineLength = 50.0;

                      return Opacity(
                        opacity: _tooltipAnimation.value,
                        child: Transform.scale(
                          scale: 0.8 + (_tooltipAnimation.value * 0.2),
                          child: Transform.translate(
                            offset: Offset(
                              0,
                              -20 * (1 - _tooltipAnimation.value),
                            ),
                            child: BubbleTooltip(
                              value: NumbersFormat.formatCompact(widget.total),
                              lineStartOffset:
                                  center +
                                  Offset(
                                    maxRadius * math.cos(angle),
                                    maxRadius * math.sin(angle),
                                  ),
                              lineEndOffset:
                                  center +
                                  Offset(
                                    maxRadius * math.cos(angle) + lineLength,
                                    maxRadius * math.sin(angle),
                                  ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
