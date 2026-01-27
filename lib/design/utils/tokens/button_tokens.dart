import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

enum ButtonVariant { primary, secondary, outline, ghost, destructive }

enum ButtonSize { xs, sm, md, lg, xl }

class ButtonStyleSpec {

  const ButtonStyleSpec({
    required this.backgroundColor,
    required this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.loadingBackgroundColor,
    this.loadingForegroundColor,
    required this.borderSide,
    required this.borderRadius,
    required this.padding,
    required this.height,
    required this.textStyle,
  });
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? loadingBackgroundColor;
  final Color? loadingForegroundColor;
  final BorderSide? borderSide;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final double height;
  final TextStyle textStyle;
}

class _SizeSpec {

  const _SizeSpec({
    required this.height,
    required this.radius,
    required this.padding,
    required this.fontSize,
  });
  final double height;
  final BorderRadius radius;
  final EdgeInsetsGeometry padding;
  final double fontSize;
}

class ButtonTokens {
  static _SizeSpec _sizes(ButtonSize size) {
    switch (size) {
      case ButtonSize.xs:
        return const _SizeSpec(
          height: 36,
          radius: BorderRadius.all(Radius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          fontSize: 14,
        );
      case ButtonSize.sm:
        return const _SizeSpec(
          height: 40,
          radius: BorderRadius.all(Radius.circular(16)),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          fontSize: 15,
        );
      case ButtonSize.md:
        return const _SizeSpec(
          height: 48,
          radius: BorderRadius.all(Radius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          fontSize: 16,
        );
      case ButtonSize.lg:
        return const _SizeSpec(
          height: 56,
          radius: BorderRadius.all(Radius.circular(22)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          fontSize: 17,
        );
      case ButtonSize.xl:
        return const _SizeSpec(
          height: 68,
          radius: BorderRadius.all(Radius.circular(24)),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          fontSize: 18,
        );
    }
  }

  static ButtonStyleSpec resolve(ButtonVariant variant, ButtonSize size) {
    final _SizeSpec s = _sizes(size);

    switch (variant) {
      case ButtonVariant.primary:
        return ButtonStyleSpec(
          backgroundColor: ColorFoundation.background.saHighlights,
          foregroundColor: ColorFoundation.text.saDark,
          loadingBackgroundColor: ColorFoundation.background.saDisabled,
          loadingForegroundColor: ColorFoundation.text.saTextDisabled,
          borderSide: BorderSide.none,
          borderRadius: s.radius,
          padding: s.padding,
          height: s.height,
          textStyle: TextStyle(
            fontFamily: StoycoFontFamilyToken.gilroy,
            fontWeight: FontWeight.w800,
            fontSize: s.fontSize,
          ),
        );

      case ButtonVariant.secondary:
        return ButtonStyleSpec(
          backgroundColor: ColorFoundation.background.saDark,
          foregroundColor: ColorFoundation.text.white,
          loadingBackgroundColor: ColorFoundation.background.saDisabled,
          loadingForegroundColor: ColorFoundation.text.saTextDisabled,
          borderSide: BorderSide.none,
          borderRadius: s.radius,
          padding: s.padding,
          height: s.height,
          textStyle: TextStyle(
            fontFamily: StoycoFontFamilyToken.gilroy,
            fontWeight: FontWeight.w700,
            fontSize: s.fontSize,
          ),
        );

      case ButtonVariant.outline:
        return ButtonStyleSpec(
          backgroundColor: Colors.transparent,
          foregroundColor: ColorFoundation.text.saDark,
          loadingBackgroundColor: ColorFoundation.background.grey5,
          loadingForegroundColor: ColorFoundation.text.saTextDisabled,
          borderSide: BorderSide(
            color: ColorFoundation.border.buttonPrimary,
            width: 1.5,
          ),
          borderRadius: s.radius,
          padding: s.padding,
          height: s.height,
          textStyle: TextStyle(
            fontFamily: StoycoFontFamilyToken.gilroy,
            fontWeight: FontWeight.w700,
            fontSize: s.fontSize,
          ),
        );

      case ButtonVariant.ghost:
        return ButtonStyleSpec(
          backgroundColor: Colors.transparent,
          foregroundColor: ColorFoundation.text.saDark.withOpacity(0.85),
          loadingBackgroundColor: ColorFoundation.background.grey5,
          loadingForegroundColor: ColorFoundation.text.saTextDisabled,
          borderSide: BorderSide.none,
          borderRadius: s.radius,
          padding: s.padding,
          height: s.height,
          textStyle: TextStyle(
            fontFamily: StoycoFontFamilyToken.gilroy,
            fontWeight: FontWeight.w700,
            fontSize: s.fontSize,
          ),
        );

      case ButtonVariant.destructive:
        return ButtonStyleSpec(
          backgroundColor: ColorFoundation.background.tertiary1,
          foregroundColor: ColorFoundation.text.white,
          loadingBackgroundColor: ColorFoundation.background.saDisabled,
          loadingForegroundColor: ColorFoundation.text.saTextDisabled,
          borderSide: BorderSide.none,
          borderRadius: s.radius,
          padding: s.padding,
          height: s.height,
          textStyle: TextStyle(
            fontFamily: StoycoFontFamilyToken.gilroy,
            fontWeight: FontWeight.w800,
            fontSize: s.fontSize,
          ),
        );
    }
  }
}
