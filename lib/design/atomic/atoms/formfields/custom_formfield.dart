import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

/// A custom reactive text form field for Stoyco Partners.
///
/// This widget extends [ReactiveTextField] and provides consistent styling
/// across the application. It's designed to work exclusively with reactive_forms.
class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.formControlName,
    this.placeholder,
    this.isPassword = false,
    this.validationMessages,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.focusNode,
    this.maxLength,
    this.maxLines = 1,
    this.underlineColor,
    this.focusedUnderlineColor,
    this.errorUnderlineColor,
    this.textColor,
    this.placeholderColor,
    this.iconColor,
    this.prefixText,
    this.prefixStyle,
    this.onTap,
    this.readOnly = false,
    this.decoration,
  });

  final String formControlName;
  final String? placeholder;
  final bool isPassword;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLength;
  final int maxLines;
  final Color? underlineColor;
  final Color? focusedUnderlineColor;
  final Color? errorUnderlineColor;
  final Color? textColor;
  final Color? placeholderColor;
  final Color? iconColor;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final ReactiveFormFieldCallback? onTap;
  final bool readOnly;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<String, String>(
      formControlName: formControlName,
      builder: (field) {
        final control = field.control;
        final hasError = control.hasErrors && control.touched;

        return isPassword
            ? _PasswordField(
                formControlName: formControlName,
                validationMessages: validationMessages,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                textInputAction: textInputAction,
                autofocus: autofocus,
                focusNode: focusNode,
                maxLength: maxLength,
                onTap: onTap,
                readOnly: readOnly,
                hasError: hasError,
                textColor: textColor,
                placeholder: placeholder,
                placeholderColor: placeholderColor,
                underlineColor: underlineColor,
                focusedUnderlineColor: focusedUnderlineColor,
                errorUnderlineColor: errorUnderlineColor,
                iconColor: iconColor,
                prefixText: prefixText,
                prefixStyle: prefixStyle,
                decoration: decoration,
              )
            : ReactiveTextField<String>(
                formControlName: formControlName,
                validationMessages: validationMessages,
                keyboardType: keyboardType ?? TextInputType.text,
                maxLines: maxLines,
                obscureText: false,
                inputFormatters: inputFormatters,
                textInputAction: textInputAction,
                autofocus: autofocus,
                focusNode: focusNode,
                maxLength: maxLength,
                onTap: onTap,
                readOnly: readOnly,
                style: FontFoundation.label.semiBold14SaDark.copyWith(
                  color: hasError
                      ? ColorFoundation.text.saError
                      : (textColor ?? ColorFoundation.text.saDark),
                ),
                decoration:
                    decoration ??
                    InputDecoration(
                      contentPadding: prefixText != null
                          ? const EdgeInsets.only(left: 4, top: 10)
                          : null,
                      hintText: placeholder,
                      hintStyle: placeholderColor != null
                          ? FontFoundation.label.medium14SaDark.copyWith(
                              color: placeholderColor,
                            )
                          : FontFoundation.label.medium14SaDark,
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
                          color:
                              errorUnderlineColor ??
                              ColorFoundation.text.saError,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              errorUnderlineColor ??
                              ColorFoundation.text.saError,
                          width: 2,
                        ),
                      ),
                      errorStyle: FontFoundation.label.semiBold12SaError,
                      errorMaxLines: 2,
                      prefixText: prefixText,
                      prefixStyle:
                          prefixStyle ?? FontFoundation.label.medium14SaDark,
                    ),
              );
      },
    );
  }
}

/// Internal widget to handle password field with visibility toggle
class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.formControlName,
    required this.hasError,
    this.validationMessages,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.focusNode,
    this.maxLength,
    this.onTap,
    this.readOnly = false,
    this.textColor,
    this.placeholder,
    this.placeholderColor,
    this.underlineColor,
    this.focusedUnderlineColor,
    this.errorUnderlineColor,
    this.iconColor,
    this.prefixText,
    this.prefixStyle,
    this.decoration,
  });

  final String formControlName;
  final bool hasError;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLength;
  final ReactiveFormFieldCallback? onTap;
  final bool readOnly;
  final Color? textColor;
  final String? placeholder;
  final Color? placeholderColor;
  final Color? underlineColor;
  final Color? focusedUnderlineColor;
  final Color? errorUnderlineColor;
  final Color? iconColor;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final InputDecoration? decoration;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
      maxLines: 1,
      obscureText: _obscureText,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      maxLength: widget.maxLength,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      style: FontFoundation.label.semiBold14SaDark.copyWith(
        color: widget.hasError
            ? ColorFoundation.text.saError
            : (widget.textColor ?? ColorFoundation.text.saDark),
      ),
      decoration:
          widget.decoration ??
          InputDecoration(
            contentPadding: widget.prefixText != null
                ? const EdgeInsets.only(left: 4, top: 10)
                : const EdgeInsets.symmetric(vertical: 12),
            hintText: widget.placeholder,
            hintStyle: widget.placeholderColor != null
                ? FontFoundation.label.medium14SaDark.copyWith(
                    color: widget.placeholderColor,
                  )
                : FontFoundation.label.medium14SaDark,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: widget.underlineColor ?? ColorFoundation.text.saDark,
                width: 2,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:
                    widget.focusedUnderlineColor ??
                    widget.underlineColor ??
                    ColorFoundation.text.saDark,
                width: 2,
              ),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:
                    widget.errorUnderlineColor ?? ColorFoundation.text.saError,
                width: 2,
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:
                    widget.errorUnderlineColor ?? ColorFoundation.text.saError,
                width: 2,
              ),
            ),
            errorStyle: FontFoundation.label.semiBold12SaError,
            errorMaxLines: 2,
            prefixText: widget.prefixText,
            prefixStyle:
                widget.prefixStyle ?? FontFoundation.label.medium14SaDark,
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                size: 24,
                color: widget.iconColor ?? ColorFoundation.text.saDark,
              ),
              onPressed: () {
                setState(() => _obscureText = !_obscureText);
              },
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 40,
            ),
          ),
    );
  }
}
