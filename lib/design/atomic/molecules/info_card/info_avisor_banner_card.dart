import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

/// Reusable info advisor banner card widget that displays a promotional message
///
/// This component shows an advisor tip with a percentage value and a call-to-action
/// to consult with an advisor. It features a gradient border and customizable styling.
/// Perfect for promoting advisor consultations with an engaging message.
///
/// Usage example:
/// ```dart
/// InfoAdvisorBannerCard(
///   percent: 30,
///   mainText: 'Generate up to',
///   middleText: 'more',
///   endText: 'revenue starting today.',
///   ctaText: 'Consult with my advisor',
///   onTapInfo: () {
///     // Navigate to advisor consultation
///   },
/// )
/// ```
class InfoAdvisorBannerCard extends StatelessWidget {
  const InfoAdvisorBannerCard({
    super.key,
    required this.percent,
    this.mainText = 'Genera hasta',
    this.middleText = 'más',
    this.endText = 'ingresos desde hoy.',
    this.ctaText = 'Consulta con mi asesor',
    this.borderWidth = 1,
    this.outerBorderRadius = 8,
    this.innerBorderRadius = 7,
    this.mainTextColor,
    this.highlightTextColor,
    this.ctaTextColor,
    this.iconColor,
    this.backgroundColor,
    this.onTapInfo,
  });

  /// The percentage value to display in the promotional message
  final int percent;

  /// Main text before the percentage (default: 'Generate up to')
  final String mainText;

  /// Text after the percentage (default: 'more')
  final String middleText;

  /// Text at the end of the first line (default: 'revenue starting today.')
  final String endText;

  /// Call-to-action text (default: 'Consult with my advisor')
  final String ctaText;

  /// Border width in design pixels (default: 1)
  final double borderWidth;

  /// Outer border radius in design pixels (default: 8)
  final double outerBorderRadius;

  /// Inner border radius in design pixels (default: 7)
  final double innerBorderRadius;

  /// Optional color for the main text
  final Color? mainTextColor;

  /// Optional color for the percentage highlight text
  final Color? highlightTextColor;

  /// Optional color for the CTA text
  final Color? ctaTextColor;

  /// Optional color for the icon
  final Color? iconColor;

  /// Optional background color
  final Color? backgroundColor;

  /// Optional callback when the card is tapped
  final VoidCallback? onTapInfo;

  @override
  Widget build(BuildContext context) {
    final Color resolvedMainTextColor = mainTextColor ?? ColorFoundation.text.white.withValues(alpha: 0.70);
    final Color resolvedHighlightTextColor = highlightTextColor ?? ColorFoundation.text.white.withValues(alpha: 0.70);
    final Color resolvedCtaTextColor = ctaTextColor ?? ColorFoundation.text.saHighlights;
    final Color resolvedIconColor = iconColor ?? ColorFoundation.text.saHighlights;
    final Color resolvedBackgroundColor = backgroundColor ?? ColorFoundation.background.cardFinancialLayer;

    return GestureDetector(
      onTap: onTapInfo,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            StoycoScreenSize.radius(context, outerBorderRadius),
          ),
          gradient: const RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: <Color>[
              Color(0xFFA27FEE), // 0%
              Color(0xFF9F7DEB), // 37%
              Color(0xFF9876E4), // 54%
              Color(0xFF8B6BD7), // 66%
              Color(0xFF795BC5), // 77%
              Color(0xFF6146AD), // 87%
              Color(0xFF442C90), // 96%
              Color(0xFF331D7F), // 100%
            ],
            stops: <double>[0.0, 0.37, 0.54, 0.66, 0.77, 0.87, 0.96, 1.0],
          ),
        ),
        padding: EdgeInsets.all(StoycoScreenSize.width(context, borderWidth)),
        child: Container(
          padding: StoycoScreenSize.all(context, 16),
          decoration: BoxDecoration(
            color: resolvedBackgroundColor,
            borderRadius: BorderRadius.circular(
              StoycoScreenSize.radius(context, innerBorderRadius),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: StoycoScreenSize.fromLTRB(context, top: 3),
                child: Icon(
                  Icons.tips_and_updates_outlined,
                  color: resolvedIconColor,
                  size: StoycoScreenSize.width(context, 19),
                ),
              ),
              SizedBox(width: StoycoScreenSize.width(context, 14)),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: StoycoScreenSize.fontSize(context, 14),
                      color: resolvedCtaTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: '$mainText ',
                        style: TextStyle(
                          fontSize: StoycoScreenSize.fontSize(context, 14),
                          color: resolvedMainTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: '$percent% $middleText',
                        style: TextStyle(
                          fontSize: StoycoScreenSize.fontSize(context, 14),
                          color: resolvedHighlightTextColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' $endText\n',
                        style: TextStyle(
                          fontSize: StoycoScreenSize.fontSize(context, 14),
                          color: resolvedMainTextColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          height: StoycoScreenSize.height(context, 10),
                        ),
                      ),
                      TextSpan(
                        text: ctaText,
                        style: TextStyle(
                          color: resolvedCtaTextColor,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
