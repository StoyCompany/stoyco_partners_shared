import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_card_description/experiences_content_description.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_card_description/news_content_description.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_card_description/video_content_description.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/experiences_content_model.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/news_content_model.dart';
import 'package:stoyco_partners_shared/design/models/content_cards/video_content_model.dart';

abstract class ContentCardDescription extends StatelessWidget {
  const ContentCardDescription({super.key});

  factory ContentCardDescription.fromModel(ContentCardModel model) {
    switch (model.contentType) {
      case ContentType.video:
        return VideoContentDescription(data: model as VideoContentModel);
      case ContentType.experiences:
        return ExperiencesContentDescription(
          data: model as ExperiencesContentModel,
        );
      case ContentType.news:
        return NewsContentDescription(data: model as NewsContentModel);
      case ContentType.announcements:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
