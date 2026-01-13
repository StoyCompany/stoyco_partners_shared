import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

/// A custom reactive text form field for Stoyco Partners.
///
/// This widget extends [ReactiveTextField] and provides consistent styling
/// across the application. It's designed to work exclusively with reactive_forms.
class CustomFormField extends ReactiveTextField<String> {
  CustomFormField({
    super.key,
    required String super.formControlName,
    String? placeholder,
    bool isPassword = false,
    super.validationMessages,
    TextInputType? keyboardType,
    super.inputFormatters,
    super.textInputAction,
    super.autofocus,
    super.focusNode,
    super.maxLength,
    int maxLines = 1,
    Color? underlineColor,
    Color? focusedUnderlineColor,
    Color? errorUnderlineColor,
    Color? textColor,
    Color? placeholderColor,
    Color? iconColor,
    String? prefixText,
    TextStyle? prefixStyle,
    super.onChanged,
    super.onSubmitted,
    ReactiveFormFieldCallback? super.onTap,
    super.readOnly,
    InputDecoration? decoration,
  }) : super(
         keyboardType:
             keyboardType ??
             (isPassword ? TextInputType.visiblePassword : TextInputType.text),
         maxLines: isPassword ? 1 : maxLines,
         obscureText: isPassword,
         style: TextStyle(
           color: textColor ?? ColorFoundation.text.saDark,
           fontSize: 14,
           fontWeight: FontWeight.w500,
         ),
         decoration:
             decoration ??
             InputDecoration(
               contentPadding: prefixText != null
                   ? const EdgeInsets.only(left: 4)
                   : null,
               hintText: placeholder,
               hintStyle: TextStyle(
                 color: placeholderColor ?? ColorFoundation.text.saDark,
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
               ),
               enabledBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                   color: underlineColor ?? ColorFoundation.text.saDark,
                   width: 2,
                 ),
               ),
               focusedBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                   color:
                       focusedUnderlineColor ??
                       underlineColor ??
                       ColorFoundation.text.saDark,
                   width: 2,
                 ),
               ),
               errorBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                   color: errorUnderlineColor ?? ColorFoundation.text.saError,
                   width: 2,
                 ),
               ),
               focusedErrorBorder: UnderlineInputBorder(
                 borderSide: BorderSide(
                   color: errorUnderlineColor ?? ColorFoundation.text.saError,
                   width: 2,
                 ),
               ),
               errorStyle: TextStyle(
                 color: ColorFoundation.text.saError,
                 fontSize: 12,
                 fontWeight: FontWeight.w400,
               ),
               errorMaxLines: 2,
               prefixText: prefixText,
               prefixStyle:
                   prefixStyle ??
                   TextStyle(
                     color: textColor ?? ColorFoundation.text.saDark,
                     fontSize: 14,
                     fontWeight: FontWeight.w500,
                   ),
               suffixIcon: isPassword ? _PasswordVisibilityToggle() : null,
             ),
       );
}

/// Internal widget to handle password visibility toggle
class _PasswordVisibilityToggle extends StatefulWidget {
  const _PasswordVisibilityToggle();

  @override
  State<_PasswordVisibilityToggle> createState() =>
      _PasswordVisibilityToggleState();
}

class _PasswordVisibilityToggleState extends State<_PasswordVisibilityToggle> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    // Get the parent ReactiveTextField to toggle obscureText
    final reactiveField = context
        .findAncestorStateOfType<ReactiveFormFieldState<String, String>>();

    return IconButton(
      visualDensity: VisualDensity.compact,
      icon: Icon(
        _obscure ? Icons.visibility_off : Icons.visibility,
        color: ColorFoundation.text.saDark,
      ),
      onPressed: reactiveField?.control.disabled ?? false
          ? null
          : () {
              setState(() => _obscure = !_obscure);
            },
    );
  }
}
