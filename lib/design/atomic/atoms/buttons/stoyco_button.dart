import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/button_tokens.dart';
import 'custom_button.dart';

class StoycoButton extends StatelessWidget {
  const StoycoButton({
    super.key,
    required this.onPressed,
    this.label,
    this.child,
    this.leading,
    this.trailing,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.md,
    this.fullWidth = false,
    this.loading = false,
    this.loadingLabel = 'Procesando',
    this.enabled = true,
    this.elevation,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.semanticsLabel,
    this.maxLines,

    // Optional overrides
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.loadingBackgroundColor,
    this.loadingForegroundColor,
    this.borderSide,
    this.borderRadius,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
  }) : assert(
         child != null || label != null,
         'Provide either a child or a label',
       );

  final VoidCallback? onPressed;
  final String? label;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;

  final ButtonVariant variant;
  final ButtonSize size;

  final bool fullWidth;
  final bool loading;
  final String loadingLabel;
  final bool enabled;
  final double? elevation;
  final bool autofocus;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final String? semanticsLabel;
  final int? maxLines;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? loadingBackgroundColor;
  final Color? loadingForegroundColor;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  const StoycoButton.primary({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    ButtonSize size = ButtonSize.md,
    bool fullWidth = false,
    bool loading = false,
    String loadingLabel = 'Procesando',
    bool enabled = true,
    double? elevation,
    int? maxLines,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    String? semanticsLabel,
    bool autofocus = false,
    Widget? leading,
    Widget? trailing,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? loadingBackgroundColor,
    Color? loadingForegroundColor,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) : this(
         key: key,
         onPressed: onPressed,
         label: label,
         child: child,
         size: size,
         variant: ButtonVariant.primary,
         fullWidth: fullWidth,
         loading: loading,
         loadingLabel: loadingLabel,
         enabled: enabled,
         elevation: elevation,
         maxLines: maxLines,
         mouseCursor: mouseCursor,
         focusNode: focusNode,
         semanticsLabel: semanticsLabel,
         autofocus: autofocus,
         leading: leading,
         trailing: trailing,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         disabledBackgroundColor: disabledBackgroundColor,
         disabledForegroundColor: disabledForegroundColor,
         loadingBackgroundColor: loadingBackgroundColor,
         loadingForegroundColor: loadingForegroundColor,
         borderSide: borderSide,
         borderRadius: borderRadius,
         padding: padding,
         width: width,
         height: height,
         textStyle: textStyle,
       );

  const StoycoButton.secondary({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    ButtonSize size = ButtonSize.md,
    bool fullWidth = false,
    bool loading = false,
    String loadingLabel = 'Procesando',
    bool enabled = true,
    double? elevation,
    int? maxLines,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    String? semanticsLabel,
    bool autofocus = false,
    Widget? leading,
    Widget? trailing,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? loadingBackgroundColor,
    Color? loadingForegroundColor,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) : this(
         key: key,
         onPressed: onPressed,
         label: label,
         child: child,
         size: size,
         variant: ButtonVariant.secondary,
         fullWidth: fullWidth,
         loading: loading,
         loadingLabel: loadingLabel,
         enabled: enabled,
         elevation: elevation,
         maxLines: maxLines,
         mouseCursor: mouseCursor,
         focusNode: focusNode,
         semanticsLabel: semanticsLabel,
         autofocus: autofocus,
         leading: leading,
         trailing: trailing,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         disabledBackgroundColor: disabledBackgroundColor,
         disabledForegroundColor: disabledForegroundColor,
         loadingBackgroundColor: loadingBackgroundColor,
         loadingForegroundColor: loadingForegroundColor,
         borderSide: borderSide,
         borderRadius: borderRadius,
         padding: padding,
         width: width,
         height: height,
         textStyle: textStyle,
       );

  const StoycoButton.outline({
    Key? key,
    required VoidCallback? onPressed,
    String? label,
    Widget? child,
    ButtonSize size = ButtonSize.md,
    bool fullWidth = false,
    bool loading = false,
    String loadingLabel = 'Procesando',
    bool enabled = true,
    double? elevation,
    int? maxLines,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    String? semanticsLabel,
    bool autofocus = false,
    Widget? leading,
    Widget? trailing,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? loadingBackgroundColor,
    Color? loadingForegroundColor,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    TextStyle? textStyle,
  }) : this(
         key: key,
         onPressed: onPressed,
         label: label,
         child: child,
         size: size,
         variant: ButtonVariant.outline,
         fullWidth: fullWidth,
         loading: loading,
         loadingLabel: loadingLabel,
         enabled: enabled,
         elevation: elevation,
         maxLines: maxLines,
         mouseCursor: mouseCursor,
         focusNode: focusNode,
         semanticsLabel: semanticsLabel,
         autofocus: autofocus,
         leading: leading,
         trailing: trailing,
         backgroundColor: backgroundColor,
         foregroundColor: foregroundColor,
         disabledBackgroundColor: disabledBackgroundColor,
         disabledForegroundColor: disabledForegroundColor,
         loadingBackgroundColor: loadingBackgroundColor,
         loadingForegroundColor: loadingForegroundColor,
         borderSide: borderSide,
         borderRadius: borderRadius,
         padding: padding,
         width: width,
         height: height,
         textStyle: textStyle,
       );

  @override
  Widget build(BuildContext context) {
    final tokens = ButtonTokens.resolve(variant, size);

    Color customDisabledBackgroundColor = ColorFoundation.background.saDisabled;
    Color customDisabledForegroundColor = ColorFoundation.text.saTextDisabled;

    final effectiveBackgroundColor = loading
        ? (loadingBackgroundColor ??
              tokens.loadingBackgroundColor ??
              tokens.backgroundColor)
        : (backgroundColor ?? tokens.backgroundColor);

    final effectiveForegroundColor = loading
        ? (loadingForegroundColor ??
              tokens.loadingForegroundColor ??
              tokens.foregroundColor)
        : (foregroundColor ?? tokens.foregroundColor);

    return CustomButton(
      onPressed: (loading || !enabled) ? null : onPressed,
      label: loading ? loadingLabel : label,
      leading: leading,
      trailing: trailing,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      disabledBackgroundColor:
          disabledBackgroundColor ?? customDisabledBackgroundColor,
      disabledForegroundColor:
          disabledForegroundColor ?? customDisabledForegroundColor,
      borderSide: borderSide ?? tokens.borderSide,
      borderRadius: borderRadius ?? tokens.borderRadius,
      padding: padding ?? tokens.padding,
      width: width,
      height: height ?? tokens.height,
      fullWidth: fullWidth,
      loading: loading,
      elevation: elevation,
      autofocus: autofocus,
      focusNode: focusNode,
      mouseCursor: mouseCursor,
      semanticsLabel: semanticsLabel ?? label,
      textStyle: (textStyle ?? tokens.textStyle),
      maxLines: maxLines,
      child: child,
    );
  }
}
