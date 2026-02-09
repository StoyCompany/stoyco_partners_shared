import 'package:json_annotation/json_annotation.dart';
import 'package:stoyco_partners_shared/design/models/bases/content_card_model.dart';

part 'announcements_content_model.g.dart';

@JsonSerializable()
class AnnouncementsContentModel extends ContentCardModel {
  const AnnouncementsContentModel({
    required super.id,
    required super.contentImageUrl,
    required this.title,
    required this.description,
    required this.status,
    required this.closeDate,
    required this.participants,
    required this.likes,
    required this.shares,
    required this.comments,
    required this.views,
  }) : super(contentType: ContentType.announcements);
  factory AnnouncementsContentModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementsContentModelFromJson(json);

  final String title;
  final String description;
  final AnnouncementStatus status;
  final String closeDate;
  final int participants;
  final int likes;
  final int shares;
  final int comments;
  final int views;

  Map<String, dynamic> toJson() => _$AnnouncementsContentModelToJson(this);

  @override
  List<Object?> get props => <Object?>[
    ...super.props,
    title,
    description,
    status,
    closeDate,
    participants,
    likes,
    shares,
    comments,
    views,
  ];
}

enum AnnouncementStatus {
  @JsonValue('open')
  open,
  @JsonValue('closed')
  closed,
}
