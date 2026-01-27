import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_card_description/content_card_description.dart';
import 'package:stoyco_partners_shared/design/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

class ContentCard extends StatelessWidget {
  const ContentCard({super.key});

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
                imageUrl:
                    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fymimg1.b8cdn.com%2Fresized%2Farticle%2F8849%2Fpictures%2F10880964%2Flisting_main_Image_1.jpg&f=1&nofb=1&ipt=dda5f127ea9f91fb1c39ffcaa74d7221cbbb7783e93e96d084dcf7eed868f6d6',
              ),
            ),
            //Todo: the idea here is to show description widgets depending on the type of content. This is the video, news one. Default style
            const Expanded(child: ContentCardDescription()),
          ],
          extent: StoycoScreenSize.width(context, 16),
        ),
      ),
    );
  }
}
