import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/templates/content_card_description.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/experiences_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ExperiencesContentDescription extends ContentCardDescription {
  const ExperiencesContentDescription({super.key, required this.data});

  final ExperiencesContentModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 115),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(
                maxWidth: StoycoScreenSize.width(context, 146),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    Text(
                      data.name,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Aforo: ',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 12),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saHighlights,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' ${data.capacity}',
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontSize: StoycoScreenSize.fontSize(context, 12),
                              fontWeight: FontWeight.w500,
                              color: ColorFoundation.text.saLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Boletos cortesía: ',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 12),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saHighlights,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' ${data.courtesyTickets}',
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontSize: StoycoScreenSize.fontSize(context, 12),
                              fontWeight: FontWeight.w500,
                              color: ColorFoundation.text.saLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Boletos Disponibles: ',
                        style: TextStyle(
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          fontSize: StoycoScreenSize.fontSize(context, 12),
                          fontWeight: FontWeight.w500,
                          color: ColorFoundation.text.saHighlights,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: ' ${data.availableTickets}',
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontSize: StoycoScreenSize.fontSize(context, 12),
                              fontWeight: FontWeight.w500,
                              color: ColorFoundation.text.saLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      data.eventDate,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 8),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  extent: StoycoScreenSize.height(context, 5),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Gutter.separateChildren(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: ColorFoundation.background.saHighlights,
                      borderRadius: BorderRadius.circular(
                        StoycoScreenSize.radius(context, 100),
                      ),
                    ),
                    child: Center(child: Text('${data.ticketPrice}')),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorFoundation.background.saHighlights,
                      borderRadius: BorderRadius.circular(
                        StoycoScreenSize.radius(context, 100),
                      ),
                    ),
                    child: Center(child: Text('${data.totalTickets}')),
                  ),
                ],
                extent: StoycoScreenSize.height(context, 5),
              ),
            ),
          ],
          extent: StoycoScreenSize.width(context, 18),
        ),
      ),
    );
  }
}
