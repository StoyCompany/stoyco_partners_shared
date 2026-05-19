import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

/// Atomic form field variant with dynamic character counter and error display below.
/// 
/// A reusable reactive form field designed for cases where:
/// - Dynamic character counter is needed (shows "Max. X" when empty, "X/Y" when typing)
/// - Error messages should appear below the field with an icon
/// - Custom error styling is configurable
/// 
/// Similar to CustomFormField but with specific counter/error UI patterns.
/// Use this variant when you need these specific features, otherwise use CustomFormField.
class CounterFormField extends StatelessWidget {
  const CounterFormField({
    required this.formControlName,
    required this.label,
    required this.maxLength,
    this.validationMessages,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.maxLines = 1,
    this.readOnly = false,
    this.textColor,
    this.labelColor,
    this.errorColor,
    this.counterColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.maxCounterText = 'Max.',
    this.charactersText = 'caracteres',
    this.defaultRequiredMessage = 'Este campo es requerido',
    this.defaultMinLengthMessage = 'Mínimo',
    this.defaultMaxLengthMessage = 'Máximo',
    super.key,
  });

  final String formControlName;
  final String label;
  final int maxLength;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final int maxLines;
  final bool readOnly;
  
  // Customizable colors
  final Color? textColor;
  final Color? labelColor;
  final Color? errorColor;
  final Color? counterColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  
  // Customizable texts
  final String maxCounterText;
  final String charactersText;
  final String defaultRequiredMessage;
  final String defaultMinLengthMessage;
  final String defaultMaxLengthMessage;

  @override
  Widget build(BuildContext context) {
    // Default colors
    final Color effectiveTextColor = textColor ?? ColorFoundation.text.white;
    final Color effectiveLabelColor = labelColor ?? ColorFoundation.text.white;
    final Color effectiveErrorColor = errorColor ?? ColorFoundation.text.saError;
    final Color effectiveCounterColor = counterColor ?? ColorFoundation.text.saLight;
    final Color effectiveFocusedBorderColor = focusedBorderColor ?? ColorFoundation.text.saHighlights;
    final Color effectiveEnabledBorderColor = enabledBorderColor ?? ColorFoundation.text.white;
    
    return ReactiveFormField<String, String>(
      formControlName: formControlName,
      builder: (ReactiveFormFieldState<String, String> field) {
        final FormControl<String> control = field.control;
        final String currentValue = control.value ?? '';
        final int currentLength = currentValue.length;
        
        // Dynamic counter text
        final String counterText = currentLength == 0
            ? '$maxCounterText $maxLength $charactersText'
            : '$currentLength/$maxLength';
        
        // Get error message using validationMessages if provided
        String? errorMessage;
        if (control.hasErrors && control.touched) {
          if (validationMessages != null) {
            // Use custom validation messages
            final String firstErrorKey = control.errors.keys.first;
            final ValidationMessageFunction? messageFunction = 
                validationMessages![firstErrorKey];
            if (messageFunction != null) {
              final Object errorValue = control.errors[firstErrorKey] as Object;
              errorMessage = messageFunction(errorValue);
            }
          } else {
            // Default error messages
            final Map<String, dynamic> errors = control.errors;
            if (errors.containsKey('required')) {
              errorMessage = defaultRequiredMessage;
            } else if (errors.containsKey('minLength')) {
              final Map<String, dynamic>? minLengthError = 
                  errors['minLength'] as Map<String, dynamic>?;
              final int? minLength = minLengthError?['requiredLength'] as int?;
              errorMessage = minLength != null 
                  ? '$defaultMinLengthMessage $minLength $charactersText'
                  : '$defaultMinLengthMessage 3 $charactersText';
            } else if (errors.containsKey('maxLength')) {
              errorMessage = '$defaultMaxLengthMessage $maxLength $charactersText';
            }
          }
        }
        
        final bool hasError = errorMessage != null;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ReactiveTextField<String>(
              formControlName: formControlName,
              keyboardType: keyboardType ?? TextInputType.text,
              textInputAction: textInputAction,
              autofocus: autofocus,
              maxLines: maxLines,
              maxLength: maxLength,
              readOnly: readOnly,
              showErrors: (_) => false,
              style: TextStyle(
                color: effectiveTextColor,
                fontFamily: 'Gilroy',
                fontSize: StoycoScreenSize.fontSize(context, 14),
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: TextStyle(
                  color: hasError ? effectiveErrorColor : effectiveLabelColor,
                  fontFamily: 'Gilroy',
                  fontSize: StoycoScreenSize.fontSize(context, 13),
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
                counterText: counterText,
                counterStyle: TextStyle(
                  color: effectiveCounterColor,
                  fontFamily: 'Gilroy',
                  fontSize: StoycoScreenSize.fontSize(context, 10),
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: hasError ? effectiveErrorColor : effectiveEnabledBorderColor,
                    width: 2,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: hasError ? effectiveErrorColor : effectiveFocusedBorderColor,
                    width: 2,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: effectiveErrorColor,
                    width: 2,
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: effectiveErrorColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            if (hasError) ...<Widget>[
              SizedBox(height: StoycoScreenSize.height(context, 6)),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    size: StoycoScreenSize.width(context, 14),
                    color: effectiveErrorColor,
                  ),
                  SizedBox(width: StoycoScreenSize.width(context, 6)),
                  Flexible(
                    child: Text(
                      errorMessage,
                      style: TextStyle(
                        color: effectiveErrorColor,
                        fontFamily: 'Gilroy',
                        fontSize: StoycoScreenSize.fontSize(context, 12),
                        fontWeight: FontWeight.w400,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
