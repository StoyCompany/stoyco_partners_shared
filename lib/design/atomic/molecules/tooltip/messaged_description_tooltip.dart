import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class MessagedDescriptionTooltip extends StatelessWidget {

  const MessagedDescriptionTooltip({
    super.key,
    required this.message,
    required this.data,
    required this.tooltipMessage,
  });
  
  final String message;
  final int data;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      message: tooltipMessage,
      child: RichText(
        text: TextSpan(
          text: message,
          style: TextStyle(
            fontFamily: StoycoFontFamilyToken.gilroy,
            fontSize: StoycoScreenSize.fontSize(context, 12),
            fontWeight: FontWeight.w500,
            color: ColorFoundation.text.saHighlights,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: ' ${NumbersFormat.formatCompact(data.toDouble())}',
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
    );
  }
}
