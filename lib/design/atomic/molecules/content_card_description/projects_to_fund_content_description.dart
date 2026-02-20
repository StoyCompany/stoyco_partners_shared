import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
  import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/content_stat_tootip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/projects_to_fund_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ProjectsToFundContentDescription extends StatelessWidget {
  const ProjectsToFundContentDescription({required this.data, super.key});

  final ProjectsToFundContentModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 130),
      width: StoycoScreenSize.screenWidth(context),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: TextStyle(
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontSize: StoycoScreenSize.fontSize(context, 12),
                            color: ColorFoundation.text.saLight,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          data.description,
                          style: TextStyle(
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontSize: StoycoScreenSize.fontSize(context, 12),
                            color: ColorFoundation.text.saLight,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _messagedDescription(
                          context: context,
                          message: 'Votos:',
                          data: data.donation,
                        ),
                        Gutter(StoycoScreenSize.height(context, 10)),
                        Visibility(
                          visible: data.isActive,
                          replacement: Text(
                            'Finalizado ${DatesFormats.formatDateDDMMYYYYWithDashes(data.closeDate)}',
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontSize: StoycoScreenSize.fontSize(context, 8),
                              color: ColorFoundation.text.saLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          child: Text(
                            'Inicio ${DatesFormats.formatDateDDMMYYYYWithDashes(data.publishDate)}',
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontSize: StoycoScreenSize.fontSize(context, 8),
                              color: ColorFoundation.text.saLight,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    _tooltipContentStat(
                      context: context,
                      stat: data.donation,
                      icon: StoycoAssetsToken.lib.assets.icons.eye,
                      tooltipMessage: 'Total de visualizaciones del proyecto',
                    ),
                    _tooltipContentStat(
                      context: context,
                      stat: data.likes,
                      icon: StoycoAssetsToken.lib.assets.icons.like,
                      tooltipMessage: 'Total de likes del proyecto',
                    ),
                    _tooltipContentStat(
                      context: context,
                      stat: data.shares,
                      icon: StoycoAssetsToken.lib.assets.icons.share,
                      tooltipMessage: 'Total de veces compartido',
                    ),
                    _tooltipContentStat(
                      context: context,
                      stat: data.stoycoCoins,
                      icon: StoycoAssetsToken.lib.assets.icons.stoycoCoins,
                      tooltipMessage: 'Total de Stoycoins recolectados',
                    ),
                    _tooltipContentStat(
                      context: context,
                      stat: data.comments,
                      icon: StoycoAssetsToken.lib.assets.icons.message,
                      tooltipMessage: 'Total de comentarios del proyecto',
                    ),
                  ],
                  extent: StoycoScreenSize.height(context, 5),
                ),
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }

  Widget _messagedDescription({
    required BuildContext context, 
    required String message, 
    required int data,
  }) {
    return RichText(
      text: TextSpan(
        text: message,
        style: TextStyle(
          fontFamily: StoycoFontFamilyToken.gilroy,
          fontSize: StoycoScreenSize.fontSize(context, 12),
          fontWeight: FontWeight.w500,
          color: ColorFoundation.text.saHighlights,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: ' ${NumbersFormat.formatCompact(data.toDouble())}',
            style: TextStyle(
              fontFamily: StoycoFontFamilyToken.gilroy,
              fontSize: StoycoScreenSize.fontSize(context, 12),
              fontWeight: FontWeight.w400,
              color: ColorFoundation.text.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tooltipContentStat({
    required BuildContext context,
    required int stat,
    required SvgGenImage icon,
    required String tooltipMessage,
  }) {
    return ContentStatWithTooltip(
      contentStat: ContentStat(
        icon: icon.svg(
          package: 'stoyco_partners_shared',
          width: StoycoScreenSize.width(context, 14),
          height: StoycoScreenSize.height(context, 14),
        ),
        stat: NumbersFormat.formatCompact(stat.toDouble()),
      ),
      tooltipMessage: tooltipMessage,
    );
  }
}
