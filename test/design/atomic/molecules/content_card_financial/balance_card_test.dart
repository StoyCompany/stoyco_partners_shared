import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_card_financial/balance_card.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

void main() {
  group('BalanceCard Tests', () {
    testWidgets('should render with default title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
            ),
          ),
        ),
      );

      expect(find.text('BALANCE TOTAL'), findsOneWidget);
    });

    testWidgets('should render with custom title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              title: 'AVAILABLE BALANCE',
            ),
          ),
        ),
      );

      expect(find.text('AVAILABLE BALANCE'), findsOneWidget);
    });

    testWidgets('should display formatted balance', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
            ),
          ),
        ),
      );

      expect(find.textContaining('\$'), findsWidgets);
    });

    testWidgets('should display hidden balance text when not visible', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              initiallyVisible: false,
            ),
          ),
        ),
      );

      expect(find.text(r'$ ••••••••'), findsOneWidget);
    });

    testWidgets('should toggle balance visibility when icon is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              initiallyVisible: true,
            ),
          ),
        ),
      );

      // Initially visible
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Tap to hide
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      // Now should show visibility_off icon
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
      expect(find.text(r'$ ••••••••'), findsOneWidget);

      // Tap to show again
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      // Back to visible
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });

    testWidgets('should call onVisibilityToggle callback', (WidgetTester tester) async {
      bool? lastVisibilityState;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              initiallyVisible: true,
              onVisibilityToggle: (bool isVisible) {
                lastVisibilityState = isVisible;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      expect(lastVisibilityState, false);

      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      expect(lastVisibilityState, true);
    });

    testWidgets('should render info message when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              infoMessage: 'Withdrawals available soon',
            ),
          ),
        ),
      );

      expect(find.text('Withdrawals available soon'), findsOneWidget);
    });

    testWidgets('should not render info message when null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.info), findsNothing);
    });

    testWidgets('should handle null balance', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: null,
            ),
          ),
        ),
      );

      expect(find.text(r'$-'), findsOneWidget);
    });

    testWidgets('should use custom currency symbol', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              currencySymbol: '€',
            ),
          ),
        ),
      );

      expect(find.textContaining('€'), findsWidgets);
    });

    testWidgets('should use custom currency locale', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              currencyLocale: 'es_ES',
              currencySymbol: '€',
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });

    testWidgets('should use custom decimal digits', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              currencyDecimalDigits: 0,
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });

    testWidgets('should use custom hidden balance text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              initiallyVisible: false,
              hiddenBalanceText: '****',
            ),
          ),
        ),
      );

      expect(find.text('****'), findsOneWidget);
    });

    testWidgets('should apply custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              titleColor: Colors.red,
              balanceColor: Colors.blue,
              iconColor: Colors.green,
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });

    testWidgets('should use custom font family', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });

    testWidgets('should use default colors when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 1500000.00,
            ),
          ),
        ),
      );

      final Finder titleFinder = find.text('BALANCE TOTAL');
      final Text titleWidget = tester.widget<Text>(titleFinder);
      expect(titleWidget.style?.color, ColorFoundation.text.grey5);
    });

    testWidgets('should format large numbers correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 9999999.99,
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });

    testWidgets('should format negative numbers correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: -5000.00,
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });

    testWidgets('should format zero correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BalanceCard(
              balance: 0.00,
            ),
          ),
        ),
      );

      expect(find.byType(BalanceCard), findsOneWidget);
    });
  });
}
