import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/formfields/custom_formfield.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CountryCodeSelector extends StatefulWidget {
  const CountryCodeSelector({
    super.key,
    this.initialCountryCode = 'MX',
    this.onCountryChanged,
    this.phoneController,
    this.phonePlaceholder,
    this.phoneValidators = const [],
    this.onPhoneChanged,
    this.onPhoneFieldSubmitted,
    this.underlineColor,
    this.focusedUnderlineColor,
    this.textColor,
    this.enabled = true,
    this.autovalidateMode,
  });

  final String initialCountryCode;
  final ValueChanged<Country>? onCountryChanged;

  // Phone field properties
  final TextEditingController? phoneController;
  final String? phonePlaceholder;
  final List<FormFieldValidator<String>> phoneValidators;
  final ValueChanged<String>? onPhoneChanged;
  final ValueChanged<String>? onPhoneFieldSubmitted;

  // Shared styling
  final Color? underlineColor;
  final Color? focusedUnderlineColor;
  final Color? textColor;
  final bool enabled;
  final AutovalidateMode? autovalidateMode;

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  late Country _selectedCountry;
  bool _isExpanded = false;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _rowKey = GlobalKey();
  double _dropdownWidth = 0;

  @override
  void initState() {
    super.initState();
    _selectedCountry = countries.firstWhere(
      (country) => country.code == widget.initialCountryCode,
      orElse: () => countries.first,
    );

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isExpanded) {
        setState(() {
          _isExpanded = false;
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateDropdownWidth();
    });
  }

  void _updateDropdownWidth() {
    final RenderBox? renderBox =
        _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _dropdownWidth = renderBox.size.width;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _focusNode.requestFocus();
        _updateDropdownWidth();
      }
    });
  }

  void _selectCountry(Country country) {
    setState(() {
      _selectedCountry = country;
      _isExpanded = false;
    });
    widget.onCountryChanged?.call(country);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            key: _rowKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Country Code Selector
              _buildCountrySelector(),
              Gutter(10),
              // Phone Number Field
              Expanded(
                child: CustomFormField(
                  controller: widget.phoneController,
                  placeholder: widget.phonePlaceholder ?? 'Phone number',
                  keyboardType: TextInputType.phone,
                  validators: widget.phoneValidators,
                  onChanged: widget.onPhoneChanged,
                  onFieldSubmitted: widget.onPhoneFieldSubmitted,
                  enabled: widget.enabled,
                  underlineColor: widget.underlineColor,
                  focusedUnderlineColor: widget.focusedUnderlineColor,
                  textColor: widget.textColor,
                  autovalidateMode: widget.autovalidateMode,
                  prefixText: '(+${_selectedCountry.dialCode}) ',
                  prefixStyle: TextStyle(
                    color: widget.textColor ?? ColorFoundation.text.saDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          // Dropdown List
          if (_isExpanded && _dropdownWidth > 0) _buildDropdownList(),
        ],
      ),
    );
  }

  Widget _buildCountrySelector() {
    final Color baseUnderline =
        widget.underlineColor ?? ColorFoundation.text.saDark;
    final Color baseFocusedUnderline =
        widget.focusedUnderlineColor ?? ColorFoundation.text.saDark;
    final Color baseTextColor = widget.textColor ?? ColorFoundation.text.saDark;

    final Color currentUnderlineColor = _isExpanded
        ? baseFocusedUnderline
        : baseUnderline;

    return SizedBox(
      width: 66,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.enabled
                    ? currentUnderlineColor
                    : baseUnderline.withOpacity(0.5),
                width: 2,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _selectedCountry.flag,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: widget.enabled
                    ? baseTextColor
                    : baseTextColor.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownList() {
    return Container(
      width: _dropdownWidth,
      constraints: BoxConstraints(maxHeight: 200),
      margin: EdgeInsets.only(top: 4),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: ColorFoundation.background.saLight,
        border: Border(
          bottom: BorderSide(color: ColorFoundation.border.saDark, width: 2),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 4),
          itemCount: countries.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: ColorFoundation.border.saDark.withOpacity(0.2),
          ),
          itemBuilder: (context, index) {
            final country = countries[index];
            final isSelected = country.code == _selectedCountry.code;

            return InkWell(
              onTap: () => _selectCountry(country),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                color: isSelected
                    ? ColorFoundation.background.saHighlights.withOpacity(0.1)
                    : Colors.transparent,
                child: Row(
                  children: [
                    Text(country.flag, style: TextStyle(fontSize: 20)),
                    Gutter(12),
                    Expanded(
                      child: Text(
                        country.name,
                        style: FontFoundation.label.regularSaDark.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '+${country.dialCode}',
                      style: FontFoundation.paragraph.medium15SaDark,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
