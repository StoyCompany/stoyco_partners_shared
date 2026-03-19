import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/revenue_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';

import 'package:stoyco_partners_shared/design/models/content_cards/subscription_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class SubscriptionsContentDescription extends StatelessWidget {
  const SubscriptionsContentDescription({
    required this.data,
    this.showDetail,
    super.key,
  });

  final SubscriptionContentModel data;
  final bool? showDetail;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: Gutter.separateChildren(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Gutter.separateChildren(
                children: <Widget>[
                  Text(
                    data.packageName,
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      fontSize: StoycoScreenSize.fontSize(context, 12),
                      color: ColorFoundation.text.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MessagedDescriptionTooltip(
                        message: 'Anual: ',
                        data: data.annualSubscribers,
                        tooltipMessage:
                            'Total de usuarios activos con un plan de suscripción anual.',
                      ),
                      RevenueStat(
                        value: data.annualPackageValue,
                        currency: data.currency,
                        tooltipMessage:
                            'Costo actual del plan de suscripción anual.',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MessagedDescriptionTooltip(
                        message: 'Mensual:',
                        data: data.monthlySubscribers,
                        tooltipMessage:
                            'Total de usuarios activos con un plan de suscripción mensual.',
                      ),
                      RevenueStat(
                        value: data.monthlyPackageValue,
                        currency: data.currency,
                        tooltipMessage:
                            'Costo actual del plan de suscripción mensual.',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomTooltip(
                          position: TooltipPosition.left,
                          message:
                              'Total de suscriptores activos (suma de planes anuales y mensuales).',
                          child: Container(
                            padding: StoycoScreenSize.symmetric(
                              context,
                              vertical: 2,
                              horizontal: 5,
                            ),
                            decoration: BoxDecoration(
                              color: ColorFoundation.background.saHighlights,
                              borderRadius: BorderRadius.circular(
                                StoycoScreenSize.radius(context, 100),
                              ),
                            ),
                            child: Text(
                              data.totalSubscribers.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                package: 'stoyco_partners_shared',
                                fontFamily: StoycoFontFamilyToken.apercu,
                                fontWeight: FontWeight.w500,
                                fontSize: StoycoScreenSize.fontSize(
                                  context,
                                  10,
                                ),
                                color: ColorFoundation.text.saDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gutter(StoycoScreenSize.width(context, 5)),
                      Expanded(
                        child: RevenueStat(
                          value: data.totalRevenue,
                          currency: data.currency,
                          tooltipMessage:
                              'Ingresos totales generados por tus suscripciones activas.',
                        ),
                      ),
                    ],
                  ),
                ],
                extent: StoycoScreenSize.height(context, 5),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Contenidos',
                  style: TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontSize: StoycoScreenSize.fontSize(context, 10),
                    decoration: TextDecoration.underline,
                    decorationColor: ColorFoundation.text.saLight,
                    fontWeight: FontWeight.bold,
                    color: ColorFoundation.text.saLight,
                  ),
                ),
                if (showDetail == false)
                  StoycoAssetsToken.lib.assets.icons.rightArrow.svg(
                    package: 'stoyco_partners_shared',
                    width: StoycoScreenSize.width(context, 10),
                    height: StoycoScreenSize.height(context, 10),
                    color: ColorFoundation.text.saLight,
                  )
                else
                  StoycoAssetsToken.lib.assets.icons.arrowDown.svg(
                    package: 'stoyco_partners_shared',
                    width: StoycoScreenSize.width(context, 10),
                    height: StoycoScreenSize.height(context, 5),
                    color: ColorFoundation.text.saLight,
                  ),
              ],
            ),
          ],
          extent: StoycoScreenSize.height(context, 5),
        ),
      ),
    );
  }
}
