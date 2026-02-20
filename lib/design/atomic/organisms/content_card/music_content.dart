import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/chips/content_chip.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/images/image_stoyco_cache.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/content_tooltip_stat.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/tooltip/custom_tooltip.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/music_content_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class MusicContent extends StatelessWidget {
  const MusicContent({required this.data, super.key});

  final MusicContentModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: StoycoScreenSize.height(context, 130),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: Gutter.separateChildren(
              children: <Widget>[
                ImageStoycoCache(
                  width: 130,
                  height: 130,
                  imageUrl: data.contentImageUrl,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: StoycoScreenSize.fontSize(context, 12),
                          fontWeight: FontWeight.w500,
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          color: ColorFoundation.text.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        data.description,
                        style: TextStyle(
                          fontSize: StoycoScreenSize.fontSize(context, 12),
                          fontWeight: FontWeight.w300,
                          fontFamily: StoycoFontFamilyToken.gilroy,
                          color: ColorFoundation.text.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ContentTooltipStat(
                            stat: data.shares,
                            icon: StoycoAssetsToken.lib.assets.icons.share,
                            tooltipMessage: 'Total de compartidos generados por esta radio',
                          ),
                          ContentTooltipStat(
                            stat: data.comments,
                            icon: StoycoAssetsToken.lib.assets.icons.message,
                            tooltipMessage: 'Total de comentarios generados en esta radio',
                          ),
                          ContentTooltipStat(
                            position: TooltipPosition.left,
                            stat: data.totalDonatedStoyCoins,
                            icon: StoycoAssetsToken.lib.assets.icons.stoycoCoins,
                            tooltipMessage: 'Total de stoycoins recolectados por esta radio',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              extent: StoycoScreenSize.width(context, 16),
            ),
          ),
        ),
        Gutter(StoycoScreenSize.height(context, 34)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ContentChip(
                message: '# Canciones ${data.tracksCount}',
                tooltipMessage: 'Total de canciones configuradas en esta radio',
              ),
            ),
            Gutter(StoycoScreenSize.width(context, 10)),
            Expanded(
              child: ContentChip(
                message: 'Total plays ${NumbersFormat.formatCompact(data.views.toDouble())}',
                tooltipMessage: 'Total histórico de reproducciones acumuladas de esta radio',
              ),
            ),
          ],
        ),
        Gutter(StoycoScreenSize.height(context, 25)),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Text(
              data.tracks[index],
              style: TextStyle(
                fontSize: StoycoScreenSize.fontSize(context, 14),
                fontWeight: FontWeight.w400,
                fontFamily: StoycoFontFamilyToken.gilroy,
                color: ColorFoundation.text.saLight,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            height: StoycoScreenSize.height(context, 4),
          ),
          itemCount: data.tracks.length,
        ),
      ],
    );
  }
}
