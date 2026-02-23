import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/images/image_stoyco_cache.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key, 
    required this.imageUrl, 
    required this.content,
    this.isActive = false,
    this.borderRadiusImage,
  });

  final String imageUrl;
  final bool isActive;
  final Widget content;
  final BorderRadius? borderRadiusImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 115),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ImageStoycoCache(
                  imageUrl: imageUrl,
                  height: 115,
                  width: 115,
                  backgroundColor: ColorFoundation.background.chartBlack,
                  borderRadius: borderRadiusImage,
                ),
                Visibility(
                  visible: isActive,
                  child: Positioned(
                    bottom: StoycoScreenSize.height(context, 8),
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: StoycoScreenSize.width(context, 115) * 0.8,
                        padding: StoycoScreenSize.symmetric(
                          context,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: ColorFoundation.background.saHighlights,
                        ),
                        child: Text(
                          'Activo',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: StoycoScreenSize.fontSize(context, 12),
                            color: ColorFoundation.text.saDark,
                            fontWeight: FontWeight.w500,
                            fontFamily: StoycoFontFamilyToken.gilroy,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: content,
            ),
          ],
          extent: StoycoScreenSize.width(context, 16),
        ),
      ),
    );
  }
}
