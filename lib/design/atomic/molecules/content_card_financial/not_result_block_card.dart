import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// Reusable widget to display a "no results" message with optional retry action
///
/// This component shows a cloud-off icon, a customizable message, and an optional
/// retry button. It's designed to inform users when no data is available or when
/// a query returns no results.
///
/// Usage example:
/// ```dart
/// NoResultsBlockCard(
///   title: 'No results found',
///   retryText: 'Try again',
///   sizeIcon: 40,
///   onRetry: () async {
///     // Retry logic here
///   },
/// )
/// ```
class NoResultsBlockCard extends StatelessWidget {
  const NoResultsBlockCard({
    super.key,
    this.title = 'Sin resultados',
    this.retryText = 'Reintentar',
    this.sizeIcon = 30,
    this.buttonBorderRadius = 18,
    this.titleColor,
    this.iconColor,
    this.buttonTextColor,
    this.buttonBorderColor,
    this.fontFamily = StoycoFontFamilyToken.gilroy,
    this.onRetry,
  });

  /// Title text to display below the icon
  final String title;
  
  /// Text for the retry button
  final String retryText;
  
  /// Size of the cloud-off icon in design pixels
  final double sizeIcon;
  
  /// Border radius for the retry button in design pixels
  final double buttonBorderRadius;
  
  /// Optional color for the title text
  final Color? titleColor;
  
  /// Optional color for the icon
  final Color? iconColor;
  
  /// Optional color for the button text
  final Color? buttonTextColor;
  
  /// Optional color for the button border
  final Color? buttonBorderColor;
  
  /// Font family for text elements
  final String fontFamily;
  
  /// Optional callback function when retry button is tapped
  final Future<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    final Color resolvedIconColor = iconColor ?? ColorFoundation.text.saTextDisabled;
    final Color resolvedTitleColor = titleColor ?? ColorFoundation.text.white;
    final Color resolvedButtonTextColor = buttonTextColor ?? ColorFoundation.text.white;
    final Color resolvedButtonBorderColor = buttonBorderColor ?? ColorFoundation.text.white.withValues(alpha: 0.5);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.cloud_off_outlined,
          color: resolvedIconColor,
          size: StoycoScreenSize.width(context, sizeIcon),
        ),
        SizedBox(height: StoycoScreenSize.height(context, 14)),
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: StoycoScreenSize.fontSize(context, 16),
            color: resolvedTitleColor,
            fontWeight: FontWeight.w400,
            fontFamily: fontFamily,
          ),
        ),
        SizedBox(height: StoycoScreenSize.height(context, 24)),
        if (onRetry != null)
        SizedBox(
          height: StoycoScreenSize.height(context, 36),
          width: StoycoScreenSize.width(context, 150),
          child: OutlinedButton(
            onPressed: onRetry,
            style: OutlinedButton.styleFrom(
              foregroundColor: resolvedButtonTextColor,
              side: BorderSide(
                color: resolvedButtonBorderColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  StoycoScreenSize.radius(context, buttonBorderRadius),
                ),
              ),
              textStyle: TextStyle(
                fontSize: StoycoScreenSize.fontSize(context, 14),
                color: resolvedButtonTextColor,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
                fontFamily: fontFamily,
              ),
            ),
            child: Text(
              retryText,
              style: TextStyle(
                fontSize: StoycoScreenSize.fontSize(context, 12),
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
                fontFamily: fontFamily,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
