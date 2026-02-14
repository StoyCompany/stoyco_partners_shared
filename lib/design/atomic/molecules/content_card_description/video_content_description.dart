import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/content_stat_tootip.dart';
import 'package:stoyco_partners_shared/design/atomic/templates/content_card_description.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/video_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            SizedBox(
              width: StoycoScreenSize.width(context, 150),
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
                  ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: StoycoAssetsToken.lib.assets.icons.like.svg(
                        package: 'stoyco_partners_shared',
                        width: StoycoScreenSize.width(context, 14),
                        height: StoycoScreenSize.height(context, 14),
                      ),
                      stat: NumbersFormat.formatCompact(data.likes.toDouble()),
                    ),
                    tooltipMessage: 'Total de likes del video',
                  ),
                  ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: StoycoAssetsToken.lib.assets.icons.share.svg(
                        package: 'stoyco_partners_shared',
                        width: StoycoScreenSize.width(context, 14),
                        height: StoycoScreenSize.height(context, 14),
                      ),
                      stat: NumbersFormat.formatCompact(data.shares.toDouble()),
                    ),
                    tooltipMessage: 'Total de veces que se compartió el video',
                  ),
                  ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: StoycoAssetsToken.lib.assets.icons.message.svg(
                        package: 'stoyco_partners_shared',
                        width: StoycoScreenSize.width(context, 14),
                        height: StoycoScreenSize.height(context, 14),
                      ),
                      stat: NumbersFormat.formatCompact(
                        data.comments.toDouble(),
                      ),
                    ),
                    tooltipMessage: 'Total de comentarios del video',
                  ),
                  ContentStatWithTooltip(
                    contentStat: ContentStat(
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: ColorFoundation.text.saLight,
                        size: StoycoScreenSize.height(context, 14),
                      ),
                      stat: NumbersFormat.formatCompact(data.views.toDouble()),
                    ),
                    tooltipMessage: 'Total de visualizaciones del video',
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
