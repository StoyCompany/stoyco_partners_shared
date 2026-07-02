import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/atomic/molecules/content_card_financial/not_result_block_card.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

void main() {
  group('NoResultsBlockCard Tests', () {
    testWidgets('should render with default title and retry text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(),
          ),
        ),
      );

      // Verify widget renders
      expect(find.byType(NoResultsBlockCard), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
      expect(find.byType(OutlinedButton), findsNothing); // Button should not be visible without onRetry
    });

    testWidgets('should render with custom title and retry text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              title: 'No data available',
              retryText: 'Try again',
              onRetry: () async {},
            ),
          ),
        ),
      );

      expect(find.text('No data available'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
    });

    testWidgets('should show retry button when onRetry is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              onRetry: () async {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(NoResultsBlockCard), findsOneWidget);
    });

    testWidgets('should not show retry button when onRetry is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsNothing);
    });

    testWidgets('should call onRetry when retry button is tapped', (WidgetTester tester) async {
      bool wasCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              onRetry: () async {
                wasCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      expect(wasCalled, isTrue);
    });

    testWidgets('should render with custom icon size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              sizeIcon: 50,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
    });

    testWidgets('should render with custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              titleColor: Colors.red,
              iconColor: Colors.blue,
              buttonTextColor: Colors.green,
              buttonBorderColor: Colors.yellow,
              onRetry: () async {},
            ),
          ),
        ),
      );

      expect(find.byType(NoResultsBlockCard), findsOneWidget);
    });

    testWidgets('should render with custom font family', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              fontFamily: StoycoFontFamilyToken.apercu,
              onRetry: () async {},
            ),
          ),
        ),
      );

      expect(find.byType(NoResultsBlockCard), findsOneWidget);
    });

    testWidgets('should render with custom button border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(
              buttonBorderRadius: 24,
              onRetry: () async {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('should render icon with correct default color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NoResultsBlockCard(),
          ),
        ),
      );

      final Icon icon = tester.widget(find.byIcon(Icons.cloud_off_outlined));
      expect(icon.color, ColorFoundation.text.saTextDisabled);
    });

    testWidgets('should handle long titles with ellipsis', (WidgetTester tester) async {
      const String longTitle = 'This is a very long title that should be truncated with ellipsis when it exceeds the maximum number of lines allowed';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: NoResultsBlockCard(
                title: longTitle,
              ),
            ),
          ),
        ),
      );

      final Text textWidget = tester.widget(find.text(longTitle));
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });
  });
}
