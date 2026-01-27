import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ContentStat extends StatelessWidget {
  const ContentStat({super.key, required this.icon, required this.stat});

  final Widget icon;
  final String stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: Gutter.separateChildren(
        children: <Widget>[
          icon,
          Text(
            stat,
            style: TextStyle(
              fontFamily: StoycoFontFamilyToken.akkurat,
              fontSize: StoycoScreenSize.fontSize(context, 12),
              fontWeight: FontWeight.w400,
              color: ColorFoundation.text.saLight,
            ),
          ),
        ],
        extent: StoycoScreenSize.width(context, 10),
      ),
    );
  }
}
