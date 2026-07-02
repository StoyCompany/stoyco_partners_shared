import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/info_card/info_pill_card.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

void main() {
  group('InfoPillCard Tests', () {
    testWidgets('should render with message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Test message',
            ),
          ),
        ),
      );

      expect(find.text('Test message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('should render with long message', (WidgetTester tester) async {
      const String longMessage = 'This is a very long informational message that should wrap or truncate appropriately within the card layout';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: longMessage,
            ),
          ),
        ),
      );

      expect(find.text(longMessage), findsOneWidget);
    });

    testWidgets('should handle message with ellipsis for overflow', (WidgetTester tester) async {
      const String longMessage = 'This is a very long informational message that should wrap or truncate appropriately within the card layout';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: InfoPillCard(
                message: longMessage,
              ),
            ),
          ),
        ),
      );

      final Text textWidget = tester.widget(find.text(longMessage));
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('should use default colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Default colors',
            ),
          ),
        ),
      );

      final Icon icon = tester.widget(find.byIcon(Icons.info));
      expect(icon.color, ColorFoundation.text.saHighlights);
    });

    testWidgets('should apply custom icon color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom icon color',
              iconColor: Colors.red,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget(find.byIcon(Icons.info));
      expect(icon.color, Colors.red);
    });

    testWidgets('should apply custom text color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom text color',
              textColor: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byType(InfoPillCard), findsOneWidget);
    });

    testWidgets('should apply custom border color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom border',
              borderColor: Colors.green,
            ),
          ),
        ),
      );

      expect(find.byType(InfoPillCard), findsOneWidget);
    });

    testWidgets('should apply custom background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom background',
              backgroundColor: Colors.yellow,
            ),
          ),
        ),
      );

      expect(find.byType(InfoPillCard), findsOneWidget);
    });

    testWidgets('should use custom font size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom font size',
              fontSize: 18,
            ),
          ),
        ),
      );

      expect(find.text('Custom font size'), findsOneWidget);
    });

    testWidgets('should use custom font family', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom font family',
              fontFamily: StoycoFontFamilyToken.apercu,
            ),
          ),
        ),
      );

      expect(find.text('Custom font family'), findsOneWidget);
    });

    testWidgets('should use custom border width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom border width',
              borderWidth: 2,
            ),
          ),
        ),
      );

      expect(find.byType(InfoPillCard), findsOneWidget);
    });

    testWidgets('should use custom border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Custom border radius',
              borderRadius: 16,
            ),
          ),
        ),
      );

      expect(find.byType(InfoPillCard), findsOneWidget);
    });

    testWidgets('should render with all custom properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'All custom',
              iconColor: Colors.purple,
              textColor: Colors.orange,
              borderColor: Colors.pink,
              backgroundColor: Colors.teal.withValues(alpha: 0.2),
              fontSize: 16,
              fontFamily: StoycoFontFamilyToken.akkurat,
              borderWidth: 2,
              borderRadius: 12,
            ),
          ),
        ),
      );

      expect(find.text('All custom'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('should have full width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Full width test',
            ),
          ),
        ),
      );

      final Container container = tester.widget<Container>(
        find.descendant(
          of: find.byType(InfoPillCard),
          matching: find.byType(Container),
        ).first,
      );

      expect(container.constraints?.maxWidth, double.infinity);
    });

    testWidgets('should render info icon before text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Icon position test',
            ),
          ),
        ),
      );

      final Row row = tester.widget<Row>(
        find.descendant(
          of: find.byType(InfoPillCard),
          matching: find.byType(Row),
        ),
      );

      expect(row.children.first, isA<Icon>());
    });

    testWidgets('should use Expanded for text to fill available space', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoPillCard(
              message: 'Expanded text test',
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(InfoPillCard),
          matching: find.byType(Expanded),
        ),
        findsOneWidget,
      );
    });
  });
}
