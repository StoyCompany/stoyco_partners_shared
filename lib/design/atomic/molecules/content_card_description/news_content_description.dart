import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/templates/content_card_description.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/news_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class NewsContentDescription extends ContentCardDescription {
  const NewsContentDescription({super.key, required this.data});

  final NewsContentModel data;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    Text(
                      data.title,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.description,
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      data.publishDate,
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
                  ContentStat(
                    icon: StoycoAssetsToken.lib.assets.icons.like.svg(
                      package: 'stoyco_partners_shared',
                      width: StoycoScreenSize.width(context, 14),
                      height: StoycoScreenSize.height(context, 14),
                    ),
                    stat: data.likes.toString(),
                  ),
                  ContentStat(
                    icon: StoycoAssetsToken.lib.assets.icons.share.svg(
                      package: 'stoyco_partners_shared',
                      width: StoycoScreenSize.width(context, 14),
                      height: StoycoScreenSize.height(context, 14),
                    ),
                    stat: data.shares.toString(),
                  ),
                  ContentStat(
                    icon: StoycoAssetsToken.lib.assets.icons.message.svg(
                      package: 'stoyco_partners_shared',
                      width: StoycoScreenSize.width(context, 14),
                      height: StoycoScreenSize.height(context, 14),
                    ),
                    stat: data.comments.toString(),
                  ),
                  ContentStat(
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorFoundation.text.saLight,
                      size: StoycoScreenSize.height(context, 14),
                    ),
                    stat: data.views.toString(),
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
