import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/buttons/content_switch_button.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

/// A row widget that displays a left label, the switch, and a right label.
/// The active label is highlighted with [highlightColor] depending on the switch state.
class ContentSwitchRow extends StatelessWidget {
  const ContentSwitchRow({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.value,
    this.onChanged,
    this.highlightColor,
    this.labelStyle,
    this.spacing,
    this.switchWidth = 56,
    this.switchHeight = 28,
    this.activeColor,
    this.inactiveColor,
    this.circleColor,
    this.duration = const Duration(milliseconds: 200),
  });
  final String leftLabel;
  final String rightLabel;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? highlightColor;
  final TextStyle? labelStyle;
  final double? spacing;
  final double? switchWidth;
  final double? switchHeight;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? circleColor;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = TextStyle(
      fontFamily: StoycoFontFamilyToken.gilroy,
      fontSize: StoycoScreenSize.fontSize(context, 15),
      fontWeight: FontWeight.w400,
      color: ColorFoundation.text.saLight,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          leftLabel,
          style: baseStyle.copyWith(
            color: !value
                ? highlightColor ?? ColorFoundation.text.saHighlights
                : baseStyle.color,
          ),
        ),
        Gutter(spacing ?? StoycoScreenSize.width(context, 10)),
        ContentSwitchButton(
          value: value,
          onChanged: onChanged,
          width: switchWidth ?? StoycoScreenSize.width(context, 56),
          height: switchHeight,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          circleColor: circleColor ?? ColorFoundation.background.saDark,
          duration: duration,
        ),
        Gutter(spacing ?? StoycoScreenSize.width(context, 10)),
        Text(
          rightLabel,
          style: baseStyle.copyWith(
            color: value
                ? highlightColor ?? ColorFoundation.text.saHighlights
                : baseStyle.color,
          ),
        ),
      ],
    );
  }
}
