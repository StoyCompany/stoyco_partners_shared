import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

  /// {@template conuntry_flag}
  /// A [ConuntryFlag] atom for the Stoyco Subscription Atomic Design System.
  /// Displays a country's flag using an image, emoji, or country flag widget.
  /// ### Atomic Level
  /// **Atom** – Smallest UI unit.
  ///
  /// ### Parameters
  /// - `conuntryCode`: The conuntry code (e.g., 'US', 'FR') for which to display the flag.
  /// - `width`: The width of the flag image or emoji. Defaults to 24.
  /// - `height`: The height of the flag image or emoji. Defaults to 16.
  /// - `borderRadius`: The border radius for the flag image. Defaults to 1.
  ///
  /// ### Returns
  /// Renders a flag widget for the given conuntry code, using an image, emoji, or country flag, with design token sizing and border radius.
  ///
  /// ### Example
  /// ```dart
  /// ConuntryFlag(
  ///   conuntryCode: 'US',
  ///   width: 32,
  ///   height: 20,
  ///   borderRadius: 2,
  /// )
  /// ```
  /// {@endtemplate}
class ConuntryFlag extends StatelessWidget {
  /// {@macro conuntry_flag}
  const ConuntryFlag({
    super.key,
    required this.conuntryCode,
    this.width = 24,
    this.height = 16,
    this.borderRadius = 1,
  });

  /// The conuntry code (e.g., 'US', 'FR') for which to display the flag.
  final String conuntryCode;

  /// The width of the flag image or emoji. Defaults to 24.
  final double width;

  /// The height of the flag image or emoji. Defaults to 16.
  final double height;

  /// The border radius for the flag image. Defaults to 1.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget? flagWidget;
    try {
      flagWidget = CountryFlag.fromCountryCode(
        conuntryCode,
        theme: ImageTheme(
          width: width,
          height: height,
          shape: RoundedRectangle(StoycoScreenSize.radius(context, borderRadius)),
        ),
      );
    } catch (e) {
      flagWidget = null;
    }
    return flagWidget ?? const SizedBox.shrink();
  }
}
