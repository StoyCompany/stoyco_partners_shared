import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class BubbleTooltip extends StatelessWidget {
  const BubbleTooltip({
    super.key,
    required this.value,
    required this.lineStartOffset,
    required this.lineEndOffset,
  });

  final String value;
  final Offset lineStartOffset;
  final Offset lineEndOffset;

  @override
  Widget build(BuildContext context) {
    final double lineLength = (lineEndOffset - lineStartOffset).distance;
    final double angle = (lineEndOffset - lineStartOffset).direction;

    return SizedBox(
      width: StoycoScreenSize.screenWidth(context),
      height: StoycoScreenSize.height(context, 200),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            left: lineStartOffset.dx,
            top: lineStartOffset.dy,
            child: Transform.rotate(
              angle: angle,
              alignment: Alignment.centerLeft,
              child: CustomPaint(
                size: Size(lineLength, 1),
                painter: _TooltipLinePainter(),
              ),
            ),
          ),
          Positioned(
            left: lineEndOffset.dx - StoycoScreenSize.width(context, 4),
            top: lineEndOffset.dy - StoycoScreenSize.height(context, 4),
            child: Container(
              width: StoycoScreenSize.width(context, 8),
              height: StoycoScreenSize.height(context, 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorFoundation.background.white,
              ),
            ),
          ),
          Positioned(
            left: lineEndOffset.dx + StoycoScreenSize.width(context, 8),
            top: lineEndOffset.dy,
            child: Transform.translate(
              offset: Offset(0, -StoycoScreenSize.height(context, 11)),
              child: _TooltipBox(value: value),
            ),
          ),
        ],
      ),
    );
  }
}

class _TooltipBox extends StatelessWidget {
  const _TooltipBox({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        StoycoScreenSize.radius(context, 15),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
          child: Container(
            width: StoycoScreenSize.width(context, 60),
            height: StoycoScreenSize.height(context, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                StoycoScreenSize.radius(context, 15),
              ),
              border: Border.all(
                width: 1,
                color: ColorFoundation.background.white,
              ),
              color: const Color(0x40FFFFFF), // Blanco con 25% de opacidad
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(
                    painter: _MonotoneNoisePainter(),
                  ),
                ),
                Center(
                  child: Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      fontWeight: FontWeight.w700,
                      fontSize: StoycoScreenSize.fontSize(context, 12),
                      color: ColorFoundation.text.fandom,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TooltipLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = ColorFoundation.background.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset.zero,
      Offset(size.width, 0),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MonotoneNoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint noisePaint = Paint()
      ..color = const Color(0x33FFFFFF) // Blanco con 20% de opacidad
      ..style = PaintingStyle.fill;

    const double pointSize = 0.5;
    const double density = 0.32;
    const int seed = 42; // Seed fijo para consistencia

    // Calcular cuántos puntos dibujar basado en densidad
    final double area = size.width * size.height;
    final int pointCount = (area * density).toInt();

    // Usar un generador pseudo-aleatorio con seed para consistencia
    int randomSeed = seed;
    int nextRandom() {
      randomSeed = (randomSeed * 1103515245 + 12345) & 0x7fffffff;
      return randomSeed;
    }

    for (int i = 0; i < pointCount; i++) {
      final double x = (nextRandom() % 10000) / 10000 * size.width;
      final double y = (nextRandom() % 10000) / 10000 * size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        pointSize / 2,
        noisePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
