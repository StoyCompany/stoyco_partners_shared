import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/bubble_graph/bubble_data.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/bubble_graph/bubble_graph_painter.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

class BubbleGraph extends StatefulWidget {
  const BubbleGraph({
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
  State<BubbleGraph> createState() => _BubbleGraphState();
}

class _BubbleGraphState extends State<BubbleGraph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<BubblePosition> _bubblePositions = <BubblePosition>[];

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

    _calculateBubblePositions();
    _controller.forward();
  }

  @override
  void didUpdateWidget(BubbleGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data || oldWidget.total != widget.total) {
      _calculateBubblePositions();
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
      
      final double calculatedRadius = startRadius + (availableRadius * itemProportion);
      final double radius = math.max(calculatedRadius, previousRadius + widget.minSpacing);
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
    return SizedBox(
      width: widget.width ?? 280,
      height: widget.height ?? 280,
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double centerRadius = _calculateRadius(widget.total);

            final double maxValue = widget.data.isNotEmpty
                ? widget.data.map((BubbleData d) => d.value).reduce((double a, double b) => a > b ? a : b)
                : 0.0;

            return Stack(
              children: <Widget>[
                // Canvas para las burbujas
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: BubbleGraphPainter(
                    bubbles: _bubblePositions,
                    animation: _animation,
                    centerRadius: centerRadius,
                    total: widget.total,
                    maxValue: maxValue,
                  ),
                ),
                // Logo en el centro
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
                              child: widget.logo ??
                                  StoycoAssetsToken.lib.assets.icons.common.stoyco.svg(
                                    package: 'stoyco_partners_shared',
                                  ),
                            ),
                          ),
                        );
                      },
                    ),
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
