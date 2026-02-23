import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_stats_legend/content_stats_legend.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/announcements_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class AnnouncementsContentDescription extends StatelessWidget {
  const AnnouncementsContentDescription({super.key, required this.data});

  final AnnouncementsContentModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 115),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MessagedDescriptionTooltip(
                        message: 'Videos Aprobados:',
                        data: data.approvedVideos,
                        tooltipMessage: 'Total de videos aprobados en la convocatoria',
                      ),
                      MessagedDescriptionTooltip(
                        message: 'Participantes Unicos:',
                        data: data.participants,
                        tooltipMessage: 'Total de participantes únicos que participaron en la convocatoria',
                      ),
                      MessagedDescriptionTooltip(
                        message: 'Contenido x user:',
                        data: data.contentPerUser,
                        tooltipMessage: 'Promedio de videos subidos por cada participante',
                      ),
                      Gutter(StoycoScreenSize.height(context, 5)),
                      Text(
                        'Finalizado ${DatesFormats.formatDateDDMMYYYYWithDashes(data.closeDate)}',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 8),
                          color: ColorFoundation.text.saLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ),
            Flexible(
              child: ContentStatsLegend(
                likes: data.likes,
                shares: data.shares,
                comments: data.comments,
                views: data.views,
                likesTooltip: 'Total de likes de la convocatoria',
                sharesTooltip: 'Total de veces que se compartió la convocatoria',
                commentsTooltip: 'Total de comentarios de la convocatoria',
                viewsTooltip: 'Total de visualizaciones de la convocatoria',
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }
}
