import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/templates/content_card_description.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key, required this.data});
  final ContentCardModel data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: StoycoScreenSize.height(context, 115),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: Gutter.separateChildren(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(
                StoycoScreenSize.radius(context, 5),
              ),
              child: CachedNetworkImage(
                height: StoycoScreenSize.height(context, 115),
                width: StoycoScreenSize.width(context, 115),
                fit: BoxFit.fill,
                imageUrl: data.contentImageUrl,
              ),
            ),
            Expanded(child: ContentCardDescription.fromModel(data)),
          ],
          extent: StoycoScreenSize.width(context, 16),
        ),
      ),
    );
  }
}
