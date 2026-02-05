import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

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
    this.emptyStateText = 'No hay elementos disponibles',
    this.validationMessages,
  });

  final String formControlName;
  final List<String> items;
  final String placeholder;
  final String searchPlaceholder;
  final String noResultsText;
  final String emptyStateText;
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
  List<String> _filteredItems = <String>[];

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
      builder: (ReactiveFormFieldState<String?, String> field) {
        final FormControl<String?> control = field.control;
        final String? selectedValue = control.value;
        final bool hasError = control.hasErrors && control.touched;
        final bool isEnabled = control.enabled;
        final bool isEmptyList = widget.items.isEmpty;

        final bool isPlaceholder = selectedValue == null;
        final String displayText = selectedValue ?? widget.placeholder;
        final TextStyle textStyle = isPlaceholder
            ? (widget.placeholderStyle ??
                  TextStyle(
                    fontFamily: StoycoFontFamilyToken.gilroy,
                    fontWeight: FontWeight.w500,
                    fontSize: StoycoScreenSize.fontSize(context, 14),
                    color: ColorFoundation.text.saLight,
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
                        color: !isEnabled
                            ? ColorFoundation.text.saTextDisabled
                            : hasError
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
                  padding: StoycoScreenSize.fromLTRB(context, top: 4),
                  child: Text(
                    field.errorText ?? '',
                    style: TextStyle(
                      fontFamily: StoycoFontFamilyToken.gilroy,
                      fontWeight: FontWeight.w600,
                      fontSize: StoycoScreenSize.fontSize(context, 12),
                      color: ColorFoundation.text.saError,
                    ),
                  ),
                ),
              if (isOpened)
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: StoycoScreenSize.height(context, 200),
                  ),
                  color: ColorFoundation.background.saLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Search bar - only show if items list is not empty
                      if (!isEmptyList)
                        Padding(
                          padding: StoycoScreenSize.symmetric(
                            context,
                            horizontal: 8,
                            vertical: 6,
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(
                              fontFamily: StoycoFontFamilyToken.gilroy,
                              fontWeight: FontWeight.w500,
                              fontSize: StoycoScreenSize.fontSize(context, 14),
                              color: ColorFoundation.text.saDark,
                            ),
                            decoration: InputDecoration(
                              hintText: widget.searchPlaceholder,
                              hintStyle: TextStyle(
                                fontFamily: StoycoFontFamilyToken.gilroy,
                                fontWeight: FontWeight.w500,
                                fontSize: StoycoScreenSize.fontSize(
                                  context,
                                  14,
                                ),
                                color: ColorFoundation.text.saLight,
                              ),
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
                              contentPadding: StoycoScreenSize.symmetric(
                                context,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      // Items list - now scrollable
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              if (isEmptyList)
                                Container(
                                  width: double.infinity,
                                  padding: StoycoScreenSize.symmetric(
                                    context,
                                    horizontal: 8,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    widget.emptyStateText,
                                    style: TextStyle(
                                      fontFamily: StoycoFontFamilyToken.gilroy,
                                      fontWeight: FontWeight.w500,
                                      fontSize: StoycoScreenSize.fontSize(
                                        context,
                                        14,
                                      ),
                                      color: ColorFoundation.text.saLight,
                                    ),
                                  ),
                                )
                              else if (_filteredItems.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: StoycoScreenSize.symmetric(
                                    context,
                                    horizontal: 8,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    widget.noResultsText,
                                    style: TextStyle(
                                      fontFamily: StoycoFontFamilyToken.gilroy,
                                      fontWeight: FontWeight.w500,
                                      fontSize: StoycoScreenSize.fontSize(
                                        context,
                                        14,
                                      ),
                                      color: ColorFoundation.text.saLight,
                                    ),
                                  ),
                                )
                              else
                                ..._filteredItems.asMap().entries.map((
                                  MapEntry<int, String> entry,
                                ) {
                                  final int index = entry.key;
                                  final String item = entry.value;
                                  final bool isLast =
                                      index == _filteredItems.length - 1;

                                  return Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () => _selectItem(item, control),
                                        child: Container(
                                          width: double.infinity,
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
                                              fontFamily:
                                                  StoycoFontFamilyToken.gilroy,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  StoycoScreenSize.fontSize(
                                                    context,
                                                    14,
                                                  ),
                                              color:
                                                  ColorFoundation.text.saDark,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (!isLast)
                                        Gutter(
                                          StoycoScreenSize.height(context, 10),
                                        ),
                                    ],
                                  );
                                }),
                              Gutter(StoycoScreenSize.height(context, 10)),
                            ],
                          ),
                        ),
                      ),
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
