import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.formControlName,
    required this.label,
    this.checkboxSize = 20,
    this.labelStyle,
    this.activeColor,
    this.inactiveColor,
    this.borderColor,
    this.checkColor,
    this.spacing = 10,
    this.validationMessages,
  });

  final String formControlName;
  final String label;
  final double checkboxSize;
  final TextStyle? labelStyle;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? borderColor;
  final Color? checkColor;
  final double spacing;
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTap(FormControl<bool?> control) {
    if (control.enabled) {
      final currentValue = control.value ?? false;
      control.value = !currentValue;
      control.markAsTouched();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<bool?, bool>(
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      builder: (field) {
        final control = field.control;
        final value = control.value ?? false;
        final hasError = control.hasErrors && control.touched;
        final isEnabled = control.enabled;

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

        return Focus(
          focusNode: _focusNode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => _handleTap(control),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Checkbox
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: widget.checkboxSize,
                      height: widget.checkboxSize,
                      decoration: BoxDecoration(
                        color: value
                            ? effectiveActiveColor
                            : effectiveInactiveColor,
                        border: Border.all(
                          color: hasError
                              ? ColorFoundation.text.saError
                              : (isEnabled
                                    ? effectiveBorderColor
                                    : effectiveBorderColor.withOpacity(0.5)),
                          width: hasError ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: value
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
                        style: isEnabled
                            ? effectiveLabelStyle
                            : effectiveLabelStyle.copyWith(
                                color: ColorFoundation.text.saTextDisabled,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // Validation Error
            ],
          ),
        );
      },
    );
  }
}
