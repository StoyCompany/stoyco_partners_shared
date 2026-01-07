import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    this.placeholderStyle,
    this.selectedStyle,
    this.placeholder = 'Elegir un opción',
  });

  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final String placeholder;

  final TextStyle? placeholderStyle;
  final TextStyle? selectedStyle;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  var isOpened = false;

  bool get _isPlaceholder => widget.selectedValue == null;

  String get _displayText => widget.selectedValue ?? widget.placeholder;

  TextStyle get _textStyle {
    if (_isPlaceholder) {
      return widget.placeholderStyle ?? FontFoundation.label.medium14SaLight;
    }
    return widget.selectedStyle ?? FontFoundation.label.medium14SaDark;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpened = !isOpened;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ColorFoundation.border.saDark,
                  width: 2,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_displayText, style: _textStyle),
                Icon(
                  isOpened
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        if (isOpened)
          Container(
            width: double.infinity,
            color: ColorFoundation.background.saLight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...widget.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isLast = index == widget.items.length - 1;

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isOpened = false;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(item);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            item,
                            style: FontFoundation.label.medium14SaDark,
                          ),
                        ),
                      ),
                      if (!isLast) Gutter(10),
                    ],
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}
