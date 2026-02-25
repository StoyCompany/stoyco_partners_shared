import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_stats_legend/content_stats_legend.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/video_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class VideoContentDescription extends StatelessWidget {
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
            Expanded(
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
                      'Publicado ${DatesFormats.formatDateDDMMYYYYWithDashes(data.publishDate)}',
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
            SizedBox(
              width: StoycoScreenSize.width(context, 55),
              child: ContentStatsLegend(
                likes: data.likes,
                shares: data.shares,
                comments: data.comments,
                views: data.views,
                likesTooltip: 'Total de likes del video',
                sharesTooltip: 'Total de veces que se compartió el video',
                commentsTooltip: 'Total de comentarios del video',
                viewsTooltip: 'Total de visualizaciones del video',
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }
}
