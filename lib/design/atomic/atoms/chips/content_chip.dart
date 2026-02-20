import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class ContentChip extends StatelessWidget {
  const ContentChip({
    required this.message,
    required this.tooltipMessage,
    super.key,
  });

  final String message;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      message: tooltipMessage,
      child: Container(
        padding: StoycoScreenSize.symmetric(context, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: ColorFoundation.background.saHighlights,
        ),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: StoycoScreenSize.fontSize(context, 12),
            color: ColorFoundation.text.saDark,
            fontWeight: FontWeight.w500,
            fontFamily: StoycoFontFamilyToken.gilroy,
          ),
        ),
      ),
    );
  }
}
