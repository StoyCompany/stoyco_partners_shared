import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

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
    this.showErrors = true,
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
  final ReactiveFormFieldCallback<dynamic>? onTap;
  final bool readOnly;
  final InputDecoration? decoration;
  final bool showErrors; // Add this field

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<String, String>(
      formControlName: formControlName,
      builder: (ReactiveFormFieldState<String, String> field) {
        final FormControl<String> control = field.control;
        final bool hasError =
            showErrors && control.hasErrors && control.touched; // Modified

        // Get the current error message
        final String? errorMessage =
            showErrors &&
                control.hasErrors &&
                control
                    .touched // Modified
            ? control.errors.entries.first.value?.toString()
            : null;
        final bool isEmptyError = errorMessage?.isEmpty ?? false;

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
                isEmptyError: isEmptyError,
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
                showErrors: showErrors, // Pass to password field
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
                showErrors: (FormControl<String> control) =>
                    showErrors && control.touched, // Add this line
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w600,
                  fontSize: StoycoScreenSize.fontSize(context, 14),
                  color: hasError
                      ? ColorFoundation.text.saError
                      : (textColor ?? ColorFoundation.text.saDark),
                ),
                decoration:
                    decoration ??
                    InputDecoration(
                      contentPadding: prefixText != null
                          ? StoycoScreenSize.fromLTRB(context, left: 4, top: 10)
                          : null,
                      hintText: placeholder,
                      hintStyle: TextStyle(
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.w500,
                        fontSize: StoycoScreenSize.fontSize(context, 14),
                        color: placeholderColor ?? ColorFoundation.text.saDark,
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
                      errorStyle: isEmptyError
                          ? const TextStyle(height: 0, fontSize: 0)
                          : TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: StoycoScreenSize.fontSize(context, 12),
                              color: ColorFoundation.text.saError,
                            ),
                      errorMaxLines: 2,
                      prefixText: prefixText,
                      prefixStyle:
                          prefixStyle ??
                          TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w500,
                            fontSize: StoycoScreenSize.fontSize(context, 14),
                            color: ColorFoundation.text.saDark,
                          ),
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
    required this.isEmptyError,
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
    this.showErrors = true,
  });

  final String formControlName;
  final bool hasError;
  final bool isEmptyError;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final int? maxLength;
  final ReactiveFormFieldCallback<dynamic>? onTap;
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
  final bool showErrors;

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
      showErrors: (FormControl<String> control) =>
          widget.showErrors && control.touched,
      style: TextStyle(
        fontFamily: 'Gilroy',
        fontWeight: FontWeight.w600,
        fontSize: StoycoScreenSize.fontSize(context, 14),
        color: widget.hasError
            ? ColorFoundation.text.saError
            : (widget.textColor ?? ColorFoundation.text.saDark),
      ),
      decoration:
          widget.decoration ??
          InputDecoration(
            contentPadding: widget.prefixText != null
                ? StoycoScreenSize.fromLTRB(context, left: 4, top: 10)
                : StoycoScreenSize.symmetric(context, vertical: 12),
            hintText: widget.placeholder,
            hintStyle: TextStyle(
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w500,
              fontSize: StoycoScreenSize.fontSize(context, 14),
              color: widget.placeholderColor ?? ColorFoundation.text.saDark,
            ),
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
            errorStyle: widget.isEmptyError
                ? const TextStyle(height: 0, fontSize: 0)
                : TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: StoycoScreenSize.fontSize(context, 12),
                    color: ColorFoundation.text.saError,
                  ),
            errorMaxLines: 2,
            prefixText: widget.prefixText,
            prefixStyle:
                widget.prefixStyle ??
                TextStyle(
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.w500,
                  fontSize: StoycoScreenSize.fontSize(context, 14),
                  color: ColorFoundation.text.saDark,
                ),
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                size: StoycoScreenSize.fontSize(context, 24),
                color: widget.iconColor ?? ColorFoundation.text.saDark,
              ),
              onPressed: () {
                setState(() => _obscureText = !_obscureText);
              },
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: StoycoScreenSize.width(context, 40),
              minHeight: StoycoScreenSize.height(context, 40),
            ),
          ),
    );
  }
}
