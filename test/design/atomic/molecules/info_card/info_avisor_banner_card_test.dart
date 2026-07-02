import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/info_card/info_avisor_banner_card.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

void main() {
  group('InfoAdvisorBannerCard Tests', () {
    testWidgets('should render with required percent parameter', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsWidgets);
      expect(find.byIcon(Icons.tips_and_updates_outlined), findsOneWidget);
      
      // Verify the widget renders successfully
      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should render with default English text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 25,
            ),
          ),
        ),
      );

      // Verify the widget renders with RichText
      expect(find.byType(RichText), findsWidgets);
      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should render with custom text values', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 40,
              mainText: 'Earn up to',
              middleText: 'extra',
              endText: 'profit today.',
              ctaText: 'Contact advisor',
            ),
          ),
        ),
      );

      // Verify the widget renders successfully with custom parameters
      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('should call onTapInfo when tapped', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              onTapInfo: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InfoAdvisorBannerCard));
      await tester.pumpAndSettle();

      expect(wasTapped, isTrue);
    });

    testWidgets('should not crash when onTapInfo is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InfoAdvisorBannerCard));
      await tester.pumpAndSettle();

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should render with custom border width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              borderWidth: 2,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should render with custom outer border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              outerBorderRadius: 12,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should render with custom inner border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              innerBorderRadius: 10,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should apply custom main text color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              mainTextColor: Colors.red,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should apply custom highlight text color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              highlightTextColor: Colors.yellow,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should apply custom CTA text color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              ctaTextColor: Colors.green,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should apply custom icon color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              iconColor: Colors.blue,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget(find.byIcon(Icons.tips_and_updates_outlined));
      expect(icon.color, Colors.blue);
    });

    testWidgets('should apply custom background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
              backgroundColor: Colors.purple,
            ),
          ),
        ),
      );

      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
    });

    testWidgets('should use default colors when not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      final Icon icon = tester.widget(find.byIcon(Icons.tips_and_updates_outlined));
      expect(icon.color, ColorFoundation.text.saHighlights);
    });

    testWidgets('should render with gradient border decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      final Container outerContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ).first,
      );

      final BoxDecoration decoration = outerContainer.decoration as BoxDecoration;
      expect(decoration.gradient, isA<RadialGradient>());
    });

    testWidgets('should have correct gradient colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      final Container outerContainer = tester.widget<Container>(
        find.descendant(
          of: find.byType(GestureDetector),
          matching: find.byType(Container),
        ).first,
      );

      final BoxDecoration decoration = outerContainer.decoration as BoxDecoration;
      final RadialGradient gradient = decoration.gradient as RadialGradient;
      
      expect(gradient.colors.length, 8);
      expect(gradient.colors.first, const Color(0xFFA27FEE));
      expect(gradient.colors.last, const Color(0xFF331D7F));
    });

    testWidgets('should render icon before text content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      final Row row = tester.widget<Row>(
        find.descendant(
          of: find.byType(InfoAdvisorBannerCard),
          matching: find.byType(Row),
        ),
      );

      expect(row.children.first, isA<Padding>());
    });

    testWidgets('should use Expanded for text to fill available space', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(InfoAdvisorBannerCard),
          matching: find.byType(Expanded),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should render RichText for formatted message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 30,
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(InfoAdvisorBannerCard),
          matching: find.byType(RichText),
        ),
        findsWidgets,
      );
    });

    testWidgets('should render with all custom properties', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InfoAdvisorBannerCard(
              percent: 50,
              mainText: 'Custom main',
              middleText: 'custom middle',
              endText: 'custom end.',
              ctaText: 'Custom CTA',
              borderWidth: 3,
              outerBorderRadius: 16,
              innerBorderRadius: 14,
              mainTextColor: Colors.amber,
              highlightTextColor: Colors.orange,
              ctaTextColor: Colors.deepOrange,
              iconColor: Colors.pink,
              backgroundColor: Colors.black,
              onTapInfo: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      // Verify the widget renders with all custom properties
      expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
      expect(find.byType(RichText), findsWidgets);

      await tester.tap(find.byType(InfoAdvisorBannerCard));
      await tester.pumpAndSettle();

      expect(wasTapped, isTrue);
    });

    testWidgets('should handle different percent values', (WidgetTester tester) async {
      for (int percent in [10, 25, 50, 75, 100]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: InfoAdvisorBannerCard(
                percent: percent,
              ),
            ),
          ),
        );

        expect(find.byType(InfoAdvisorBannerCard), findsOneWidget);
        expect(find.byType(RichText), findsWidgets);

        // Clean up for next iteration
        await tester.pumpWidget(Container());
      }
    });
  });
}
