import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

enum TooltipDirection {
  top,
  bottom,
  left,
  right,
}

class StoycoTooltip extends StatefulWidget {
  const StoycoTooltip({
    super.key,
    required this.message,
    required this.child,
    this.direction = TooltipDirection.top,
    this.backgroundColor = const Color(0xFFA397BE),
    this.textColor = const Color(0xFF14121D),
    this.maxWidth = 116.0,
    this.showArrow = true,
  });

  final String message;
  final Widget child;
  final TooltipDirection direction;
  final Color backgroundColor;
  final Color textColor;
  final double maxWidth;
  final bool showArrow;

  @override
  State<StoycoTooltip> createState() => _StoycoTooltipState();
}

class _StoycoTooltipState extends State<StoycoTooltip> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleTooltip(),
      child: widget.child,
    );
  }

  void _toggleTooltip() {
    if (_overlayEntry != null) {
      _removeTooltip();
    } else {
      _showTooltip();
    }
  }

  void _showTooltip() {
    if (_overlayEntry != null) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _removeTooltip,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: _calculateTop(offset, size),
              left: _calculateLeft(offset, size),
              child: GestureDetector(
                onTap: () {},
                child: Material(
                  color: Colors.transparent,
                  child: _TooltipContent(
                    message: widget.message,
                    direction: widget.direction,
                    backgroundColor: widget.backgroundColor,
                    textColor: widget.textColor,
                    maxWidth: widget.maxWidth,
                    showArrow: widget.showArrow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  double _calculateTop(Offset offset, Size size) {
    final double gap = StoycoScreenSize.height(context, 10);
    final double tooltipHeight = StoycoScreenSize.height(context, 43);
    
    switch (widget.direction) {
      case TooltipDirection.top:
        return offset.dy - tooltipHeight - gap;
      case TooltipDirection.bottom:
        return offset.dy + size.height + gap;
      case TooltipDirection.left:
      case TooltipDirection.right:
        return offset.dy + (size.height / 2) - (tooltipHeight / 2);
    }
  }

  double _calculateLeft(Offset offset, Size size) {
    final double gap = StoycoScreenSize.width(context, 10);
    
    switch (widget.direction) {
      case TooltipDirection.top:
      case TooltipDirection.bottom:
        return offset.dx + (size.width / 2) - (widget.maxWidth / 2);
      case TooltipDirection.left:
        return offset.dx - widget.maxWidth - gap;
      case TooltipDirection.right:
        return offset.dx + size.width + gap;
    }
  }
}

class _TooltipContent extends StatelessWidget {
  const _TooltipContent({
    required this.message,
    required this.direction,
    required this.backgroundColor,
    required this.textColor,
    required this.maxWidth,
    required this.showArrow,
  });

  final String message;
  final TooltipDirection direction;
  final Color backgroundColor;
  final Color textColor;
  final double maxWidth;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showArrow && direction == TooltipDirection.bottom)
          CustomPaint(
            size: Size(
              StoycoScreenSize.width(context, 10),
              StoycoScreenSize.height(context, 6),
            ),
            painter: _ArrowPainter(
              color: backgroundColor,
              direction: direction,
            ),
          ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (showArrow && direction == TooltipDirection.right)
              CustomPaint(
                size: Size(
                  StoycoScreenSize.width(context, 6),
                  StoycoScreenSize.height(context, 10),
                ),
                painter: _ArrowPainter(
                  color: backgroundColor,
                  direction: direction,
                ),
              ),
            Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              padding: EdgeInsets.all(StoycoScreenSize.width(context, 5)),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(
                  StoycoScreenSize.width(context, 5),
                ),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: StoycoFontFamilyToken.gilroy,
                  fontWeight: FontWeight.w400,
                  fontSize: StoycoScreenSize.fontSize(context, 10),
                  height: 1.1,
                  color: textColor,
                ),
              ),
            ),
            if (showArrow && direction == TooltipDirection.left)
              CustomPaint(
                size: Size(
                  StoycoScreenSize.width(context, 6),
                  StoycoScreenSize.height(context, 10),
                ),
                painter: _ArrowPainter(
                  color: backgroundColor,
                  direction: direction,
                ),
              ),
          ],
        ),
        if (showArrow && direction == TooltipDirection.top)
          CustomPaint(
            size: Size(
              StoycoScreenSize.width(context, 10),
              StoycoScreenSize.height(context, 6),
            ),
            painter: _ArrowPainter(
              color: backgroundColor,
              direction: direction,
            ),
          ),
      ],
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({
    required this.color,
    required this.direction,
  });

  final Color color;
  final TooltipDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();

    switch (direction) {
      case TooltipDirection.top:
        path
          ..moveTo(0, 0)
          ..lineTo(size.width / 2, size.height)
          ..lineTo(size.width, 0)
          ..close();
      case TooltipDirection.bottom:
        path
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..close();
      case TooltipDirection.left:
        path
          ..moveTo(0, size.height / 2)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..close();
      case TooltipDirection.right:
        path
          ..moveTo(size.width, size.height / 2)
          ..lineTo(0, 0)
          ..lineTo(0, size.height)
          ..close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
