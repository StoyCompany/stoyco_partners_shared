import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/formfields/custom_formfield.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

void main() {
  group('CustomFormField', () {
    late FormGroup form;

    setUp(() {
      form = FormGroup({
        'testField': FormControl<String>(value: ''),
        'requiredField': FormControl<String>(
          value: '',
          validators: [Validators.required],
        ),
        'emailField': FormControl<String>(
          value: '',
          validators: [Validators.email],
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
              child: const CustomFormField(
                formControlName: 'testField',
                placeholder: 'Enter text',
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomFormField), findsOneWidget);
      expect(find.text('Enter text'), findsOneWidget);
    });

    testWidgets('displays placeholder text', (WidgetTester tester) async {
      const placeholderText = 'Test placeholder';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                placeholder: placeholderText,
              ),
            ),
          ),
        ),
      );

      expect(find.text(placeholderText), findsOneWidget);
    });

    testWidgets('accepts text input', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(formControlName: 'testField'),
            ),
          ),
        ),
      );

      const testInput = 'Hello World';
      await tester.enterText(find.byType(TextField), testInput);
      await tester.pump();

      expect(form.control('testField').value, testInput);
    });

    testWidgets('displays as password field when isPassword is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                isPassword: true,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('password field has visibility toggle', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                isPassword: true,
              ),
            ),
          ),
        ),
      );

      // Initially obscured
      var textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);

      // Find and tap visibility toggle
      final visibilityIcon = find.byIcon(Icons.visibility);
      expect(visibilityIcon, findsOneWidget);

      await tester.tap(visibilityIcon);
      await tester.pump();

      // Now visible
      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, false);

      // Icon should change to visibility_off
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('shows validation error when field is invalid and touched', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomFormField(
                formControlName: 'requiredField',
                validationMessages: {
                  'required': (error) => 'This field is required',
                },
              ),
            ),
          ),
        ),
      );

      // Touch the field
      await tester.tap(find.byType(TextField));
      await tester.pump();

      // Tap outside to lose focus
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      // Mark as touched
      form.control('requiredField').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('applies custom text color', (WidgetTester tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                textColor: customColor,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.style?.color, customColor);
    });

    testWidgets('applies custom placeholder color', (
      WidgetTester tester,
    ) async {
      const customColor = Colors.grey;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                placeholder: 'Test',
                placeholderColor: customColor,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.hintStyle?.color, customColor);
    });

    testWidgets('applies custom underline colors', (WidgetTester tester) async {
      const underlineColor = Colors.blue;
      const focusedColor = Colors.green;
      const errorColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                underlineColor: underlineColor,
                focusedUnderlineColor: focusedColor,
                errorUnderlineColor: errorColor,
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
      expect(focusedBorder.borderSide.color, focusedColor);

      final errorBorder = decoration.errorBorder as UnderlineInputBorder;
      expect(errorBorder.borderSide.color, errorColor);
    });

    testWidgets('respects maxLength property', (WidgetTester tester) async {
      const maxLength = 10;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                maxLength: maxLength,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLength, maxLength);
    });

    testWidgets('respects maxLines property', (WidgetTester tester) async {
      const maxLines = 3;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                maxLines: maxLines,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, maxLines);
    });

    testWidgets('applies input formatters', (WidgetTester tester) async {
      final formatters = [FilteringTextInputFormatter.digitsOnly];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomFormField(
                formControlName: 'testField',
                inputFormatters: formatters,
              ),
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'abc123def456');
      await tester.pump();

      expect(form.control('testField').value, '123456');
    });

    testWidgets('sets keyboard type', (WidgetTester tester) async {
      const keyboardType = TextInputType.emailAddress;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                keyboardType: keyboardType,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, keyboardType);
    });

    testWidgets('respects readOnly property', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                readOnly: true,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, true);
    });

    testWidgets('displays prefix text with custom style', (
      WidgetTester tester,
    ) async {
      const prefixText = '+1';
      const prefixStyle = TextStyle(color: Colors.blue, fontSize: 16);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                prefixText: prefixText,
                prefixStyle: prefixStyle,
              ),
            ),
          ),
        ),
      );

      expect(find.text(prefixText), findsOneWidget);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.prefixStyle, prefixStyle);
    });

    testWidgets('calls onTap callback when tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomFormField(
                formControlName: 'testField',
                onTap: (control) {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('applies autofocus', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                autofocus: true,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, true);
    });

    testWidgets('uses custom decoration when provided', (
      WidgetTester tester,
    ) async {
      const customDecoration = InputDecoration(
        labelText: 'Custom Label',
        border: OutlineInputBorder(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                decoration: customDecoration,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom Label'), findsOneWidget);
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.border, isA<OutlineInputBorder>());
    });

    testWidgets('shows error color when field has errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(formControlName: 'requiredField'),
            ),
          ),
        ),
      );

      // Touch the field
      form.control('requiredField').markAsTouched();
      await tester.pumpAndSettle();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.style?.color, ColorFoundation.text.saError);
    });

    testWidgets('applies text input action', (WidgetTester tester) async {
      const textInputAction = TextInputAction.done;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                textInputAction: textInputAction,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.textInputAction, textInputAction);
    });

    testWidgets('password field applies custom icon color', (
      WidgetTester tester,
    ) async {
      const iconColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomFormField(
                formControlName: 'testField',
                isPassword: true,
                iconColor: iconColor,
              ),
            ),
          ),
        ),
      );

      final iconButton = tester.widget<IconButton>(find.byType(IconButton));
      final icon = iconButton.icon as Icon;
      expect(icon.color, iconColor);
    });

    testWidgets('uses FocusNode when provided', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomFormField(
                formControlName: 'testField',
                focusNode: focusNode,
              ),
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.focusNode, focusNode);

      focusNode.dispose();
    });
  });
}
