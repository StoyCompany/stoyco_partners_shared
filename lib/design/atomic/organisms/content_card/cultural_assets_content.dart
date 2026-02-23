import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/images/image_stoyco_cache.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/cultural_assets_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class CulturalAssetsContent extends StatelessWidget {
  const CulturalAssetsContent({required this.data, super.key});

  final CulturalAssetsContentModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorFoundation.background.chartBlack,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Gutter.separateChildren(
          children: <Widget>[
            ImageStoycoCache(
              height: 141,
              imageUrl: data.contentImageUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(StoycoScreenSize.radius(context, 10)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: StoycoScreenSize.symmetric(
                  context, 
                  vertical: 8,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: TextStyle(
                            fontSize: StoycoScreenSize.fontSize(context, 14),
                            fontWeight: FontWeight.w600,
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            color: ColorFoundation.text.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gutter(StoycoScreenSize.height(context, 4)),
                        RichText(
                          text: TextSpan(
                            text: '${data.stoycoCoins}',
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontSize: StoycoScreenSize.fontSize(context, 12),
                              fontWeight: FontWeight.w700,
                              color: ColorFoundation.text.white,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' SC',
                                style: TextStyle(
                                  fontFamily: StoycoFontFamilyToken.gilroy,
                                  fontSize: StoycoScreenSize.fontSize(context, 8),
                                  fontWeight: FontWeight.w600,
                                  color: ColorFoundation.text.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Holders ${NumbersFormat.formatCompact(data.holders.toDouble())} /',
                          style: TextStyle(
                            fontSize: StoycoScreenSize.fontSize(context, 8),
                            fontWeight: FontWeight.w500,
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontStyle: FontStyle.italic,
                            color: ColorFoundation.text.white,
                          ),
                        ),
                        Gutter(StoycoScreenSize.height(context, 1.5)),
                        Text(
                          'Disponibles ${NumbersFormat.formatCompact(data.available.toDouble())}',
                          style: TextStyle(
                            fontSize: StoycoScreenSize.fontSize(context, 8),
                            fontWeight: FontWeight.w500,
                            fontFamily: StoycoFontFamilyToken.gilroy,
                            fontStyle: FontStyle.italic,
                            color: ColorFoundation.text.white,
                          ),
                        ),
                        Gutter(StoycoScreenSize.height(context, 10)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
