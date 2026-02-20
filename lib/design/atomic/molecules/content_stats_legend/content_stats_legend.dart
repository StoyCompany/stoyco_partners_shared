import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/content_tooltip_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

class ContentStatsLegend extends StatelessWidget {

  const ContentStatsLegend({
    super.key,
    required this.likes,
    required this.shares,
    required this.comments,
    required this.views,
    required this.likesTooltip,
    required this.sharesTooltip,
    required this.commentsTooltip,
    required this.viewsTooltip,
  });
  
  final int likes;
  final int shares;
  final int comments;
  final int views;
  final String likesTooltip;
  final String sharesTooltip;
  final String commentsTooltip;
  final String viewsTooltip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: Gutter.separateChildren(
        children: <Widget>[
          ContentTooltipStat(
            stat: likes,
            icon: StoycoAssetsToken.lib.assets.icons.like,
            tooltipMessage: likesTooltip,
            position: TooltipPosition.left,
          ),
          ContentTooltipStat(
            stat: shares,
            icon: StoycoAssetsToken.lib.assets.icons.share,
            tooltipMessage: sharesTooltip,
            position: TooltipPosition.left,
          ),
          ContentTooltipStat(
            stat: comments,
            icon: StoycoAssetsToken.lib.assets.icons.message,
            tooltipMessage: commentsTooltip,
            position: TooltipPosition.left,
          ),
          ContentTooltipStat(
            stat: views,
            icon: StoycoAssetsToken.lib.assets.icons.eye,
            tooltipMessage: viewsTooltip,
            position: TooltipPosition.left,
          ),
        ],
        extent: StoycoScreenSize.height(context, 5),
      ),
    );
  }
}
