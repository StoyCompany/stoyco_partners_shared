import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/revenue_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ExperienceContentStat extends StatelessWidget {
  const ExperienceContentStat({
    super.key,
    required this.statLabel,
    required this.statValue,
    required this.statRevenue,
    required this.statCurrency,
    required this.labelTooltipMessage,
    required this.revenueTooltipMessage,
  });

  final String statLabel;
  final int statValue;
  final double statRevenue;
  final String statCurrency;
  final String labelTooltipMessage;
  final String revenueTooltipMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: Gutter.separateChildren(
        children: <Widget>[
          CustomTooltip(
            message: labelTooltipMessage,
            child: Text(
              statLabel,
              style: TextStyle(
                fontFamily: StoycoFontFamilyToken.gilroy,
                fontSize: StoycoScreenSize.fontSize(context, 10),
                fontWeight: FontWeight.w500,
                color: ColorFoundation.text.saHighlights,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                NumbersFormat.formatWithCommasInt(statValue),
                style: TextStyle(
                  package: 'stoyco_partners_shared',
                  fontFamily: StoycoFontFamilyToken.apercu,
                  fontSize: StoycoScreenSize.fontSize(context, 10),
                  fontWeight: FontWeight.w500,
                  color: ColorFoundation.text.saLight,
                ),
              ),
              RevenueStat(
                value: statRevenue,
                currency: statCurrency,
                tooltipMessage: revenueTooltipMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
