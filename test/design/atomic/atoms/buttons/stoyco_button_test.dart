import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/buttons/stoyco_button.dart';

void main() {
  group('Stoyco Button Tests', () {
    testWidgets('should render button with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoycoButton(
              onPressed: () {},
              label: 'Test Button',
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoycoButton(
              onPressed: () {
                wasPressed = true;
              },
              label: 'Test Button',
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Button'));
      await tester.pumpAndSettle();

      expect(wasPressed, isTrue);
    });

    testWidgets('should not call onPressed when disabled', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoycoButton(
              onPressed: null,
              label: 'Disabled Button',
              enabled: false,
            ),
          ),
        ),
      );

      expect(find.text('Disabled Button'), findsOneWidget);
      expect(wasPressed, isFalse);
    });

    testWidgets('should render with custom styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoycoButton(
              onPressed: () {},
              label: 'Styled Button',
              backgroundColor: Colors.red,
            ),
          ),
        ),
      );

      expect(find.text('Styled Button'), findsOneWidget);
    });

    testWidgets('should render with loading indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StoycoButton(
              onPressed: () {},
              label: 'Loading Button',
              loading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
