import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

//Todo: refactor hardcoded strings and numbers.
class ContentCardDescription extends StatelessWidget {
  const ContentCardDescription({super.key});

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
                maxWidth: StoycoScreenSize.width(context, 148),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Gutter.separateChildren(
                  children: <Widget>[
                    Text(
                      'Nombre del video muy largo dos renglones max',
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
                      'Descripcion del video lorem ipsum, lorem ipsum lorem lorem ipsum lorem lor ipsum lorem ipsum lore',
                      style: TextStyle(
                        fontFamily: StoycoFontFamilyToken.gilroy,
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        color: ColorFoundation.text.saLight,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '01-10-15',
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
                    stat: '1.3k',
                  ),
                  ContentStat(
                    icon: StoycoAssetsToken.lib.assets.icons.share.svg(
                      package: 'stoyco_partners_shared',
                      width: StoycoScreenSize.width(context, 14),
                      height: StoycoScreenSize.height(context, 14),
                    ),
                    stat: '856',
                  ),
                  ContentStat(
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: ColorFoundation.text.saLight,
                      size: StoycoScreenSize.height(context, 14),
                    ),
                    stat: '15.8k',
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
