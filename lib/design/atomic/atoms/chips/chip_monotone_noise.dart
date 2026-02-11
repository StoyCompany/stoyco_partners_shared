import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ChipMonotoneNoise extends StatelessWidget {
  const ChipMonotoneNoise({
    super.key,
    this.message = '',
    this.padding,
    this.child,
  });

  final Widget? child;
  final String message;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(StoycoScreenSize.radius(context, 15)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                StoycoScreenSize.radius(context, 15),
              ),
              border: Border.all(
                width: 1,
                color: ColorFoundation.background.white,
              ),
              color: const Color(0x40FFFFFF),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CustomPaint(painter: _MonotoneNoisePainter()),
                ),
                Padding(
                  padding:
                      padding ??
                      StoycoScreenSize.symmetric(
                        context,
                        horizontal: StoycoScreenSize.width(context, 12),
                        vertical: StoycoScreenSize.height(context, 4),
                      ),
                  child:
                      child ??
                      Text(
                        message,
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

class _MonotoneNoisePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint noisePaint = Paint()
      ..color = const Color(0x33FFFFFF)
      ..style = PaintingStyle.fill;

    const double pointSize = 0.5;
    const double density = 0.32;
    const int seed = 42;

    final double area = size.width * size.height;
    final int pointCount = (area * density).toInt();

    int randomSeed = seed;
    int nextRandom() {
      randomSeed = (randomSeed * 1103515245 + 12345) & 0x7fffffff;
      return randomSeed;
    }

    for (int i = 0; i < pointCount; i++) {
      final double x = (nextRandom() % 10000) / 10000 * size.width;
      final double y = (nextRandom() % 10000) / 10000 * size.height;

      canvas.drawCircle(Offset(x, y), pointSize / 2, noisePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
