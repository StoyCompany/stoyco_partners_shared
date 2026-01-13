import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/models/phone_number_model.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class CountryCodeSelector extends StatefulWidget {
  const CountryCodeSelector({
    super.key,
    required this.formControlName,
    this.initialCountryCode = 'MX',
    this.phonePlaceholder,
    this.underlineColor,
    this.focusedUnderlineColor,
    this.textColor,
    this.validationMessages,
  });

  final String formControlName;
  final String initialCountryCode;
  final String? phonePlaceholder;
  final Color? underlineColor;
  final Color? focusedUnderlineColor;
  final Color? textColor;
  final Map<String, ValidationMessageFunction>? validationMessages;

  @override
  State<CountryCodeSelector> createState() => _CountryCodeSelectorState();
}

class _CountryCodeSelectorState extends State<CountryCodeSelector> {
  bool _isExpanded = false;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _rowKey = GlobalKey();
  double _dropdownWidth = 0;

  @override
  void initState() {
    super.initState();

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
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _focusNode.requestFocus();
        _updateDropdownWidth();
      }
    });
  }

  Country _getCountryFromControl(FormControl<PhoneNumber?> control) {
    final phoneNumber = control.value;
    if (phoneNumber?.selectedCountry != null) {
      return phoneNumber!.selectedCountry!;
    }
    return countries.firstWhere(
      (country) => country.code == widget.initialCountryCode,
      orElse: () => countries.first,
    );
  }

  void _selectCountry(Country country, FormControl<PhoneNumber?> control) {
    final currentPhoneNumber = control.value;
    final newPhoneNumber = PhoneNumber(
      selectedCountry: country,
      number: currentPhoneNumber?.number,
    );
    control.value = newPhoneNumber;

    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormField<PhoneNumber?, PhoneNumber>(
      formControlName: widget.formControlName,
      builder: (field) {
        final control = field.control;
        final selectedCountry = _getCountryFromControl(control);
        final hasError = control.hasErrors && control.touched;

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
                  _buildCountrySelector(selectedCountry, control, hasError),
                  Gutter(10),
                  // Phone Number Field
                  Expanded(
                    child: _PhoneNumberInput(
                      control: control,
                      selectedCountry: selectedCountry,
                      placeholder: widget.phonePlaceholder ?? 'Phone number',
                      underlineColor: widget.underlineColor,
                      focusedUnderlineColor: widget.focusedUnderlineColor,
                      textColor: widget.textColor,
                    ),
                  ),
                ],
              ),
              // Validation Error
              if (hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 12),
                  child: Text(
                    control.errors.entries.first.key,
                    style: TextStyle(
                      color: ColorFoundation.text.saError,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              // Dropdown List
              if (_isExpanded && _dropdownWidth > 0)
                _buildDropdownList(selectedCountry, control),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountrySelector(
    Country selectedCountry,
    FormControl<PhoneNumber?> control,
    bool hasError,
  ) {
    final Color baseUnderline =
        widget.underlineColor ?? ColorFoundation.text.saDark;
    final Color baseFocusedUnderline =
        widget.focusedUnderlineColor ?? ColorFoundation.text.saDark;
    final Color baseTextColor = widget.textColor ?? ColorFoundation.text.saDark;
    final Color errorColor = ColorFoundation.text.saError;

    final Color currentUnderlineColor = hasError
        ? errorColor
        : (_isExpanded ? baseFocusedUnderline : baseUnderline);

    final isEnabled = control.enabled;

    return SizedBox(
      width: 66,
      child: GestureDetector(
        onTap: isEnabled ? _toggleDropdown : null,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isEnabled
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
                  selectedCountry.flag,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: isEnabled
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

  Widget _buildDropdownList(
    Country selectedCountry,
    FormControl<PhoneNumber?> control,
  ) {
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
            final isSelected = country.code == selectedCountry.code;

            return InkWell(
              onTap: () => _selectCountry(country, control),
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

/// Internal reactive widget for phone number input
class _PhoneNumberInput extends StatefulWidget {
  const _PhoneNumberInput({
    required this.control,
    required this.selectedCountry,
    required this.placeholder,
    this.underlineColor,
    this.focusedUnderlineColor,
    this.textColor,
  });

  final FormControl<PhoneNumber?> control;
  final Country selectedCountry;
  final String placeholder;
  final Color? underlineColor;
  final Color? focusedUnderlineColor;
  final Color? textColor;

  @override
  State<_PhoneNumberInput> createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<_PhoneNumberInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.control.value?.number ?? '',
    );
    _focusNode = FocusNode();

    // Listen to form control changes
    widget.control.valueChanges.listen((phoneNumber) {
      final newNumber = phoneNumber?.number ?? '';
      if (_controller.text != newNumber) {
        _controller.text = newNumber;
      }
    });

    // Listen to text changes
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    final currentPhoneNumber = widget.control.value;
    final newPhoneNumber = PhoneNumber(
      selectedCountry: widget.selectedCountry,
      number: _controller.text,
    );

    // Only update if the value actually changed
    if (currentPhoneNumber?.number != _controller.text) {
      widget.control.value = newPhoneNumber;
    }
  }

  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      widget.control.markAsTouched();
    }
  }

  @override
  void didUpdateWidget(_PhoneNumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update phone number with new country if it changed
    if (oldWidget.selectedCountry.code != widget.selectedCountry.code) {
      final newPhoneNumber = PhoneNumber(
        selectedCountry: widget.selectedCountry,
        number: _controller.text,
      );
      widget.control.value = newPhoneNumber;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.control.enabled;
    final hasError = widget.control.hasErrors && widget.control.touched;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Prefix Container
        Container(
          padding: const EdgeInsets.only(bottom: 13),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: hasError
                    ? ColorFoundation.text.saError
                    : (widget.underlineColor ?? ColorFoundation.text.saDark),
                width: 2,
              ),
            ),
          ),
          child: Text(
            '(+${widget.selectedCountry.dialCode}) ',
            style: TextStyle(
              color: isEnabled
                  ? (widget.textColor ?? ColorFoundation.text.saDark)
                  : (widget.textColor ?? ColorFoundation.text.grey1)
                        .withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        // TextField
        Expanded(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            enabled: isEnabled,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: widget.textColor ?? ColorFoundation.text.saDark,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 4),
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                color: widget.textColor ?? ColorFoundation.text.saDark,
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
                  color: ColorFoundation.text.saError,
                  width: 2,
                ),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorFoundation.text.saError,
                  width: 2,
                ),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: (widget.underlineColor ?? ColorFoundation.text.saDark)
                      .withOpacity(0.5),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
