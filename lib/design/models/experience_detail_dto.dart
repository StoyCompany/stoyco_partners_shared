import 'package:equatable/equatable.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/table/experience_detail_table.dart';

/// Data Transfer Object for Experience Detail Modal
///
/// Contains all the necessary data to display in the ExperienceDetailModal.
class ExperienceDetailDto extends Equatable {
  const ExperienceDetailDto({
    required this.eventName,
    required this.eventDate,
    required this.soldRows,
    required this.availableRows,
    this.soldUnits,
    this.soldValue,
    this.availableUnits,
    this.availableValue,
    this.totalUnits,
    this.totalValue,
    this.currency = 'MXN',
  });

  /// The name of the event/experience
  final String eventName;

  /// The date of the event
  final DateTime eventDate;

  /// Rows to display in the "Sold" table
  final List<ExperienceDetailRow> soldRows;

  /// Rows to display in the "Available" table
  final List<ExperienceDetailRow> availableRows;

  /// Total number of sold units
  final int? soldUnits;

  /// Total value of sold units
  final double? soldValue;

  /// Total number of available units
  final int? availableUnits;

  /// Total value of available units
  final double? availableValue;

  /// Total number of units (sold + available)
  final int? totalUnits;

  /// Total value (sold + available)
  final double? totalValue;

  /// Currency code (e.g., 'COP', 'MXN', 'USD')
  final String currency;

  @override
  List<Object?> get props => <Object?>[
    eventName,
    eventDate,
    soldRows,
    availableRows,
    soldUnits,
    soldValue,
    availableUnits,
    availableValue,
    totalUnits,
    totalValue,
    currency,
  ];

  /// Creates a copy of this DTO with the given fields replaced with new values
  ExperienceDetailDto copyWith({
    String? eventName,
    DateTime? eventDate,
    List<ExperienceDetailRow>? soldRows,
    List<ExperienceDetailRow>? availableRows,
    int? soldUnits,
    double? soldValue,
    int? availableUnits,
    double? availableValue,
    int? totalUnits,
    double? totalValue,
    String? currency,
  }) {
    return ExperienceDetailDto(
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      soldRows: soldRows ?? this.soldRows,
      availableRows: availableRows ?? this.availableRows,
      soldUnits: soldUnits ?? this.soldUnits,
      soldValue: soldValue ?? this.soldValue,
      availableUnits: availableUnits ?? this.availableUnits,
      availableValue: availableValue ?? this.availableValue,
      totalUnits: totalUnits ?? this.totalUnits,
      totalValue: totalValue ?? this.totalValue,
      currency: currency ?? this.currency,
    );
  }
}
