import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

class ContentTooltipStat extends StatelessWidget {
  const ContentTooltipStat({
    required this.stat,
    required this.icon,
    required this.tooltipMessage,
    this.position = TooltipPosition.top,
    super.key,
  });

  final int stat;
  final SvgGenImage icon;
  final TooltipPosition position;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      position: position,
      message: tooltipMessage,
      child: ContentStat(
        icon: icon.svg(
          package: 'stoyco_partners_shared',
          width: StoycoScreenSize.width(context, 14),
          height: StoycoScreenSize.height(context, 14),
        ),
        stat: NumbersFormat.formatCompact(stat.toDouble()),
      ),
    );
  }
}
