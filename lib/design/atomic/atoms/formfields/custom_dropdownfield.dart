//Todo: add params for styling
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CustomDropdownField extends StatefulWidget {
  const CustomDropdownField({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    this.placeholder = 'Elegir un opción',
  });

  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final String placeholder;

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  var isOpened = false;

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
                  color: ColorFoundation.border.saLight,
                  width: 2,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.selectedValue ?? widget.placeholder,
                  style: FontFoundation.label.medium14SaLight,
                ),
                Icon(
                  isOpened
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        isOpened
            ? Container(
                width: double.infinity,
                color: ColorFoundation.background.saLight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...widget.items.map((item) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isOpened = false;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(item);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          child: Text(
                            item,
                            style: FontFoundation.label.medium14SaDark,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
