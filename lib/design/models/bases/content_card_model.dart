import 'package:equatable/equatable.dart';

abstract class ContentCardModel extends Equatable {
  const ContentCardModel({
    required this.id,
    required this.contentImageUrl,
    required this.contentType,
  });

  final String id;
  final String contentImageUrl;
  final ContentType contentType;

  @override
  List<Object?> get props => <Object?>[id, contentImageUrl, contentType];
}

enum ContentType {
  video,
  news,
  announcements,
  experiences,
  dynamics,
  music,
  projectsToFund,
  merch,
  culturalAssets
}
