import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CustomSearchDropdownfield extends StatefulWidget {
  const CustomSearchDropdownfield({
    super.key,
    this.selectedValue,
    required this.items,
    required this.onChanged,
    this.placeholderStyle,
    this.selectedStyle,
    this.placeholder = 'Elegir un opción',
    this.searchPlaceholder = 'Buscar...',
    this.noResultsText = 'No se encontraron resultados',
  });

  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final String placeholder;
  final String searchPlaceholder;
  final String noResultsText;

  final TextStyle? placeholderStyle;
  final TextStyle? selectedStyle;

  @override
  State<CustomSearchDropdownfield> createState() =>
      _CustomSearchDropdownfieldState();
}

class _CustomSearchDropdownfieldState extends State<CustomSearchDropdownfield> {
  var isOpened = false;
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
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

  bool get _isPlaceholder => widget.selectedValue == null;

  String get _displayText => widget.selectedValue ?? widget.placeholder;

  TextStyle get _textStyle {
    if (_isPlaceholder) {
      return widget.placeholderStyle ?? FontFoundation.label.medium14SaLight;
    }
    return widget.selectedStyle ?? FontFoundation.label.medium14SaDark;
  }

  void _toggleDropdown() {
    setState(() {
      isOpened = !isOpened;
      if (isOpened) {
        _searchController.clear();
        _filteredItems = widget.items;
      }
    });
  }

  void _selectItem(String item) {
    setState(() {
      isOpened = false;
    });
    if (widget.onChanged != null) {
      widget.onChanged!(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
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
                // Search bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                          onTap: () => _selectItem(item),
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
                Gutter(10),
              ],
            ),
          ),
      ],
    );
  }
}
