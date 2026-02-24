import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// A data class representing a row in the experience detail table.
class ExperienceDetailRow {
  const ExperienceDetailRow({
    required this.locality,
    required this.pricePerUnit,
    required this.totalUnits,
    required this.totalValue,
    required this.currency,
  });

  final String locality;
  final double pricePerUnit;
  final int totalUnits;
  final double totalValue;
  final String currency;
}

/// A table widget that displays experience details with locality information.
///
/// Displays data in columns: LOCALIDAD, Precio UDS, Total UDS, and Valor Total.
class ExperienceDetailTable extends StatelessWidget {
  const ExperienceDetailTable({
    super.key,
    required this.rows,
    this.showHeaders = true,
  });

  final List<ExperienceDetailRow> rows;
  final bool showHeaders;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Header
        showHeaders
            ? Container(
                padding: StoycoScreenSize.symmetric(context, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: ColorFoundation.background.saDark,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Text(
                        'LOCALIDAD',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 9),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saDark,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Precio UDS',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 9),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saDark,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Total UDS',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 9),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saDark,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Valor Total',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 9),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        // Rows
        ...rows.asMap().entries.map((MapEntry<int, ExperienceDetailRow> entry) {
          final int index = entry.key;
          final ExperienceDetailRow row = entry.value;
          final bool isLast = index == rows.length - 1;

          return Container(
            padding: StoycoScreenSize.symmetric(
              context,
              vertical: 12,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: index.isEven
                  ? ColorFoundation.background.saLight
                  : ColorFoundation.background.saHighlights.withOpacity(0.3),
              borderRadius: isLast
                  ? BorderRadius.only(
                      bottomLeft: Radius.circular(
                        StoycoScreenSize.radius(context, 8),
                      ),
                      bottomRight: Radius.circular(
                        StoycoScreenSize.radius(context, 8),
                      ),
                    )
                  : null,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    row.locality,
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      fontSize: StoycoScreenSize.fontSize(context, 10),
                      fontWeight: FontWeight.w500,
                      color: ColorFoundation.text.saDark,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '\$${NumbersFormat.formatWithCommas(row.pricePerUnit)}',
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.apercu,
                      fontSize: StoycoScreenSize.fontSize(context, 10),
                      fontWeight: FontWeight.w400,
                      color: ColorFoundation.text.saDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    NumbersFormat.formatWithCommas(row.totalUnits.toDouble()),
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.apercu,
                      fontSize: StoycoScreenSize.fontSize(context, 10),
                      fontWeight: FontWeight.w400,
                      color: ColorFoundation.text.saDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '\$${NumbersFormat.formatWithCommas(row.totalValue)} ${row.currency}',
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.apercu,
                      fontSize: StoycoScreenSize.fontSize(context, 10),
                      fontWeight: FontWeight.w500,
                      color: ColorFoundation.text.saDark,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
