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
    final ScrollController scrollController = ScrollController();

    return Theme(
      data: Theme.of(context).copyWith(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(
            ColorFoundation.background.saDark,
          ),
          radius: Radius.circular(StoycoScreenSize.radius(context, 8)),
          thickness: WidgetStateProperty.all(2.0),
          thumbVisibility: WidgetStateProperty.all(true),
          trackVisibility: WidgetStateProperty.all(true),
        ),
      ),
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Column(
              children: <Widget>[
                // Header
                showHeaders
                    ? Container(
                        padding: StoycoScreenSize.symmetric(
                          context,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: ColorFoundation.background.saDark,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: StoycoScreenSize.width(context, 120),
                              child: Text(
                                'LOCALIDAD',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    9,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: ColorFoundation.text.saDark,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: StoycoScreenSize.width(context, 100),
                              child: Text(
                                'Precio UDS',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    9,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: ColorFoundation.text.saDark,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: StoycoScreenSize.width(context, 80),
                              child: Text(
                                'Total UDS',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    9,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: ColorFoundation.text.saDark,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: StoycoScreenSize.width(context, 120),
                              child: Text(
                                'Valor Total',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(
                                    context,
                                    9,
                                  ),
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
                ...rows.asMap().entries.map((
                  MapEntry<int, ExperienceDetailRow> entry,
                ) {
                  final int index = entry.key;
                  final ExperienceDetailRow row = entry.value;
                  final bool isLast = index == rows.length - 1;

                  return Padding(
                    padding: EdgeInsets.only(top: 5, bottom: isLast ? 0 : 0),
                    child: Container(
                      padding: StoycoScreenSize.symmetric(
                        context,
                        vertical: 5,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        color: ColorFoundation.background.saLight,
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
                          SizedBox(
                            width: StoycoScreenSize.width(context, 120),
                            child: Text(
                              '${row.locality}:',
                              style: TextStyle(
                                fontFamily: StoycoFontFamilyToken.gilroy,
                                fontSize: StoycoScreenSize.fontSize(
                                  context,
                                  10,
                                ),
                                fontWeight: FontWeight.w500,
                                color: ColorFoundation.text.saHighlights,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: StoycoScreenSize.width(context, 100),
                            child: Text(
                              '\$${NumbersFormat.formatWithCommas(row.pricePerUnit)} ${row.currency}',
                              style: TextStyle(
                                fontFamily: StoycoFontFamilyToken.apercu,
                                fontSize: StoycoScreenSize.fontSize(
                                  context,
                                  10,
                                ),
                                fontWeight: FontWeight.w500,
                                color: ColorFoundation.text.saDark,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: StoycoScreenSize.width(context, 80),
                            child: Text(
                              '${row.totalUnits} UDS',
                              style: TextStyle(
                                fontFamily: StoycoFontFamilyToken.apercu,
                                fontSize: StoycoScreenSize.fontSize(
                                  context,
                                  10,
                                ),
                                fontWeight: FontWeight.w500,
                                color: ColorFoundation.text.saDark,
                              ),
                            ),
                          ),
                          Container(
                            padding: StoycoScreenSize.symmetric(
                              context,
                              vertical: 3,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: ColorFoundation.background.saDisabled2,
                              borderRadius: BorderRadius.circular(
                                StoycoScreenSize.radius(context, 100),
                              ),
                            ),
                            child: Text(
                              '\$${NumbersFormat.formatWithCommas(row.totalValue)} ${row.currency}',
                              style: TextStyle(
                                fontFamily: StoycoFontFamilyToken.apercu,
                                fontSize: StoycoScreenSize.fontSize(
                                  context,
                                  10,
                                ),
                                fontWeight: FontWeight.w500,
                                color: ColorFoundation.text.saDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
