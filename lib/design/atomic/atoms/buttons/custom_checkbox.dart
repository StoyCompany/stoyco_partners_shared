import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.label,
    this.value = false,
    this.onChanged,
    this.enabled = true,
    this.checkboxSize = 20,
    this.labelStyle,
    this.activeColor,
    this.inactiveColor,
    this.borderColor,
    this.checkColor,
    this.spacing = 10,
  });

  final String label;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final double checkboxSize;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? borderColor;
  final Color? checkColor;
  final double spacing;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  void _handleTap() {
    if (widget.enabled && widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveActiveColor =
        widget.activeColor ?? ColorFoundation.background.saHighlights;
    final Color effectiveInactiveColor =
        widget.inactiveColor ?? ColorFoundation.background.white;
    final Color effectiveBorderColor =
        widget.borderColor ?? ColorFoundation.border.saDark;
    final Color effectiveCheckColor =
        widget.checkColor ?? ColorFoundation.text.white;

    final TextStyle effectiveLabelStyle =
        widget.labelStyle ?? FontFoundation.label.regular14SaDark;

    return GestureDetector(
      onTap: _handleTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Checkbox
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.checkboxSize,
            height: widget.checkboxSize,
            decoration: BoxDecoration(
              color: widget.value
                  ? effectiveActiveColor
                  : effectiveInactiveColor,
              border: Border.all(
                color: widget.enabled
                    ? effectiveBorderColor
                    : effectiveBorderColor.withOpacity(0.5),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: widget.value
                ? Icon(
                    Icons.check,
                    size: widget.checkboxSize * 0.7,
                    color: effectiveCheckColor,
                  )
                : null,
          ),
          Gutter(widget.spacing),
          // Label
          Flexible(
            child: Text(
              widget.label,
              style: widget.enabled
                  ? effectiveLabelStyle
                  : effectiveLabelStyle.copyWith(
                      color: ColorFoundation.text.saTextDisabled,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
