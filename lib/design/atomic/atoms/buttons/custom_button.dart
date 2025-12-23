import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/layout.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.label,
    this.child,
    this.textStyle,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderSide,
    this.borderRadius,
    this.padding,
    this.width,
    this.height = 48,
    this.fullWidth = false,
    this.loading = false,
    this.elevation,
    this.autofocus = false,
    this.focusNode,
    this.mouseCursor,
    this.semanticsLabel,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.maxLines,
  }) : assert(
         child != null || label != null,
         'Provide either a child or a label',
       );

  final VoidCallback? onPressed;

  // Content
  final String? label;
  final Widget? child;
  final TextStyle? textStyle;
  final int? maxLines;
  final Widget? leading;
  final Widget? trailing;

  // Colors
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;

  // Shape / layout
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final bool fullWidth;
  final double? elevation;

  // State
  final bool loading;

  // Misc
  final bool autofocus;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final String? semanticsLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null && !loading;

    final ColorScheme colors = theme.colorScheme;
    final Color resolvedBg = (isDisabled
        ? (disabledBackgroundColor ?? theme.disabledColor.withOpacity(0.12))
        : (backgroundColor ?? colors.primary));
    final Color resolvedFg = (isDisabled
        ? (disabledForegroundColor ?? theme.disabledColor)
        : (foregroundColor ?? colors.onPrimary));

    final BorderRadius resolvedRadius =
        borderRadius ?? BorderRadius.circular(12);

    final EdgeInsetsGeometry resolvedPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    final TextStyle resolvedTextStyle =
        (textStyle ??
        theme.textTheme.labelLarge ??
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600));

    final Color finalTextColor = textStyle?.color ?? resolvedFg;

    final Widget content =
        child ??
        Text(label!, maxLines: maxLines ?? 1, overflow: TextOverflow.ellipsis);

    final Widget body = loading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 16,
                width: 16,
                child: CupertinoActivityIndicator(
                  color: finalTextColor,
                  radius: 12,
                ),
              ),
              Gutter(8),
              DefaultTextStyle(
                style: resolvedTextStyle.copyWith(color: finalTextColor),
                child: content,
              ),
            ],
          )
        : _buildContentRow(
            context: context,
            content: content,
            textStyle: resolvedTextStyle.copyWith(color: finalTextColor),
          );

    final shape = RoundedRectangleBorder(
      borderRadius: resolvedRadius,
      side: borderSide ?? BorderSide.none,
    );

    final button = AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      height: height,
      width: fullWidth ? double.infinity : width,
      decoration: ShapeDecoration(color: resolvedBg, shape: shape),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          autofocus: autofocus,
          focusNode: focusNode,
          borderRadius: resolvedRadius,
          mouseCursor: mouseCursor,
          onTap: (isDisabled || loading) ? null : onPressed,
          child: Padding(
            padding: resolvedPadding,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: animationDuration,
                curve: animationCurve,
                style: resolvedTextStyle.copyWith(color: finalTextColor),
                child: body,
              ),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      enabled: !isDisabled && !loading,
      label: semanticsLabel ?? label,
      child: elevation == null
          ? button
          : Material(
              elevation: elevation!,
              color: Colors.transparent,
              borderRadius: resolvedRadius,
              child: button,
            ),
    );
  }

  Widget _buildContentRow({
    required BuildContext context,
    required Widget content,
    required TextStyle textStyle,
  }) {
    final hasLeading = leading != null;
    final hasTrailing = trailing != null;

    if (!hasLeading && !hasTrailing) return content;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasLeading) ...[
          IconTheme.merge(
            data: IconThemeData(size: textStyle.fontSize ?? 16),
            child: leading!,
          ),
          Gutter(8),
        ],
        DefaultTextStyle(style: textStyle, child: content),
        if (hasTrailing) ...[
          Gutter(8),
          IconTheme.merge(
            data: IconThemeData(size: textStyle.fontSize ?? 16),
            child: trailing!,
          ),
        ],
      ],
    );
  }
}
