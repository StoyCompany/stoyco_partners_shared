import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ContentStatWithTooltip extends StatefulWidget {
  const ContentStatWithTooltip({
    super.key,
    required this.contentStat,
    required this.tooltipMessage,
  });

  final ContentStat contentStat;
  final String tooltipMessage;

  @override
  State<ContentStatWithTooltip> createState() => _ContentStatWithTooltipState();
}

class _ContentStatWithTooltipState extends State<ContentStatWithTooltip> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  void _showTooltip() {
    if (_overlayEntry != null) {
      return;
    }

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      return;
    }

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _removeTooltip,
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Stack(
            children: <Widget>[
              Positioned(
                right:
                    MediaQuery.of(context).size.width -
                    offset.dx +
                    StoycoScreenSize.width(context, 8),
                top:
                    offset.dy +
                    (size.height / 2) -
                    StoycoScreenSize.height(context, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _removeTooltip,
                      child: Container(
                        padding: EdgeInsets.all(
                          StoycoScreenSize.width(context, 4),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          size: StoycoScreenSize.width(context, 12),
                          color: ColorFoundation.text.saDark,
                        ),
                      ),
                    ),
                    Gutter(StoycoScreenSize.width(context, 8)),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: StoycoScreenSize.width(context, 12),
                          vertical: StoycoScreenSize.height(context, 8),
                        ),
                        decoration: BoxDecoration(
                          color: ColorFoundation.background.saLight,
                          borderRadius: BorderRadius.circular(
                            StoycoScreenSize.width(context, 8),
                          ),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: StoycoScreenSize.width(context, 150),
                        ),
                        child: Text(
                          widget.tooltipMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontSize: StoycoScreenSize.fontSize(context, 10),
                            fontWeight: FontWeight.w500,
                            color: ColorFoundation.text.saDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: _showTooltip, child: widget.contentStat);
  }
}
