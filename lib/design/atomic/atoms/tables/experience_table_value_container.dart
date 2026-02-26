import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ExperienceTableValueContainer extends StatelessWidget {
  const ExperienceTableValueContainer({
    super.key,
    required this.text,
    required this.units,
    required this.value,
    required this.currency,
  });

  final String text;

  final int units;

  final double value;

  final String currency;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: StoycoScreenSize.symmetric(context, vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: ColorFoundation.background.saDark,
        borderRadius: BorderRadius.circular(
          StoycoScreenSize.radius(context, 100),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: text,
                  style: TextStyle(
                    package: 'stoyco_partners_shared',
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontSize: StoycoScreenSize.fontSize(context, 12),
                    fontWeight: FontWeight.w500,
                    color: ColorFoundation.text.saLight,
                  ),
                ),
                TextSpan(
                  text: '$units',
                  style: TextStyle(
                    package: 'stoyco_partners_shared',
                    fontFamily: StoycoFontFamilyToken.apercu,
                    fontSize: StoycoScreenSize.fontSize(context, 12),
                    fontWeight: FontWeight.w500,
                    color: ColorFoundation.text.saLight,
                  ),
                ),
                TextSpan(
                  text: ' UDS',
                  style: TextStyle(
                    package: 'stoyco_partners_shared',
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontSize: StoycoScreenSize.fontSize(context, 12),
                    fontWeight: FontWeight.w500,
                    color: ColorFoundation.text.saLight,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: StoycoScreenSize.symmetric(
              context,
              vertical: 3,
              horizontal: 7,
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
                package: 'stoyco_partners_shared',
                fontFamily: StoycoFontFamilyToken.apercu,
                fontSize: StoycoScreenSize.fontSize(context, 8),
                fontWeight: FontWeight.w500,
                color: ColorFoundation.text.saDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
