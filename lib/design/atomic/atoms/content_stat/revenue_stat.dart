import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class RevenueStat extends StatelessWidget {
  const RevenueStat({
    super.key,
    required this.value,
    required this.currency,
    required this.tooltipMessage,
  });

  final double value;
  final String currency;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      position: TooltipPosition.left,
      message: tooltipMessage,
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
          '\$${NumbersFormat.formatWithCommas(value)} $currency',
          style: TextStyle(
            fontFamily: StoycoFontFamilyToken.apercu,  
            fontWeight: FontWeight.w500,
            fontSize: StoycoScreenSize.fontSize(context, 10),
            color: ColorFoundation.text.saDark,
          ),
        ),
      ),
    );
  }
}
