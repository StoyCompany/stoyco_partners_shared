import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/content_tooltip_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/projects_to_fund_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';
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
            Expanded(
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
                        MessagedDescriptionTooltip(
                          message: 'Votos:',
                          data: data.donation, 
                          tooltipMessage: 'Total de votantes del proyecto',
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
            SizedBox(
              width: StoycoScreenSize.width(context, 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    ContentTooltipStat(
                      stat: data.donation,
                      icon: StoycoAssetsToken.lib.assets.icons.eye,
                      tooltipMessage: 'Total de visualizaciones del proyecto',
                      position: TooltipPosition.left,
                    ),
                    ContentTooltipStat(
                      stat: data.likes,
                      icon: StoycoAssetsToken.lib.assets.icons.like,
                      tooltipMessage: 'Total de likes del proyecto',
                      position: TooltipPosition.left,
                    ),
                    ContentTooltipStat(
                      stat: data.shares,
                      icon: StoycoAssetsToken.lib.assets.icons.share,
                      tooltipMessage: 'Total de veces compartido',
                      position: TooltipPosition.left,
                    ),
                    ContentTooltipStat(
                      stat: data.stoycoCoins,
                      icon: StoycoAssetsToken.lib.assets.icons.stoycoCoins,
                      tooltipMessage: 'Total de Stoycoins recolectados',
                      position: TooltipPosition.left,
                    ),
                    ContentTooltipStat(
                      stat: data.comments,
                      icon: StoycoAssetsToken.lib.assets.icons.message,
                      tooltipMessage: 'Total de comentarios del proyecto',
                      position: TooltipPosition.left,
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
}
