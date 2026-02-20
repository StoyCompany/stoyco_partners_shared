import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/content_stat/content_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/content_stat_tootip.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
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
          ContentStatWithTooltip(
            contentStat: ContentStat(
              icon: StoycoAssetsToken.lib.assets.icons.like.svg(
                package: 'stoyco_partners_shared',
                width: StoycoScreenSize.width(context, 14),
                height: StoycoScreenSize.height(context, 14),
              ),
              stat: NumbersFormat.formatCompact(likes.toDouble()),
            ),
            tooltipMessage: likesTooltip,
          ),
          ContentStatWithTooltip(
            contentStat: ContentStat(
              icon: StoycoAssetsToken.lib.assets.icons.share.svg(
                package: 'stoyco_partners_shared',
                width: StoycoScreenSize.width(context, 14),
                height: StoycoScreenSize.height(context, 14),
              ),
              stat: NumbersFormat.formatCompact(shares.toDouble()),
            ),
            tooltipMessage: sharesTooltip,
          ),
          ContentStatWithTooltip(
            contentStat: ContentStat(
              icon: StoycoAssetsToken.lib.assets.icons.message.svg(
                package: 'stoyco_partners_shared',
                width: StoycoScreenSize.width(context, 14),
                height: StoycoScreenSize.height(context, 14),
              ),
              stat: NumbersFormat.formatCompact(comments.toDouble()),
            ),
            tooltipMessage: commentsTooltip,
          ),
          ContentStatWithTooltip(
            contentStat: ContentStat(
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color: ColorFoundation.text.saLight,
                size: StoycoScreenSize.height(context, 14),
              ),
              stat: NumbersFormat.formatCompact(views.toDouble()),
            ),
            tooltipMessage: viewsTooltip,
          ),
        ],
        extent: StoycoScreenSize.height(context, 5),
      ),
    );
  }
}
