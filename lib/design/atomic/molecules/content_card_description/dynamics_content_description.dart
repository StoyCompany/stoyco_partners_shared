import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_stats_legend/content_stats_legend.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/dynamics_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class DynamicsContentDescription extends StatelessWidget {
  const DynamicsContentDescription({
    required this.data,
    super.key,
  });

  final DynamicsContentModel data;

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
                            color: ColorFoundation.text.white,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gutter(StoycoScreenSize.height(context, 5)),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontSize: StoycoScreenSize.fontSize(context, 12),
                            color: ColorFoundation.text.fandom,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MessagedDescriptionTooltip(
                          message: 'Participantes:',
                          data: data.uniqueParticipants,
                          tooltipMessage: 'Total de participantes de la dinámica',
                        ),
                        Gutter(StoycoScreenSize.height(context, 5)),
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
                likesTooltip: 'Total de likes de la dinámica',
                sharesTooltip: 'Total de veces que se compartió la dinámica',
                commentsTooltip: 'Total de comentarios de la dinámica',
                viewsTooltip: 'Total de visualizaciones de la dinámica',
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }
}
