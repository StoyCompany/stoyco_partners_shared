import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/chart_legend/chart_legend.dart';
import 'package:stoyco_partners_shared/design/models/chart_legend_item_model.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

/// Data model for a pie chart section.
class PieChartSectionData {
  const PieChartSectionData({
    required this.value,
    required this.color,
    this.label,
  });

  final double value;
  final Color color;
  final String? label;
}

class PieChartStoyco extends StatefulWidget {
  const PieChartStoyco({
    super.key,
    required this.sections,
    this.size = 300,
    this.strokeWidth = 50,
    this.gapDegrees = 4,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  final List<PieChartSectionData> sections;
  final double size;
  final double strokeWidth;
  final double gapDegrees;
  final Duration animationDuration;

  @override
  State<PieChartStoyco> createState() => _PieChartStoycoState();
}

class _PieChartStoycoState extends State<PieChartStoyco>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleController;
  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;
  int? _touchedIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    );
    
    _animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _scaleController.forward();
      }
    });
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details, Size size) {
    final Offset localPosition = details.localPosition;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double dx = localPosition.dx - center.dx;
    final double dy = localPosition.dy - center.dy;
    final double distance = math.sqrt(dx * dx + dy * dy);
    
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius - widget.strokeWidth;
    
    if (distance >= innerRadius && distance <= outerRadius) {
      double angle = math.atan2(dy, dx);
      angle = (angle + math.pi / 2) % (2 * math.pi);
      if (angle < 0) {
        angle += 2 * math.pi;
      }
      
      final double total = widget.sections.fold<double>(
        0,
        (double sum, PieChartSectionData section) => sum + section.value,
      );
      
      double currentAngle = 0;
      for (int i = 0; i < widget.sections.length; i++) {
        final double sweepAngle = (widget.sections[i].value / total) * 2 * math.pi;
        final double gapRadians = widget.gapDegrees * math.pi / 180;
        
        if (angle >= currentAngle && angle < currentAngle + sweepAngle - gapRadians) {
          setState(() => _touchedIndex = i);
          return;
        }
        currentAngle += sweepAngle;
      }
    }
    
    setState(() => _touchedIndex = null);
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartLegendItemModel> legendItems = widget.sections.map((PieChartSectionData section) {
      final double total = widget.sections.fold<double>(
        0,
        (double sum, PieChartSectionData s) => sum + s.value,
      );
      final double percentage = (section.value / total) * 100;
      return ChartLegendItemModel(
        color: section.color,
        label: section.label ?? '',
        value: '${percentage.toStringAsFixed(0)}%',
      );
    }).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ChartLegend(items: legendItems),
        Gap(StoycoScreenSize.height(context, 28)),
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: RepaintBoundary(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    final RenderBox box = context.findRenderObject()! as RenderBox;
                    _onTapDown(details, box.size);
                  },
                  child: AnimatedBuilder(
                    animation: Listenable.merge(<Listenable>[_animation, _scaleAnimation]),
                    builder: (BuildContext context, Widget? child) {
                      return Transform.scale(
                        scale: 0.8 + (_scaleAnimation.value * 0.2),
                        child: CustomPaint(
                          size: Size(constraints.maxWidth, constraints.maxHeight),
                          painter: _PieChartPainter(
                            sections: widget.sections,
                            strokeWidth: widget.strokeWidth,
                            gapDegrees: widget.gapDegrees,
                            animation: _animation,
                            touchedIndex: _touchedIndex,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _PieChartPainter extends CustomPainter {
  _PieChartPainter({
    required this.sections,
    required this.strokeWidth,
    required this.gapDegrees,
    required this.animation,
    this.touchedIndex,
  }) : super(repaint: animation);

  final List<PieChartSectionData> sections;
  final double strokeWidth;
  final double gapDegrees;
  final Animation<double> animation;
  final int? touchedIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final double total = sections.fold<double>(0, (double sum, PieChartSectionData s) => sum + s.value);
    
    // Calcular el gap uniforme para todos los espacios
    final double gapRadians = gapDegrees * math.pi / 180;
    final int numberOfGaps = sections.length;
    final double totalGapSpace = gapRadians * numberOfGaps;
    
    // El espacio disponible para las secciones es la circunferencia completa menos todos los gaps
    final double availableSpace = (2 * math.pi) - totalGapSpace;
    
    double startAngle = -math.pi / 2;
    double cumulativeProgress = 0;
    
    for (int i = 0; i < sections.length; i++) {
      final PieChartSectionData section = sections[i];
      final bool isTouched = i == touchedIndex;
      final double currentStrokeWidth = isTouched 
          ? strokeWidth + 10 
          : strokeWidth;
      
      // Calcular el ángulo de barrido basado en el espacio disponible (sin gaps)
      final double sectionProportion = section.value / total;
      final double fullSweepAngle = sectionProportion * availableSpace;
      
      // Calcular el progreso para esta sección específica
      final double sectionStart = cumulativeProgress;
      final double sectionEnd = sectionStart + sectionProportion;
      cumulativeProgress = sectionEnd;
      
      // Animación secuencial: cada sección comienza cuando termina la anterior
      double sectionProgress = 0;
      if (animation.value > sectionStart) {
        if (animation.value >= sectionEnd) {
          sectionProgress = 1.0;
        } else {
          sectionProgress = (animation.value - sectionStart) / sectionProportion;
        }
      }
      
      final double animatedSweepAngle = fullSweepAngle * sectionProgress;
      
      if (animatedSweepAngle > 0) {
        final Paint paint = Paint()
          ..color = section.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = currentStrokeWidth
          ..strokeCap = StrokeCap.round;
        
        final Rect rect = Rect.fromCircle(
          center: center,
          radius: radius - currentStrokeWidth / 2,
        );
        
        canvas.drawArc(
          rect,
          startAngle,
          animatedSweepAngle,
          false,
          paint,
        );
      }
      
      // Avanzar el ángulo: sección completa + gap uniforme
      startAngle += fullSweepAngle + gapRadians;
    }
  }

  @override
  bool shouldRepaint(_PieChartPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value || oldDelegate.touchedIndex != touchedIndex;
  }
}
