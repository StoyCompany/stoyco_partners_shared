import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/organisms/bubble_graph/bubble_data.dart';

class BubbleGraphPainter extends CustomPainter {
  BubbleGraphPainter({
    required this.bubbles,
    required this.animation,
    required this.centerRadius,
  }) : super(repaint: animation);

  final List<BubblePosition> bubbles;
  final Animation<double> animation;
  final double centerRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Dibujar capa exterior con gradiente transparente
    _drawOuterGradientLayer(canvas, center, size);

    // Dibujar burbuja central con gradiente
    _drawCenterBubble(canvas, center);

    // Dibujar burbujas secundarias
    for (final BubblePosition bubble in bubbles) {
      _drawSecondaryBubble(canvas, center, bubble);
    }
  }

  void _drawOuterGradientLayer(Canvas canvas, Offset center, Size size) {
    final double maxRadius = math.min(size.width, size.height) / 2;
    final double animatedRadius = maxRadius * animation.value;

    // Gradiente exacto según especificación CSS
    final Paint gradientPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment.center,
        colors: <Color>[
          Color.fromRGBO(255, 255, 255, 0),     // 0%
          Color.fromRGBO(254, 253, 254, 0),     // 35%
          Color.fromRGBO(251, 250, 254, 0.04),  // 49%
          Color.fromRGBO(246, 243, 253, 0.09),  // 59%
          Color.fromRGBO(239, 234, 252, 0.16),  // 67%
          Color.fromRGBO(231, 222, 250, 0.26),  // 74%
          Color.fromRGBO(220, 207, 248, 0.37),  // 81%
          Color.fromRGBO(207, 189, 246, 0.51),  // 86%
          Color.fromRGBO(192, 168, 243, 0.68),  // 92%
          Color.fromRGBO(175, 145, 240, 0.85),  // 97%
          Color(0xFFA27FEE),                     // 100%
        ],
        stops: <double>[
          0.0,
          0.35,
          0.49,
          0.59,
          0.67,
          0.74,
          0.81,
          0.86,
          0.92,
          0.97,
          1.0,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: animatedRadius));

    canvas.drawCircle(center, animatedRadius, gradientPaint);
  }

  void _drawCenterBubble(Canvas canvas, Offset center) {
    final double animatedRadius = centerRadius * animation.value;

    // Capa base con gradiente principal de morado
    final Paint baseGradient = Paint()
      ..shader = const RadialGradient(
        center: Alignment.center,
        colors: <Color>[
          Color(0xFFA27FEE),
          Color(0xFF9F7DEB),
          Color(0xFF9876E4),
          Color(0xFF8E6EDB),
          Color(0xFF8467D2),
          Color(0xFF795BC5),
          Color(0xFF6C50B8),
          Color(0xFF5C43A7),
          Color(0xFF4D3796),
          Color(0xFF3E2B85),
          Color(0xFF331D7F),
        ],
        stops: <double>[0.0, 0.15, 0.28, 0.40, 0.52, 0.63, 0.73, 0.82, 0.89, 0.95, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: animatedRadius));

    canvas.drawCircle(center, animatedRadius, baseGradient);

    // Capa de iluminación central suave
    final Paint lightOverlay = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 0.6,
        colors: <Color>[
          Colors.white.withOpacity(0.25),
          Colors.white.withOpacity(0.12),
          Colors.white.withOpacity(0.05),
          Colors.transparent,
        ],
        stops: const <double>[0.0, 0.3, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: animatedRadius))
      ..blendMode = BlendMode.overlay;

    canvas.drawCircle(center, animatedRadius, lightOverlay);

    // Capa de profundidad en el borde
    final Paint edgeShadow = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        colors: <Color>[
          Colors.transparent,
          Colors.transparent,
          const Color(0xFF331D7F).withOpacity(0.4),
          const Color(0xFF1A0E40).withOpacity(0.6),
        ],
        stops: const <double>[0.0, 0.7, 0.9, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: animatedRadius))
      ..blendMode = BlendMode.multiply;

    canvas.drawCircle(center, animatedRadius, edgeShadow);
  }

  void _drawSecondaryBubble(
    Canvas canvas,
    Offset center,
    BubblePosition bubble,
  ) {
    final double animatedRadius = bubble.radius * animation.value;

    // Efecto de pulsación
    final double pulseScale = 1.0 + (math.sin(animation.value * math.pi * 4) * 0.02);
    final double pulseRadius = animatedRadius * pulseScale;

    // Borde dashed más delgado
    final Paint borderPaint = Paint()
      ..color = bubble.data.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    _drawDashedCircle(
      canvas,
      center, // Centrado, no con offset
      pulseRadius,
      borderPaint,
      dashWidth: 10,
      dashSpace: 8,
    );

    // Brillo animado más sutil
    final double glowOpacity = math.sin(animation.value * math.pi * 2) * 0.2 + 0.25;
    final Paint glowPaint = Paint()
      ..color = bubble.data.color.withOpacity(glowOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    canvas.drawCircle(center, pulseRadius, glowPaint);
  }

  void _drawDashedCircle(
    Canvas canvas,
    Offset center,
    double radius,
    Paint paint, {
    required double dashWidth,
    required double dashSpace,
  }) {
    final double circumference = 2 * math.pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final double totalDashSpace = dashWidth + dashSpace;
    final double adjustedDashAngle = (dashWidth / circumference) * 2 * math.pi;
    final double adjustedSpaceAngle = (dashSpace / circumference) * 2 * math.pi;

    final Path path = Path();
    double currentAngle = -math.pi / 2; // Comenzar desde arriba

    for (int i = 0; i < dashCount; i++) {
      final double x1 = center.dx + radius * math.cos(currentAngle);
      final double y1 = center.dy + radius * math.sin(currentAngle);
      final double x2 = center.dx + radius * math.cos(currentAngle + adjustedDashAngle);
      final double y2 = center.dy + radius * math.sin(currentAngle + adjustedDashAngle);

      path
        ..moveTo(x1, y1)
        ..arcToPoint(
          Offset(x2, y2),
          radius: Radius.circular(radius),
          clockwise: true,
        );

      currentAngle += adjustedDashAngle + adjustedSpaceAngle;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant BubbleGraphPainter oldDelegate) {
    return oldDelegate.animation.value != animation.value ||
        oldDelegate.bubbles.length != bubbles.length;
  }
}
