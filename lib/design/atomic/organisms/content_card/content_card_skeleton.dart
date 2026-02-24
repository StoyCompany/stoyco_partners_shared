import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

class ContentCardSkeleton extends StatelessWidget {
  const ContentCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Image container (115x115)
        Bone.square(
          size: StoycoScreenSize.width(context, 115),
          borderRadius: BorderRadius.circular(
            StoycoScreenSize.radius(context, 5),
          ),
        ),
        Gutter(StoycoScreenSize.height(context, 18)),
        // Content section
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title, description, date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Bone.multiText(
                      lines: 3,
                      fontSize: StoycoScreenSize.fontSize(context, 16),
                    ),
                  ],
                ),
              ),
              Gutter(StoycoScreenSize.width(context, 18)),
              // Stats section (3 text items)
              SizedBox(
                width: StoycoScreenSize.width(context, 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Bone.text(
                      words: 1,
                      fontSize: StoycoScreenSize.fontSize(context, 16),
                    ),
                    Gutter(StoycoScreenSize.height(context, 5)),
                    Bone.text(
                      words: 1,
                      fontSize: StoycoScreenSize.fontSize(context, 16),
                    ),
                    Gutter(StoycoScreenSize.height(context, 5)),
                    Bone.text(
                      words: 1,
                      fontSize: StoycoScreenSize.fontSize(context, 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
