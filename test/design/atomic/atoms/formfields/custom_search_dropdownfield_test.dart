import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/formfields/custom_search_dropdownfield.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

void main() {
  group('CustomSearchDropdownfield', () {
    late FormGroup form;
    final testItems = ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'];

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
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CustomSearchDropdownfield), findsOneWidget);
    });

    testWidgets('displays placeholder text when no value selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: [],
                placeholder: 'Select an option',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select an option'), findsOneWidget);
    });

    testWidgets('displays custom placeholder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: [],
                placeholder: 'Custom placeholder',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Custom placeholder'), findsOneWidget);
    });

    testWidgets('expands dropdown when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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

    testWidgets('displays search field when expanded', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
                searchPlaceholder: 'Search items',
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      expect(find.text('Search items'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('displays all items when expanded', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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

    testWidgets('filters items based on search input', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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

      // Enter search text
      await tester.enterText(find.byType(TextField).last, 'ba');
      await tester.pumpAndSettle();

      // Only Banana should be visible
      expect(find.text('Banana'), findsOneWidget);
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Cherry'), findsNothing);
    });

    testWidgets('search is case insensitive', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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

      // Search with uppercase
      await tester.enterText(find.byType(TextField).last, 'APPLE');
      await tester.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('displays no results message when search has no matches', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
                noResultsText: 'Nothing found',
              ),
            ),
          ),
        ),
      );

      // Expand dropdown
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // Search for non-existent item
      await tester.enterText(find.byType(TextField).last, 'xyz');
      await tester.pumpAndSettle();

      expect(find.text('Nothing found'), findsOneWidget);
    });

    testWidgets('selects item when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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
      await tester.tap(find.text('Banana'));
      await tester.pumpAndSettle();

      // Should be selected and dropdown closed
      expect(form.control('dropdown').value, 'Banana');
      expect(find.text('Banana'), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });

    testWidgets('closes dropdown after selecting item', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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
      await tester.tap(find.text('Apple'));
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
              child: CustomSearchDropdownfield(
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
      await tester.tap(find.text('Cherry'));
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
              child: CustomSearchDropdownfield(
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

      // Tap outside
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
              child: CustomSearchDropdownfield(
                formControlName: 'requiredDropdown',
                items: testItems,
                validationMessages: {
                  ValidationMessage.required: (error) => 'Field is required',
                },
              ),
            ),
          ),
        ),
      );

      // Mark as touched
      form.control('requiredDropdown').markAsTouched();
      await tester.pumpAndSettle();

      expect(find.text('Field is required'), findsOneWidget);
    });

    testWidgets('shows error border when field has errors', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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

    testWidgets('disables dropdown when control is disabled', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').markAsDisabled();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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
              child: CustomSearchDropdownfield(
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

      form.control('dropdown').value = 'Apple';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
                selectedStyle: customStyle,
              ),
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Apple'));
      expect(text.style, customStyle);
    });

    testWidgets('clears search when dropdown is reopened', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Open and search
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'ban');
      await tester.pumpAndSettle();
      expect(find.text('Banana'), findsOneWidget);

      // Close
      await tester.tap(find.byIcon(Icons.keyboard_arrow_up));
      await tester.pumpAndSettle();

      // Reopen
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();

      // All items should be visible again
      for (final item in testItems) {
        expect(find.text(item), findsOneWidget);
      }
    });

    testWidgets('displays selected value correctly', (
      WidgetTester tester,
    ) async {
      form.control('dropdown').value = 'Cherry';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Cherry'), findsOneWidget);
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
              child: CustomSearchDropdownfield(
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

    testWidgets('handles empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: const CustomSearchDropdownfield(
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

      expect(find.text('No se encontraron resultados'), findsOneWidget);
    });

    testWidgets('search filters partial matches', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
                formControlName: 'dropdown',
                items: testItems,
              ),
            ),
          ),
        ),
      );

      // Expand and search
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'e');
      await tester.pumpAndSettle();

      // Items containing 'e'
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Cherry'), findsOneWidget);
      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Elderberry'), findsOneWidget);
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('marks as touched when dropdown is closed without selection', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReactiveForm(
              formGroup: form,
              child: CustomSearchDropdownfield(
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
  });
}
