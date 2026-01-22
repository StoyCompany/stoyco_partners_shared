import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/tooltip/bubble_tooltip.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/bubble_graph/bubble_data.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/bubble_graph/bubble_graph_painter.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
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
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _tooltipController;
  late Animation<double> _animation;
  late Animation<double> _tooltipAnimation;
  List<BubblePosition> _bubblePositions = <BubblePosition>[];
  BubblePosition? _selectedBubble;
  Offset? _graphCenter;

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
  void didUpdateWidget(BubbleGraph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data || oldWidget.total != widget.total) {
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
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    if (_controller.isAnimating) {
                      return;
                    }
                    
                    final RenderBox renderBox = context.findRenderObject()! as RenderBox;
                    final Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                    final Offset center = Offset(constraints.maxWidth / 2, constraints.maxHeight / 2);
                    
                    final BubbleGraphPainter painter = BubbleGraphPainter(
                      bubbles: _bubblePositions,
                      animation: _animation,
                      centerRadius: centerRadius,
                      total: widget.total,
                      maxValue: maxValue,
                    );
                    
                    final BubblePosition? bubble = painter.getBubbleAtPosition(localPosition, center);
                    
                    setState(() {
                      _selectedBubble = bubble;
                      _graphCenter = center;
                    });
                  },
                  child: CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: BubbleGraphPainter(
                      bubbles: _bubblePositions,
                      animation: _animation,
                      centerRadius: centerRadius,
                      total: widget.total,
                      maxValue: maxValue,
                    ),
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
                if (_selectedBubble != null && _graphCenter != null && _controller.isCompleted)
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _tooltipAnimation,
                      builder: (BuildContext context, Widget? child) {
                        final double maxContainerRadius = (widget.width ?? 280) / 2;
                        final double distanceFromCenter = _selectedBubble!.radius;
                        final double remainingSpace = maxContainerRadius - distanceFromCenter;
                        final double lineLength = remainingSpace > 66 ? 66 : remainingSpace * 0.7;
                        
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
                                value: NumbersFormat.formatCompact(_selectedBubble!.data.value),
                                lineStartOffset: _graphCenter! + Offset(
                                  _selectedBubble!.radius * math.cos(0),
                                  _selectedBubble!.radius * math.sin(0),
                                ),
                                lineEndOffset: _graphCenter! + Offset(
                                  _selectedBubble!.radius * math.cos(0) + lineLength,
                                  _selectedBubble!.radius * math.sin(0),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                Positioned(
                  top: 40,
                  left: 20,
                  right: 0,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _tooltipAnimation,
                      builder: (BuildContext context, Widget? child) {
                        return Opacity(
                          opacity: _tooltipAnimation.value,
                          child: Transform.scale(
                            scale: 0.8 + (_tooltipAnimation.value * 0.2),
                            child: Transform.translate(
                              offset: Offset(0, -20 * (1 - _tooltipAnimation.value)),
                              child: BubbleTooltip(
                                value: NumbersFormat.formatCompact(widget.total),
                                lineStartOffset: Offset(
                                  (widget.width ?? 280) / 2,
                                  0,
                                ),
                                lineEndOffset: Offset(
                                  (widget.width ?? 280) / 1.5,
                                  0,
                                ),
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
