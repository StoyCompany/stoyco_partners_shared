import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

class TooltipButton extends StatelessWidget {
  const TooltipButton({
    super.key,
    required this.tooltipMessage,
    this.padding,
    this.width = 18.0,
    this.height = 18.0,
    this.maxWidth = 116.0,
    this.direction = TooltipDirection.top,
  });

  final String tooltipMessage;
  final EdgeInsetsGeometry? padding;
  final double width;
  final double height;
  final double maxWidth;
  final TooltipDirection direction;

  @override
  Widget build(BuildContext context) {
    return StoycoTooltip(
      message: tooltipMessage,
      maxWidth: StoycoScreenSize.width(context, maxWidth),
      direction: direction,
      child: Container(
        padding: padding,
        child: StoycoAssetsToken.lib.assets.icons.common.interrogation.svg(
          package: 'stoyco_partners_shared',
          width: StoycoScreenSize.width(context, width),
          height: StoycoScreenSize.height(context, height),
        ),
      ),
    );
  }
}
