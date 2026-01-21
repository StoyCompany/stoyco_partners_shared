import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CustomSearchDropdownfield extends StatefulWidget {
  const CustomSearchDropdownfield({
    super.key,
    required this.formControlName,
    required this.items,
    this.placeholderStyle,
    this.selectedStyle,
    this.placeholder = 'Elegir un opción',
    this.searchPlaceholder = 'Buscar...',
    this.noResultsText = 'No se encontraron resultados',
    this.validationMessages,
  });

  final String formControlName;
  final List<String> items;
  final String placeholder;
  final String searchPlaceholder;
  final String noResultsText;
  final TextStyle? placeholderStyle;
  final TextStyle? selectedStyle;
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  State<CustomSearchDropdownfield> createState() =>
      _CustomSearchDropdownfieldState();
}

class _CustomSearchDropdownfieldState extends State<CustomSearchDropdownfield> {
  var isOpened = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredItems = widget.items
          .where(
            (item) => item.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ),
          )
          .toList();
    });
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
        _searchController.clear();
        _filteredItems = widget.items;
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
      builder: (field) {
        final control = field.control;
        final selectedValue = control.value;
        final hasError = control.hasErrors && control.touched;
        final isEnabled = control.enabled;

        final bool isPlaceholder = selectedValue == null;
        final String displayText = selectedValue ?? widget.placeholder;
        final TextStyle textStyle = isPlaceholder
            ? (widget.placeholderStyle ?? FontFoundation.label.medium14SaLight)
            : (widget.selectedStyle ?? FontFoundation.label.medium14SaDark);

        return Focus(
          focusNode: _focusNode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayText,
                        style: isEnabled
                            ? textStyle
                            : textStyle.copyWith(
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
              // Validation Error
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    field.errorText ?? '',
                    style: FontFoundation.label.semiBold12SaError,
                  ),
                ),
              if (isOpened)
                Container(
                  width: double.infinity,
                  color: ColorFoundation.background.saLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search bar
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: FontFoundation.label.medium14SaDark,
                          decoration: InputDecoration(
                            hintText: widget.searchPlaceholder,
                            hintStyle: FontFoundation.label.medium14SaLight,
                            prefixIcon: Icon(
                              Icons.search,
                              color: ColorFoundation.border.saDark,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorFoundation.border.saDark,
                                width: 1,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorFoundation.border.saDark,
                                width: 1,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorFoundation.border.saDark,
                                width: 1,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      // Items list
                      if (_filteredItems.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 10,
                          ),
                          child: Text(
                            widget.noResultsText,
                            style: FontFoundation.label.medium14SaLight,
                          ),
                        )
                      else
                        ..._filteredItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isLast = index == _filteredItems.length - 1;

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () => _selectItem(item, control),
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    item,
                                    style:
                                        FontFoundation.label.semiBold14SaDark,
                                  ),
                                ),
                              ),
                              if (!isLast) Gutter(10),
                            ],
                          );
                        }),
                      Gutter(10),
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
