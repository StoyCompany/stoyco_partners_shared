import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

typedef FormFieldValidator = String? Function(String? value);

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.placeholder,
    this.isPassword = false,
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
    this.autovalidateMode,
  }) : assert(
         controller == null || initialValue == null,
         'Provide either a controller or an initialValue, not both.',
       );

  final TextEditingController? controller;
  final String? initialValue;
  final String? placeholder;

  final bool isPassword;

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

  final AutovalidateMode? autovalidateMode;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscure;
  final ValueNotifier<bool> _hasError = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  void dispose() {
    _hasError.dispose();
    super.dispose();
  }

  String? _runValidators(String? value) {
    for (final validator in widget.validators) {
      final error = validator(value);
      if (error != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _hasError.value = true;
        });
        return error;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _hasError.value = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final errorColor = ColorFoundation.text.saError;

    final Color baseUnderline =
        widget.underlineColor ?? ColorFoundation.text.saDark;
    final Color baseFocusedUnderline =
        widget.focusedUnderlineColor ?? baseUnderline;
    final Color baseErrorUnderline = widget.errorUnderlineColor ?? errorColor;
    final Color baseTextColor = widget.textColor ?? ColorFoundation.text.saDark;
    final Color basePlaceholderColor =
        widget.placeholderColor ?? ColorFoundation.text.saDark;
    final Color baseIconColor = widget.iconColor ?? ColorFoundation.text.saDark;

    final underline = UnderlineInputBorder(
      borderSide: BorderSide(color: baseUnderline, width: 2),
    );
    final focusedUnderline = UnderlineInputBorder(
      borderSide: BorderSide(color: baseFocusedUnderline, width: 2),
    );
    final errorUnderline = UnderlineInputBorder(
      borderSide: BorderSide(color: baseErrorUnderline, width: 2),
    );

    return ValueListenableBuilder<bool>(
      valueListenable: _hasError,
      builder: (context, hasError, child) {
        final Color currentTextColor = hasError ? errorColor : baseTextColor;

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
          style: TextStyle(color: currentTextColor),
          validator: _runValidators,
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.onUserInteraction,
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
            errorStyle: TextStyle(
              color: errorColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            errorMaxLines: 2,
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
      },
    );
  }
}
