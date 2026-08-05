import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

/// Types of financial card variants
enum CardFinancialType {
  /// Type 1: Card with shadows and standard styling
  type1,

  /// Type 2: Card without shadows and alternative border color
  type2,
}

/// Reusable financial card widget with multiple variants
///
/// This component provides a consistent card design for financial information
/// with support for different visual styles through the [type] parameter.
///
/// Usage example:
/// ```dart
/// // Type 1 (default): with shadows
/// CardFinancial(
///   type: CardFinancialType.type1,
///   child: Text('Content'),
/// )
///
/// // Type 2: without shadows, alternative colors
/// CardFinancial(
///   type: CardFinancialType.type2,
///   child: Text('Content'),
/// )
/// ```
class CardFinancial extends StatelessWidget {
  const CardFinancial({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.type = CardFinancialType.type1,
    this.borderCard,
    required this.child,
  });

  /// Optional width for the card
  final double? width;

  /// Optional height for the card
  final double? height;

  /// Optional padding for the card content
  final EdgeInsetsGeometry? padding;

  /// Border radius value in design pixels
  final double borderRadius;

  /// Border width in logical pixels (default: 1)
  final double borderWidth;

  /// Card variant type (type1 or type2)
  final CardFinancialType type;

  /// Optional custom border for the card (overrides default border)
  final Border? borderCard;

  /// Child widget to display inside the card
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Get colors based on card type
    final Color backgroundColor = type == CardFinancialType.type1
        ? ColorFoundation.background.cardFinancialLayer
        : ColorFoundation.background.cardFinancialLayerType2;

    final Color borderColor = type == CardFinancialType.type1
        ? ColorFoundation.background.grey14.withValues(alpha: 0.10)
        : ColorFoundation.background.borderFinancialLayerType2;

    // Apply shadows only for type1
    final List<BoxShadow>? shadows = type == CardFinancialType.type1
        ? <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: -4,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: -3,
              offset: const Offset(0, 10),
            ),
          ]
        : null;

    return Container(
      width: width,
      height: height,
      padding: padding ?? StoycoScreenSize.all(context, 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          StoycoScreenSize.radius(context, borderRadius),
        ),
        border: borderCard ?? Border.all(color: borderColor, width: borderWidth),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
