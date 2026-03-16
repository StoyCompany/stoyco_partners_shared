import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/revenue_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/messaged_description_tooltip.dart';

import 'package:stoyco_partners_shared/design/models/content_cards/subscription_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class SubscriptionsContentDescription extends StatelessWidget {
  const SubscriptionsContentDescription({required this.data, super.key});

  final SubscriptionContentModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
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
              children: <Widget>[
                MessagedDescriptionTooltip(
                  message: 'Anual:',
                  data: data.annualSubscribers,
                  tooltipMessage: '',
                ),
                RevenueStat(
                  value: data.annualPackageValue,
                  currency: data.currency,
                  tooltipMessage: '',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                MessagedDescriptionTooltip(
                  message: 'Mensual:',
                  data: data.monthlySubscribers,
                  tooltipMessage: '',
                ),
                RevenueStat(
                  value: data.monthlyPackageValue,
                  currency: data.currency,
                  tooltipMessage: '',
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomTooltip(
                    position: TooltipPosition.left,
                    message: '',
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
                        style: TextStyle(
                          package: 'stoyco_partners_shared',
                          fontFamily: StoycoFontFamilyToken.apercu,
                          fontWeight: FontWeight.w500,
                          fontSize: StoycoScreenSize.fontSize(context, 10),
                          color: ColorFoundation.text.saDark,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: RevenueStat(
                    value: data.totalRevenue,
                    currency: data.currency,
                    tooltipMessage: '',
                  ),
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
