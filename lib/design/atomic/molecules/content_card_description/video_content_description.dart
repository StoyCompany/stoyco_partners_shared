import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/templates/content_card_description.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/video_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class VideoContentDescription extends ContentCardDescription {
  const VideoContentDescription({super.key, required this.data});

  final VideoContentModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 115),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: StoycoScreenSize.width(context, 146),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    Text(
                      data.title,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.description,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Publicado ${data.publishDate}',
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 8),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  extent: StoycoScreenSize.height(context, 5),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Gutter.separateChildren(
                children: <Widget>[
                  _ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: StoycoAssetsToken.lib.assets.icons.like.svg(
                        package: 'stoyco_partners_shared',
                        width: StoycoScreenSize.width(context, 14),
                        height: StoycoScreenSize.height(context, 14),
                      ),
                      stat: data.likes.toString(),
                    ),
                    tooltipMessage: '${data.likes} Me gusta',
                  ),
                  _ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: StoycoAssetsToken.lib.assets.icons.share.svg(
                        package: 'stoyco_partners_shared',
                        width: StoycoScreenSize.width(context, 14),
                        height: StoycoScreenSize.height(context, 14),
                      ),
                      stat: data.shares.toString(),
                    ),
                    tooltipMessage: '${data.shares} Compartidos',
                  ),
                  _ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: StoycoAssetsToken.lib.assets.icons.message.svg(
                        package: 'stoyco_partners_shared',
                        width: StoycoScreenSize.width(context, 14),
                        height: StoycoScreenSize.height(context, 14),
                      ),
                      stat: data.comments.toString(),
                    ),
                    tooltipMessage: '${data.comments} Comentarios',
                  ),
                  _ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: ColorFoundation.text.saLight,
                        size: StoycoScreenSize.height(context, 14),
                      ),
                      stat: data.views.toString(),
                    ),
                    tooltipMessage: '${data.views} Vistas',
                  ),
                ],
                extent: StoycoScreenSize.height(context, 5),
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }
}

class _ContentStatWithTooltip extends StatefulWidget {
  const _ContentStatWithTooltip({
    required this.contentStat,
    required this.tooltipMessage,
  });

  final ContentStat contentStat;
  final String tooltipMessage;

  @override
  State<_ContentStatWithTooltip> createState() =>
      _ContentStatWithTooltipState();
}

class _ContentStatWithTooltipState extends State<_ContentStatWithTooltip> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  void _showTooltip() {
    if (_overlayEntry != null) return;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext overlayContext) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _removeTooltip,
        child: Material(
          color: Colors.black.withOpacity(0.5),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: offset.dx - StoycoScreenSize.width(context, 20),
                top: offset.dy - StoycoScreenSize.height(context, 50),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: StoycoScreenSize.width(context, 12),
                      vertical: StoycoScreenSize.height(context, 8),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA397BE),
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
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF14121D),
                      ),
                    ),
                  ),
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
