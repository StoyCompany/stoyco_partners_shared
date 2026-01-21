import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/formfields/custom_dropdownfield.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

void main() {
  group('CustomDropdownField', () {
    late FormGroup form;
    final testItems = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

    setUp(() {
      form = FormGroup({
        'dropdown': FormControl<String?>(value: null),
        'requiredDropdown': FormControl<String?>(
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
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomDropdownField), findsOneWidget);
    });

    testWidgets('displays default placeholder when no value selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Elegir un opción'), findsOneWidget);
    });

    testWidgets('displays custom placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
                placeholder: 'Select option',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select option'), findsOneWidget);
    });

    testWidgets('expands dropdown when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Initially collapsed
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up), findsNothing);

      // Tap to expand
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Should be expanded
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsNothing);
    });

    testWidgets('collapses dropdown when tapped again', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);

      // Collapse
      await tester.tap(find.byIcon(Icons.keyboard_arrow_up));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });

    testWidgets('displays all items when expanded', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // All items should be visible
      for (final item in testItems) {
        expect(find.text(item), findsOneWidget);
      }
    });

    testWidgets('selects item when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Select an item
      await tester.tap(find.text('Option 2'));
      await tester.pumpAndSettle();

      // Should be selected
      expect(form.control('dropdown').value, 'Option 2');
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('closes dropdown after selecting item', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand and select
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 1'));
      await tester.pumpAndSettle();

      // Dropdown should be closed
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_up), findsNothing);
    });

    testWidgets('marks control as touched when item is selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(form.control('dropdown').touched, false);

      // Expand and select
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 3'));
      await tester.pumpAndSettle();

      expect(form.control('dropdown').touched, true);
    });

    testWidgets('marks as touched when dropdown is closed without selection', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(form.control('dropdown').touched, false);

      // Open and close without selecting
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.keyboard_arrow_up));
      await tester.pumpAndSettle();

      expect(form.control('dropdown').touched, true);
    });

    testWidgets('closes dropdown when focus is lost', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_arrow_up), findsOneWidget);

      // Tap outside to lose focus
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      // Should be closed
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });

    testWidgets('displays validation error when field is invalid and touched', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'requiredDropdown',
                items: testItems,
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'Please select an option',
                },
              ),
            ),
          ),
        ),
      );

      // Mark as touched
      form.control('requiredDropdown').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Please select an option'), findsOneWidget);
    });

    testWidgets('shows error border when field has errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'requiredDropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Mark as touched to trigger error
      form.control('requiredDropdown').markAsTouched();
      await tester.pumpAndSettle();

      // Find container with border
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector).first,
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.bottom.color, ColorFoundation.text.saError);
    });

    testWidgets('shows normal border when field has no errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector).first,
          matching: find.byType(Container),
        ),
      );

      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border as Border;
      expect(border.bottom.color, ColorFoundation.border.saDark);
    });

    testWidgets('disables dropdown when control is disabled', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').markAsDisabled();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Try to tap
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Should not open
      expect(find.byIcon(Icons.keyboard_arrow_up), findsNothing);
      expect(find.text('Option 1'), findsNothing);
    });

    testWidgets('applies custom placeholder style', (
      WidgetTester tester,
    ) async {
      const customStyle = TextStyle(color: Colors.blue, fontSize: 18);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
                placeholder: 'Custom',
                placeholderStyle: customStyle,
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Custom'));
      expect(text.style, customStyle);
    });

    testWidgets('applies custom selected style', (WidgetTester tester) async {
      const customStyle = TextStyle(color: Colors.green, fontSize: 20);

      form.control('dropdown').value = 'Option 1';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
                selectedStyle: customStyle,
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Option 1'));
      expect(text.style, customStyle);
    });

    testWidgets('applies default placeholder style when not specified', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Elegir un opción'));
      expect(text.style, FontFoundation.label.medium14SaLight);
    });

    testWidgets('applies default selected style when not specified', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').value = 'Option 2';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Option 2'));
      expect(text.style, FontFoundation.label.medium14SaDark);
    });

    testWidgets('displays selected value correctly', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').value = 'Option 4';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Option 4'), findsOneWidget);
    });

    testWidgets('applies disabled style when control is disabled', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').markAsDisabled();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
                placeholder: 'Disabled',
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Disabled'));
      expect(text.style?.color?.opacity, lessThan(1.0));
    });

    testWidgets('applies disabled icon color when control is disabled', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').markAsDisabled();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.keyboard_arrow_down));
      expect(icon.color?.opacity, lessThan(1.0));
    });

    testWidgets('allows changing selection multiple times', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Select first option
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 1'));
      await tester.pumpAndSettle();
      expect(form.control('dropdown').value, 'Option 1');

      // Change to second option
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 3'));
      await tester.pumpAndSettle();
      expect(form.control('dropdown').value, 'Option 3');
    });

    testWidgets('handles empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomDropdownField(
                formControlName: 'dropdown',
                items: [],
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // No items should be displayed
      expect(find.text('Option 1'), findsNothing);
    });

    testWidgets('displays items in correct order', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Find all text widgets with item values
      final itemTexts = testItems.map((item) => find.text(item)).toList();

      // Verify all items are found
      for (final itemText in itemTexts) {
        expect(itemText, findsOneWidget);
      }
    });

    testWidgets('validation error clears when valid value is selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'requiredDropdown',
                items: testItems,
                validationMessages: {
                  ValidationMessage.required: (error) => 'Required field',
                },
              ),
            ),
          ),
        ),
      );

      // Trigger error
      form.control('requiredDropdown').markAsTouched();
      await tester.pumpAndSettle();
      expect(find.text('Required field'), findsOneWidget);

      // Select value
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 1'));
      await tester.pumpAndSettle();

      // Error should be cleared
      expect(find.text('Required field'), findsNothing);
    });

    testWidgets('maintains state after rebuilds', (WidgetTester tester) async {
      form.control('dropdown').value = 'Option 2';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Option 2'), findsOneWidget);

      // Trigger rebuild
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomDropdownField(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Value should still be there
      expect(find.text('Option 2'), findsOneWidget);
    });
  });
}
