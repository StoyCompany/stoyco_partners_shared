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
  });

  final double total;
  final List<BubbleData> data;
  final Widget? logo;
  final Duration animationDuration;
  final double? width;
  final double? height;

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
    // Ordenar data de forma descendente
    final List<BubbleData> sortedData = List<BubbleData>.from(widget.data)
      ..sort((BubbleData a, BubbleData b) => b.value.compareTo(a.value));

    if (sortedData.isEmpty) {
      _bubblePositions = <BubblePosition>[];
      return;
    }

    // Radio base mínimo
    const double baseRadius = 40.0;
    
    // Calcular radio del círculo central basado en cantidad de items
    // Cada item necesita espacio para su circunferencia
    const double radiusPerItem = 15.0;
    final double calculatedCenterRadius = baseRadius + (sortedData.length * radiusPerItem);

    // Encontrar el valor máximo de la lista
    final double maxValue = sortedData.first.value;
    final double minValue = sortedData.last.value;
    final double valueRange = maxValue - minValue;

    // Calcular posiciones concéntricas (todas desde el centro)
    _bubblePositions = <BubblePosition>[];
    
    // El espacio disponible dentro del círculo central (dejando margen para el logo)
    final double availableRadius = calculatedCenterRadius - baseRadius;

    for (int i = 0; i < sortedData.length; i++) {
      final BubbleData data = sortedData[i];
      
      // Calcular proporción basada en el valor
      final double proportion = valueRange > 0 
          ? (data.value - minValue) / valueRange 
          : 1.0;
      
      // Radio proporcional dentro del espacio disponible
      // El más grande estará cerca del borde, el más pequeño cerca del centro
      final double radius = baseRadius + (availableRadius * (1.0 - proportion * 0.85));

      _bubblePositions.add(
        BubblePosition(
          data: data,
          radius: radius,
          offset: Offset.zero,
          angle: 0,
        ),
      );
    }
  }

  double _calculateRadius(double value) {
    // Radio base mínimo
    const double baseRadius = 40.0;
    
    // Calcular radio basado en cantidad de items
    const double radiusPerItem = 15.0;
    return baseRadius + (widget.data.length * radiusPerItem);
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

            return Stack(
              children: <Widget>[
                // Canvas para las burbujas
                CustomPaint(
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                  painter: BubbleGraphPainter(
                    bubbles: _bubblePositions,
                    animation: _animation,
                    centerRadius: centerRadius,
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
