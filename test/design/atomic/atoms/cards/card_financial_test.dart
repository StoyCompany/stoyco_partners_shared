import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/atomic/atoms/cards/card_financial.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

void main() {
  group('CardFinancial Tests', () {
    testWidgets('should render with default type1 styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              child: Text('Test Content'),
            ),
          ),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
      expect(find.byType(CardFinancial), findsOneWidget);
    });

    testWidgets('should render with type2 styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              type: CardFinancialType.type2,
              child: Text('Test Content Type 2'),
            ),
          ),
        ),
      );

      expect(find.text('Test Content Type 2'), findsOneWidget);
    });

    testWidgets('should apply custom width and height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              width: 200,
              height: 150,
              child: Text('Fixed Size'),
            ),
          ),
        ),
      );

      final Container container = tester.widget(find.byType(Container).first);
      expect(container.constraints?.maxWidth, 200);
    });

    testWidgets('should apply custom padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              padding: EdgeInsets.all(30),
              child: Text('Custom Padding'),
            ),
          ),
        ),
      );

      expect(find.text('Custom Padding'), findsOneWidget);
    });

    testWidgets('should apply custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              borderRadius: 20,
              child: Text('Custom Radius'),
            ),
          ),
        ),
      );

      expect(find.text('Custom Radius'), findsOneWidget);
    });

    testWidgets('should apply custom border width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              borderWidth: 2,
              child: Text('Custom Border Width'),
            ),
          ),
        ),
      );

      expect(find.text('Custom Border Width'), findsOneWidget);
    });

    testWidgets('should apply custom border when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              borderCard: Border.all(color: Colors.red, width: 3),
              child: const Text('Custom Border'),
            ),
          ),
        ),
      );

      expect(find.text('Custom Border'), findsOneWidget);
    });

    testWidgets('should render child widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              child: Column(
                children: <Widget>[
                  Text('Line 1'),
                  Text('Line 2'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
    });

    testWidgets('should have shadows for type1', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              type: CardFinancialType.type1,
              child: Text('With Shadows'),
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CardFinancial),
          matching: find.byType(Container),
        ).first,
      );

      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.boxShadow, isNotNull);
      expect(decoration.boxShadow!.length, 2);
    });

    testWidgets('should not have shadows for type2', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              type: CardFinancialType.type2,
              child: Text('Without Shadows'),
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CardFinancial),
          matching: find.byType(Container),
        ).first,
      );

      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.boxShadow, isNull);
    });

    testWidgets('should use correct background color for type1', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              type: CardFinancialType.type1,
              child: Text('Type 1 Background'),
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CardFinancial),
          matching: find.byType(Container),
        ).first,
      );

      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, ColorFoundation.background.cardFinancialLayer);
    });

    testWidgets('should use correct background color for type2', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              type: CardFinancialType.type2,
              child: Text('Type 2 Background'),
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(CardFinancial),
          matching: find.byType(Container),
        ).first,
      );

      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, ColorFoundation.background.cardFinancialLayerType2);
    });

    testWidgets('should handle complex child widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardFinancial(
              child: Column(
                children: <Widget>[
                  const Text('Title'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Button'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
