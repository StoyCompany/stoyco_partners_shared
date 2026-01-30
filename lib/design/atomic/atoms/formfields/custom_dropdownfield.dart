import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.formControlName,
    required this.items,
    this.placeholderStyle,
    this.selectedStyle,
    this.placeholder = 'Elegir un opción',
    this.validationMessages,
  });

  final String formControlName;
  final List<String> items;
  final String placeholder;
  final TextStyle? placeholderStyle;
  final TextStyle? selectedStyle;
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  bool isOpened = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus && isOpened) {
      setState(() {
        isOpened = false;
      });
    }
  }

  void _toggleDropdown(FormControl<String?> control) {
    setState(() {
      isOpened = !isOpened;
      if (isOpened) {
        _focusNode.requestFocus();
      } else {
        control.markAsTouched();
      }
    });
  }

  void _selectItem(String item, FormControl<String?> control) {
    control.value = item;
    control.markAsTouched();
    setState(() {
      isOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<String?, String>(
      formControlName: widget.formControlName,
      validationMessages: widget.validationMessages,
      builder: (ReactiveFormFieldState<String?, String> field) {
        final FormControl<String?> control = field.control;
        final String? selectedValue = control.value;
        final bool hasError = control.hasErrors && control.touched;
        final bool isEnabled = control.enabled;

        final bool isPlaceholder = selectedValue == null;
        final String displayText = selectedValue ?? widget.placeholder;
        final TextStyle textStyle = isPlaceholder
            ? (widget.placeholderStyle ??
                  TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontSize: StoycoScreenSize.fontSize(context, 14),
                    fontWeight: FontWeight.w500,
                    color: ColorFoundation.text.saDark,
                  ))
            : (widget.selectedStyle ??
                  TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                      fontWeight: FontWeight.w600,
                      fontSize: StoycoScreenSize.fontSize(context, 14),
                      color: ColorFoundation.text.saDark,
                  ));

        return Focus(
          focusNode: _focusNode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: isEnabled ? () => _toggleDropdown(control) : null,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: hasError
                            ? ColorFoundation.text.saError
                            : ColorFoundation.border.saDark,
                        width: 2,
                      ),
                    ),
                  ),
                  padding: StoycoScreenSize.symmetric(context, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        displayText,
                        style: isEnabled
                            ? textStyle
                            : textStyle.copyWith(
                                fontFamily: StoycoFontFamilyToken.gilroy,
                                color: textStyle.color?.withOpacity(0.5),
                              ),
                      ),
                      Icon(
                        isOpened
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: isEnabled
                            ? ColorFoundation.text.saDark
                            : ColorFoundation.text.saDark.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
              if (hasError)
                Padding(
                  padding: StoycoScreenSize.fromLTRB(context, top: 4),
                  child: Text(
                    field.errorText ?? '',
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      color: ColorFoundation.text.saError,
                      fontSize: StoycoScreenSize.fontSize(context, 12),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (isOpened)
                Container(
                  width: double.infinity,
                  color: ColorFoundation.background.saLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ...widget.items.asMap().entries.map((
                        MapEntry<int, String> entry,
                      ) {
                        final int index = entry.key;
                        final String item = entry.value;
                        final bool isLast = index == widget.items.length - 1;

                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => _selectItem(item, control),
                              child: Container(
                                margin: StoycoScreenSize.fromLTRB(
                                  context,
                                  top: 10,
                                ),
                                padding: StoycoScreenSize.symmetric(
                                  context,
                                  horizontal: 8,
                                ),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontFamily: StoycoFontFamilyToken.gilroy,
                                    fontSize: StoycoScreenSize.fontSize(
                                      context,
                                      14,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    color: ColorFoundation.text.saDark,
                                  ),
                                ),
                              ),
                            ),
                            if (!isLast)
                              Gutter(StoycoScreenSize.height(context, 10)),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
