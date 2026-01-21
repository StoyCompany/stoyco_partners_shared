import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/formfields/country_code_selector.dart';
import 'package:stoyco_partners_shared/design/models/phone_number_model.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

void main() {
  group('CountryCodeSelector', () {
    late FormGroup form;

    setUp(() {
      form = FormGroup({
        'phone': FormControl<PhoneNumber?>(value: null),
        'requiredPhone': FormControl<PhoneNumber?>(
          value: null,
          validators: [Validators.required],
        ),
      });
    });

    testWidgets('renders with basic configuration', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      expect(find.byType(CountryCodeSelector), findsOneWidget);
      // Default country should be Mexico (MX)
      expect(find.text('🇲🇽'), findsOneWidget);
    });

    testWidgets('displays initial country code correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'US',
              ),
            ),
          ),
        ),
      );

      // Should display US flag
      expect(find.text('🇺🇸'), findsOneWidget);
    });

    testWidgets('displays custom phone placeholder', (
      WidgetTester tester,
    ) async {
      const placeholder = 'Enter your phone';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                phonePlaceholder: placeholder,
              ),
            ),
          ),
        ),
      );

      expect(find.text(placeholder), findsOneWidget);
    });

    testWidgets('accepts phone number input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      const testNumber = '1234567890';
      await tester.enterText(find.byType(TextField), testNumber);
      await tester.pump();

      final phoneNumber = form.control('phone').value as PhoneNumber?;
      expect(phoneNumber?.number, testNumber);
    });

    testWidgets('expands dropdown when country selector is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      // Initially not expanded
      expect(find.byType(InkWell), findsNothing);

      // Tap country selector
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Dropdown should be expanded
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('displays list of countries when expanded', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      // Tap to expand
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Should display ListView with countries
      expect(find.byType(ListView), findsOneWidget);
      // Check for visible countries (first few in the list)
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('selects country from dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'MX',
              ),
            ),
          ),
        ),
      );

      // Initially Mexico
      expect(find.text('🇲🇽'), findsOneWidget);

      // Tap to expand
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Find and select a country by scrolling through the list
      // We'll select the first visible country that's not Mexico
      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);

      // Tap the first InkWell (which should be Afghanistan - first in countries list)
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Should now show Afghanistan flag
      expect(find.text('🇦🇫'), findsOneWidget);
      expect(find.text('🇲🇽'), findsNothing);
    });

    testWidgets('updates phone number when country changes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'MX',
              ),
            ),
          ),
        ),
      );

      // Enter phone number
      await tester.enterText(find.byType(TextField), '1234567890');
      await tester.pump();

      // Change country
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Select first country in the list
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      final phoneNumber = form.control('phone').value as PhoneNumber?;
      expect(phoneNumber?.selectedCountry?.code, isNotNull);
      expect(phoneNumber?.number, '1234567890');
    });

    testWidgets('closes dropdown when focus is lost', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);

      // Tap outside to lose focus
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      // Dropdown should close
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up), findsNothing);
    });

    testWidgets('displays validation error when field is invalid and touched', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CountryCodeSelector(
                formControlName: 'requiredPhone',
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'Phone number is required',
                },
              ),
            ),
          ),
        ),
      );

      // Mark as touched without entering data
      form.control('requiredPhone').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Phone number is required'), findsOneWidget);
    });

    testWidgets('displays dial code prefix', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'US',
              ),
            ),
          ),
        ),
      );

      // Should display US dial code
      expect(find.textContaining('(+1)'), findsOneWidget);
    });

    testWidgets('updates dial code when country changes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'US',
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('(+1)'), findsOneWidget);

      // Change to first country (Afghanistan +93)
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      expect(find.textContaining('(+93)'), findsOneWidget);
    });

    testWidgets('applies custom text color', (WidgetTester tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                textColor: customColor,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.style?.color, customColor);
    });

    testWidgets('applies custom underline colors', (WidgetTester tester) async {
      const underlineColor = Colors.blue;
      const focusedColor = Colors.green;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                underlineColor: underlineColor,
                focusedUnderlineColor: focusedColor,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration!;

      final enabledBorder = decoration.enabledBorder as UnderlineInputBorder;
      expect(enabledBorder.borderSide.color, underlineColor);

      final focusedBorder = decoration.focusedBorder as UnderlineInputBorder;
      expect(focusedBorder.borderSide.color, underlineColor);
    });

    testWidgets('marks control as touched when phone field loses focus', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      final control = form.control('phone');
      expect(control.touched, false);

      // Focus then blur
      await tester.tap(find.byType(TextField));
      await tester.pump();
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      expect(control.touched, true);
    });

    testWidgets('preserves phone number when changing countries', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'MX',
              ),
            ),
          ),
        ),
      );

      const testNumber = '5551234567';

      // Enter number
      await tester.enterText(find.byType(TextField), testNumber);
      await tester.pump();

      // Change country
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();

      // Number should still be there
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, testNumber);
    });

    testWidgets('disables input when control is disabled', (
      WidgetTester tester,
    ) async {
      form.control('phone').markAsDisabled();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, false);
    });

    testWidgets('shows error border when field has errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'requiredPhone',
              ),
            ),
          ),
        ),
      );

      // Mark as touched to trigger error display
      form.control('requiredPhone').markAsTouched();
      await tester.pumpAndSettle();

      final textField = tester.widget<TextField>(find.byType(TextField));
      final errorBorder =
          textField.decoration?.errorBorder as UnderlineInputBorder;
      expect(errorBorder.borderSide.color, ColorFoundation.text.saError);
    });

    testWidgets('displays countries with flags and dial codes in dropdown', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Should have a ListView with countries
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets);
      // Flags should be visible (at least some)
      expect(find.text('🇦🇫'), findsOneWidget); // Afghanistan is first
    });

    testWidgets('highlights selected country in dropdown', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(
                formControlName: 'phone',
                initialCountryCode: 'US',
              ),
            ),
          ),
        ),
      );

      // Open dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Should have InkWells in the dropdown
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('handles initial PhoneNumber value correctly', (
      WidgetTester tester,
    ) async {
      final usCountry = countries.firstWhere((c) => c.code == 'US');
      final initialPhone = PhoneNumber(
        selectedCountry: usCountry,
        number: '5551234567',
      );

      form.control('phone').value = initialPhone;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      // Should show US flag and phone number
      expect(find.text('🇺🇸'), findsOneWidget);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, '5551234567');
    });

    testWidgets('keyboard type is set to phone', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CountryCodeSelector(formControlName: 'phone'),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.phone);
    });
  });
}
