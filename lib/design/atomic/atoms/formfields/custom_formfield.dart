import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoyco_partners_shared/design/types/formfield_validator_type.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

typedef FormFieldValidator = String? Function(String? value);

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.placeholder,
    this.isPassword = false,
    this.validatorType = FormFieldValidatorType.none,
    this.validators = const [],
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.autofocus = false,
    this.focusNode,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
    this.underlineColor,
    this.focusedUnderlineColor,
    this.errorUnderlineColor,
    this.textColor,
    this.placeholderColor,
    this.iconColor,
  }) : assert(
         controller == null || initialValue == null,
         'Provide either a controller or an initialValue, not both.',
       );

  final TextEditingController? controller;
  final String? initialValue;
  final String? placeholder;

  final bool isPassword;

  final FormFieldValidatorType validatorType;
  final List<FormFieldValidator> validators;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  final bool autofocus;
  final FocusNode? focusNode;
  final bool enabled;

  final int? maxLength;
  final int maxLines;

  final Color? underlineColor;
  final Color? focusedUnderlineColor;
  final Color? errorUnderlineColor;
  final Color? textColor;
  final Color? placeholderColor;
  final Color? iconColor;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  String? _builtInValidator(String? value) {
    final v = value?.trim() ?? '';

    switch (widget.validatorType) {
      case FormFieldValidatorType.none:
        return null;

      case FormFieldValidatorType.email:
        final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
        if (v.isEmpty) return 'Este campo es requerido';
        if (!emailRegex.hasMatch(v)) return '*Favor ingresar un correo válido';
        return null;

      case FormFieldValidatorType.password:
        if (v.isEmpty) return 'Este campo es requerido';

        final lengthOK = v.length >= 8;
        final upperOK = v.contains(RegExp(r'[A-Z]'));
        final lowerOK = v.contains(RegExp(r'[a-z]'));
        final digitOK = v.contains(RegExp(r'\d'));
        if (!(lengthOK && upperOK && lowerOK && digitOK)) {
          return 'La contraseña debe tener 8+ caracteres, '
              'una mayúscula, una minúscula y un número';
        }
        return null;
    }
  }

  String? _runValidators(String? value) {
    final builtIn = _builtInValidator(value);
    if (builtIn != null) return builtIn;

    for (final validator in widget.validators) {
      final res = validator(value);
      if (res != null) return res;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final saDark = ColorFoundation.text.saDark;
    final errorColor = ColorFoundation.border.textFieldError;

    final Color baseUnderline = widget.underlineColor ?? saDark;
    final Color baseFocusedUnderline =
        widget.focusedUnderlineColor ?? baseUnderline;
    final Color baseErrorUnderline = widget.errorUnderlineColor ?? errorColor;
    final Color baseTextColor = widget.textColor ?? saDark;
    final Color basePlaceholderColor = widget.placeholderColor ?? saDark;
    final Color baseIconColor = widget.iconColor ?? saDark;

    final underline = UnderlineInputBorder(
      borderSide: BorderSide(color: baseUnderline, width: 2),
    );
    final focusedUnderline = UnderlineInputBorder(
      borderSide: BorderSide(color: baseFocusedUnderline, width: 2),
    );
    final errorUnderline = UnderlineInputBorder(
      borderSide: BorderSide(color: baseErrorUnderline, width: 2),
    );

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.controller == null ? widget.initialValue : null,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType:
          widget.keyboardType ??
          (widget.isPassword
              ? TextInputType.visiblePassword
              : TextInputType.text),
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      maxLength: widget.maxLength,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      obscureText: _obscure && widget.isPassword,
      style: TextStyle(color: baseTextColor),
      validator: _runValidators,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: TextStyle(
          color: basePlaceholderColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: underline,
        focusedBorder: focusedUnderline,
        errorBorder: errorUnderline,
        focusedErrorBorder: errorUnderline,
        suffixIcon: widget.isPassword
            ? IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  _obscure ? Icons.visibility_off : Icons.visibility,
                  color: baseIconColor,
                ),
                onPressed: !widget.enabled
                    ? null
                    : () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}
