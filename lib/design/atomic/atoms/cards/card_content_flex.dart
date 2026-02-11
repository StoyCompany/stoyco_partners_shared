import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

class CardcContentFlex extends StatelessWidget {
  const CardcContentFlex({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: StoycoScreenSize.symmetric(context, horizontal: 20),
      decoration: BoxDecoration(
        color: ColorFoundation.background.saLight,
        borderRadius: BorderRadius.circular(
          StoycoScreenSize.radius(context, 25),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: StoycoScreenSize.height(context, 638),
      ),
      child: Padding(
        padding: StoycoScreenSize.fromLTRB(
          context,
          top: 35,
          left: 33,
          right: 33,
          bottom: 20,
        ),
        child: child,
      ),
    );
  }
}
