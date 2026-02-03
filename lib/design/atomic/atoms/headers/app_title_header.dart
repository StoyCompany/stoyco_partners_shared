import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

class AppTitleHeader extends StatelessWidget {
  const AppTitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double titleSize = context.layout.value(xs: 22, md: 25, lg: 28);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            Text(
              'STOYCO',
              style: FontFoundation.title.mediumSaLight.copyWith(
                fontSize: titleSize,
              ),
            ),
            StoycoAssetsToken.lib.assets.images.stoycoOnboardingLogo.image(
              package: 'stoyco_partners_shared',
              width: 95,
              height: 152,
            ),
            Text(
              'PARTNERS',
              style: FontFoundation.title.mediumSaLight.copyWith(
                fontSize: titleSize,
              ),
            ),
          ],
          extent: 18,
        ),
      ),
    );
  }
}
