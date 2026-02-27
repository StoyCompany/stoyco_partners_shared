import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/material_format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

void main() {
  group('LayoutContext', () {
    test('should create with required parameters', () {
      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 2.0,
      );

      expect(context.size, const Size(800, 600));
      expect(context.width, 800);
      expect(context.breakpoint, LayoutBreakpoint.md);
      expect(context.devicePixelRatio, 2.0);
    });

    test('should use adaptive platform density by default', () {
      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );

      expect(context.visualDensity, VisualDensity.adaptivePlatformDensity);
    });

    test('should accept custom visual density', () {
      const customDensity = VisualDensity.compact;
      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
        visualDensity: customDensity,
      );

      expect(context.visualDensity, customDensity);
    });

    test('width getter should return size width', () {
      final context = LayoutContext(
        size: const Size(1024, 768),
        breakpoint: LayoutBreakpoint.lg,
        devicePixelRatio: 1.0,
      );

      expect(context.width, 1024);
    });
  });

  group('LayoutData', () {
    test('should create with all required parameters', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(1200, 800),
        devicePixelRatio: 2.0,
        visualDensity: VisualDensity.standard,
        margin: 24.0,
        format: format,
        gutter: 16.0,
        breakpoint: LayoutBreakpoint.lg,
        columns: 12,
        maxWidth: 960,
      );

      expect(layoutData.size, const Size(1200, 800));
      expect(layoutData.width, 1200);
      expect(layoutData.margin, 24.0);
      expect(layoutData.gutter, 16.0);
      expect(layoutData.breakpoint, LayoutBreakpoint.lg);
      expect(layoutData.columns, 12);
      expect(layoutData.maxWidth, 960);
      expect(layoutData.devicePixelRatio, 2.0);
      expect(layoutData.visualDensity, VisualDensity.standard);
      expect(layoutData.format, format);
    });

    test('should calculate fluidMargin correctly', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(1200, 800),
        devicePixelRatio: 1.0,
        visualDensity: VisualDensity.standard,
        margin: 24.0,
        format: format,
        gutter: 16.0,
        breakpoint: LayoutBreakpoint.lg,
        columns: 12,
        maxWidth: 960,
      );

      // fluidMargin = (1200 - 960) / 2 = 120
      expect(layoutData.fluidMargin, 120);
    });

    test('should calculate fullMargin correctly', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(1200, 800),
        devicePixelRatio: 1.0,
        visualDensity: VisualDensity.standard,
        margin: 24.0,
        format: format,
        gutter: 16.0,
        breakpoint: LayoutBreakpoint.lg,
        columns: 12,
        maxWidth: 960,
      );

      // fullMargin = fluidMargin + margin = 120 + 24 = 144
      expect(layoutData.fullMargin, 144);
    });

    test('should calculate horizontalMargin correctly', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(1200, 800),
        devicePixelRatio: 1.0,
        visualDensity: VisualDensity.standard,
        margin: 24.0,
        format: format,
        gutter: 16.0,
        breakpoint: LayoutBreakpoint.lg,
        columns: 12,
        maxWidth: 960,
      );

      expect(layoutData.horizontalMargin, const EdgeInsets.symmetric(horizontal: 144));
    });

    test('value method should resolve breakpoint values', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(1024, 768),
        devicePixelRatio: 1.0,
        visualDensity: VisualDensity.standard,
        margin: 24.0,
        format: format,
        gutter: 16.0,
        breakpoint: LayoutBreakpoint.md,
        columns: 12,
        maxWidth: 720,
      );

      final result = layoutData.value<String>(
        xs: 'extra small',
        sm: 'small',
        md: 'medium',
        lg: 'large',
        xl: 'extra large',
      );

      expect(result, 'medium');
    });

    test('resolve method should resolve layout values', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(600, 800),
        devicePixelRatio: 1.0,
        visualDensity: VisualDensity.standard,
        margin: 16.0,
        format: format,
        gutter: 12.0,
        breakpoint: LayoutBreakpoint.sm,
        columns: 8,
        maxWidth: 540,
      );

      final value = LayoutValue<int>(xs: 1, sm: 2, md: 3);
      final result = layoutData.resolve(value);

      expect(result, 2);
    });

    test('height getter should return size height', () {
      final format = MaterialLayoutFormat();
      final layoutData = LayoutData(
        size: const Size(800, 1200),
        devicePixelRatio: 1.0,
        visualDensity: VisualDensity.standard,
        margin: 24.0,
        format: format,
        gutter: 16.0,
        breakpoint: LayoutBreakpoint.sm,
        columns: 8,
        maxWidth: 540,
      );

      expect(layoutData.height, 1200);
    });
  });

  group('Layout Widget', () {
    testWidgets('should provide LayoutData to descendants', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Text('Breakpoint: ${layout.breakpoint}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Breakpoint:'), findsOneWidget);
    });

    testWidgets('should use MaterialFormat by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Text('Format: ${layout.format.runtimeType}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('MaterialLayoutFormat'), findsOneWidget);
    });

    testWidgets('should accept custom format', (tester) async {
      final customFormat = MaterialLayoutFormat(
        margin: const ConstantLayoutValue(32.0),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: customFormat,
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Text('Margin: ${layout.margin}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Margin: 32.0'), findsOneWidget);
    });

    testWidgets('should rebuild when size changes', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Text('Width: ${layout.width}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Width:'), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(800, 1200));
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Text('Width: ${layout.width}');
                },
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.textContaining('Width:'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('maybeOf should return null when no Layout ancestor', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final layout = Layout.maybeOf(context);
              return Text('Layout: ${layout == null ? "null" : "found"}');
            },
          ),
        ),
      );

      expect(find.text('Layout: null'), findsOneWidget);
    });

    testWidgets('maybeOf should return LayoutData when Layout exists', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.maybeOf(context);
                  return Text('Layout: ${layout == null ? "null" : "found"}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Layout: found'), findsOneWidget);
    });

    testWidgets('should provide access to all layout properties', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Column(
                    children: [
                      Text('Width: ${layout.width}'),
                      Text('Height: ${layout.height}'),
                      Text('Breakpoint: ${layout.breakpoint}'),
                      Text('Margin: ${layout.margin}'),
                      Text('Gutter: ${layout.gutter}'),
                      Text('Columns: ${layout.columns}'),
                      Text('MaxWidth: ${layout.maxWidth}'),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Width:'), findsOneWidget);
      expect(find.textContaining('Height:'), findsOneWidget);
      expect(find.textContaining('Breakpoint:'), findsOneWidget);
      expect(find.textContaining('Margin:'), findsOneWidget);
      expect(find.textContaining('Gutter:'), findsOneWidget);
      expect(find.textContaining('Columns:'), findsOneWidget);
      expect(find.textContaining('MaxWidth:'), findsOneWidget);
    });
  });

  group('LayoutBuildContext Extension', () {
    testWidgets('layout extension should provide LayoutData', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = context.layout;
                  return Text('Width: ${layout.width}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Width:'), findsOneWidget);
    });

    testWidgets('breakpoint extension should provide LayoutBreakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final breakpoint = context.breakpoint;
                  return Text('Breakpoint: $breakpoint');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Breakpoint:'), findsOneWidget);
    });
  });

  group('Integration Tests', () {
    testWidgets('should work with nested Layout widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Layout(
                format: MaterialLayoutFormat(
                  margin: const ConstantLayoutValue(48.0),
                ),
                child: Builder(
                  builder: (context) {
                    final layout = context.layout;
                    return Text('Margin: ${layout.margin}');
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Should use innermost Layout's format
      expect(find.text('Margin: 48.0'), findsOneWidget);
    });

    testWidgets('should provide correct breakpoint for different screen sizes', (tester) async {
      for (final testCase in [
        (const Size(320, 568), 'xs'),
        (const Size(600, 800), 'sm'),
        (const Size(1024, 768), 'md'),
        (const Size(1440, 900), 'lg'),
        (const Size(1920, 1080), 'xl'),
      ]) {
        await tester.binding.setSurfaceSize(testCase.$1);

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: Builder(
                  builder: (context) {
                    return Text('Breakpoint: ${context.breakpoint}');
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.textContaining(testCase.$2), findsOneWidget,
            reason: 'Expected ${testCase.$2} for size ${testCase.$1}');
      }

      await tester.binding.setSurfaceSize(null);
    });
  });

  group('Edge Cases', () {
    testWidgets('should handle very small sizes', (tester) async {
      await tester.binding.setSurfaceSize(const Size(100, 100));

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = context.layout;
                  return Text('Width: ${layout.width}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Width:'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('should handle very large sizes', (tester) async {
      await tester.binding.setSurfaceSize(const Size(3840, 2160));

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = context.layout;
                  return Text('Breakpoint: ${layout.breakpoint}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Breakpoint: LayoutBreakpoint.xl'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('should handle maxWidth larger than screen width', (tester) async {
      await tester.binding.setSurfaceSize(const Size(400, 800));

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = context.layout;
                  // maxWidth should be constrained to actual width
                  return Text('MaxWidth: ${layout.maxWidth}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('MaxWidth:'), findsOneWidget);

      await tester.binding.setSurfaceSize(null);
    });
  });
}
