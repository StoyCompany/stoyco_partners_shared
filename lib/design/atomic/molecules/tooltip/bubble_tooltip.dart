import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/chip_monotone_noise.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// {@template bubble_tooltip}
/// A glassmorphic bubble tooltip widget with a connecting line indicator.
///
/// This component is an **Atom** in the Atomic Design system, representing
/// a fundamental UI element that displays contextual information with a visual
/// connection to its target element.
///
/// The [BubbleTooltip] creates a sophisticated tooltip display consisting of:
///
/// * A white connecting line drawn from [lineStartOffset] to [lineEndOffset]
/// * A circular dot marker at the line's endpoint
/// * A glassmorphic box containing the text [value]
/// * Frosted glass effect using dual backdrop filters (6px + 0.2px blur)
/// * Monotone noise texture overlay for visual depth (0.5px dots at 32% density)
///
/// The tooltip box has a fixed size of 82x20 pixels (responsive) with rounded
/// corners (15px radius) and a semi-transparent white background (25% opacity).
/// {@endtemplate}
///
/// {@tool snippet}
/// This example shows how to create a [BubbleTooltip] with a connecting line.
///
/// ```dart
/// BubbleTooltip(
///   value: '125k',
///   lineStartOffset: Offset(100, 150),
///   lineEndOffset: Offset(200, 100),
/// )
/// ```
/// {@end-tool}
///
/// The widget uses a [Stack] to layer three positioned elements:
/// 1. The connecting line (rendered with [CustomPaint])
/// 2. The endpoint dot (8x8 circular container)
/// 3. The tooltip box (glassmorphic container with text)
///
/// The tooltip automatically calculates the line angle and length based on
/// the provided offsets, rotating the line painter accordingly.
///
/// See also:
///
///  * [Tooltip], Flutter's built-in tooltip widget.
///  * [CustomPaint], used for drawing the connecting line and noise texture.
///  * [BackdropFilter], used for the glassmorphic blur effects.
class BubbleTooltip extends StatelessWidget {
  /// {@macro bubble_tooltip}
  ///
  /// Creates a [BubbleTooltip] with the given parameters.
  ///
  /// The [value], [lineStartOffset], and [lineEndOffset] arguments must not be null.
  const BubbleTooltip({
    super.key,
    required this.value,
    required this.lineStartOffset,
    required this.lineEndOffset,
  });

  /// The text content displayed inside the tooltip box.
  ///
  /// This text is rendered in Gilroy Bold font at 12px, centered within
  /// the tooltip container with ellipsis overflow handling.
  final String value;

  /// The starting position of the connecting line.
  ///
  /// This [Offset] is relative to the parent container and represents
  /// the point where the line begins (typically attached to the target element).
  final Offset lineStartOffset;

  /// The ending position of the connecting line.
  ///
  /// This [Offset] is relative to the parent container and represents
  /// where the line terminates with a circular dot marker. The tooltip
  /// box is positioned adjacent to this point.
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
              child: ChipMonotoneNoise(
                message: value,
                messageStyle: TextStyle(
                  package: 'stoyco_partners_shared',
                  fontFamily: StoycoFontFamilyToken.apercu,
                  fontWeight: FontWeight.w700,
                  fontSize: StoycoScreenSize.fontSize(context, 12),
                  color: ColorFoundation.text.fandom,
                ),
              ),
            ),
          ),
        ],
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
