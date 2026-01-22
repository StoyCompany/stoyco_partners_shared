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
              offset: Offset(0, -StoycoScreenSize.height(context, 15)),
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
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: StoycoScreenSize.symmetric(context, horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0x3DDDDDDD),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: Colors.transparent,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(2, 4),
                blurRadius: 8,
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFFFFF),
                Color(0x99FFFFFF),
                Color(0x00FFFFFF),
                Color(0x00FFFFFF),
                Color(0x99FFFFFF),
                Color(0xCCFFFFFF),
              ],
              stops: <double>[0.1236, 0.3202, 0.3889, 0.5176, 0.5823, 0.7789],
            ),
          ),
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
