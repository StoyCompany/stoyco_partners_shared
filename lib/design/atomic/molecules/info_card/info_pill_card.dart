import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// Reusable info pill card widget that displays an informative message
///
/// This component shows a message with an info icon, using customizable colors
/// and styling. It's designed to display notifications, tips, or important
/// information to the user.
///
/// Usage example:
/// ```dart
/// InfoPillCard(
///   message: 'Withdrawals available soon',
///   iconColor: Colors.purple,
///   textColor: Colors.purple,
///   borderColor: Colors.purple,
///   backgroundColor: Colors.deepPurple,
///   fontSize: 15,
/// )
/// ```
class InfoPillCard extends StatelessWidget {
  const InfoPillCard({
    super.key, 
    required this.message,
    this.iconColor,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.fontSize = 12,
    this.fontFamily = StoycoFontFamilyToken.gilroy,
    this.borderWidth = 1,
    this.borderRadius = 8,
  });

  /// The informative message to display
  final String message;

  /// Icon color for the info icon
  final Color? iconColor;

  /// Text color for the message
  final Color? textColor;

  /// Border color for the card
  final Color? borderColor;

  /// Background color for the card
  final Color? backgroundColor;

  /// Font size for the message text in design pixels
  final double fontSize;

  /// Font family for the text
  final String fontFamily;

  /// Border width in logical pixels (default: 1)
  final double borderWidth;

  /// Border radius value in design pixels (default: 8)
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final Color infoBackgroundColorResolved = backgroundColor ?? ColorFoundation.background.saHighlights.withValues(alpha: 0.10);
    final Color infoIconColorResolved = iconColor ?? ColorFoundation.text.saHighlights;

    final Color infoBorderColorResolved = (borderColor ?? ColorFoundation.border.saHighlights).withValues(alpha: 0.20);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: StoycoScreenSize.width(context, 12),
        vertical: StoycoScreenSize.height(context, 6),
      ),
      decoration: BoxDecoration(
        color: infoBackgroundColorResolved,
        borderRadius: BorderRadius.circular(
          StoycoScreenSize.radius(context, borderRadius),
        ),
        border: Border.all(color: infoBorderColorResolved, width: borderWidth),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.info,
            size: StoycoScreenSize.width(context, 16),
            color: infoIconColorResolved,
          ),
          SizedBox(width: StoycoScreenSize.width(context, 10)),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: fontSize,
                color: textColor ?? ColorFoundation.text.saHighlights,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
