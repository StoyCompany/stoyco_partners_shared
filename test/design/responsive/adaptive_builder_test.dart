import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/adaptive_builder.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/material_format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

void main() {
  group('AdaptiveBuilder', () {
    group('Basic Constructor', () {
      testWidgets('should render xs builder for extra small screens', (tester) async {
        await tester.binding.setSurfaceSize(const Size(320, 568));

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => const Text('XS Screen'),
                  sm: (context) => const Text('SM Screen'),
                  md: (context) => const Text('MD Screen'),
                  lg: (context) => const Text('LG Screen'),
                  xl: (context) => const Text('XL Screen'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('XS Screen'), findsOneWidget);
        expect(find.text('SM Screen'), findsNothing);
        
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should fall back to xs when specific breakpoint not provided', (tester) async {
        await tester.binding.setSurfaceSize(const Size(900, 800));

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => const Text('XS Screen'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('XS Screen'), findsOneWidget);
        
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should use correct builder for each breakpoint', (tester) async {
        for (final testCase in [
          (const Size(320, 568), 'XS'),
          (const Size(600, 800), 'SM'),
          (const Size(900, 1200), 'MD'),
          (const Size(1200, 1600), 'LG'),
          (const Size(1600, 2000), 'XL'),
        ]) {
          await tester.binding.setSurfaceSize(testCase.$1);

          await tester.pumpWidget(
            MaterialApp(
              home: Layout(
                format: MaterialLayoutFormat(),
                child: Scaffold(
                  body: AdaptiveBuilder(
                    xs: (context) => const Text('XS'),
                    sm: (context) => const Text('SM'),
                    md: (context) => const Text('MD'),
                    lg: (context) => const Text('LG'),
                    xl: (context) => const Text('XL'),
                  ),
                ),
              ),
            ),
          );

          expect(find.text(testCase.$2), findsOneWidget,
              reason: 'Expected ${testCase.$2} for size ${testCase.$1}');
        }

        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should build different widgets for different breakpoints', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => Container(
                    key: const Key('xs-container'),
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  md: (context) => Container(
                    key: const Key('md-container'),
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
      });
    });

    group('Builder Constructor', () {
      testWidgets('should provide layout context to builder', (tester) async {
        LayoutContext? capturedLayout;

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    capturedLayout = layout;
                    return Text('Width: ${layout.width}');
                  },
                ),
              ),
            ),
          ),
        );

        expect(capturedLayout, isNotNull);
        expect(capturedLayout!.width, greaterThan(0));
        expect(find.textContaining('Width:'), findsOneWidget);
      });

      testWidgets('should pass child to builder', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: child,
                    );
                  },
                  child: const Text('Child Widget'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Child Widget'), findsOneWidget);
        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets('should rebuild when layout changes', (tester) async {
        await tester.binding.setSurfaceSize(const Size(320, 568));

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    return Text('Breakpoint: ${layout.breakpoint}');
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.text('Breakpoint: LayoutBreakpoint.xs'), findsOneWidget);

        await tester.binding.setSurfaceSize(const Size(1200, 1600));
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    return Text('Breakpoint: ${layout.breakpoint}');
                  },
                ),
              ),
            ),
          ),
        );

        await tester.pump();

        expect(find.text('Breakpoint: LayoutBreakpoint.lg'), findsOneWidget);
        
        await tester.binding.setSurfaceSize(null);
      });

      testWidgets('should access layout properties', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    return Column(
                      children: [
                        Text('Width: ${layout.width}'),
                        Text('Breakpoint: ${layout.breakpoint}'),
                        Text('Device Pixel Ratio: ${layout.devicePixelRatio}'),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );

        expect(find.textContaining('Width:'), findsOneWidget);
        expect(find.textContaining('Breakpoint:'), findsOneWidget);
        expect(find.textContaining('Device Pixel Ratio:'), findsOneWidget);
      });
    });

    group('Raw Constructor', () {
      testWidgets('should accept LayoutValue directly', (tester) async {
        final layoutValue = BreakpointValue<WidgetBuilder>(
          xs: (context) => const Text('XS'),
          md: (context) => const Text('MD'),
          xl: (context) => const Text('XL'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.raw(
                  child: layoutValue,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('should work with custom LayoutValue', (tester) async {
        final customValue = LayoutValue<WidgetBuilder>.builder(
          (layout) {
            if (layout.width > 1000) {
              return (context) => const Text('Wide Screen');
            } else {
              return (context) => const Text('Narrow Screen');
            }
          },
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.raw(
                  child: customValue,
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Text), findsOneWidget);
      });
    });

    group('Complex Scenarios', () {
      testWidgets('should handle complex responsive layouts', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    if (layout.breakpoint.index <= LayoutBreakpoint.sm.index) {
                      return Column(
                        children: [
                          const Text('Mobile Layout'),
                          if (child != null) child,
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          const Expanded(child: Text('Desktop Layout')),
                          if (child != null) Expanded(child: child),
                        ],
                      );
                    }
                  },
                  child: const Text('Content'),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Content'), findsOneWidget);
        expect(find.byType(AdaptiveBuilder), findsOneWidget);
      });

      testWidgets('should nest multiple AdaptiveBuilders', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => AdaptiveBuilder(
                    xs: (context) => const Text('Nested XS'),
                  ),
                  md: (context) => const Text('MD'),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(AdaptiveBuilder), findsNWidgets(2));
        expect(find.byType(Text), findsOneWidget);
      });

      testWidgets('should work with different widget types', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => ListView(children: const [
                    ListTile(title: Text('Item 1')),
                    ListTile(title: Text('Item 2')),
                  ]),
                  md: (context) => GridView.count(
                    crossAxisCount: 2,
                    children: const [
                      Card(child: Text('Card 1')),
                      Card(child: Text('Card 2')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        // Should find either ListView or GridView depending on screen size
        expect(
          find.byType(ListView).evaluate().isNotEmpty ||
              find.byType(GridView).evaluate().isNotEmpty,
          isTrue,
        );
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle null child in builder', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder.builder(
                  builder: (context, layout, child) {
                    return const Text('No child');
                  },
                  child: null,
                ),
              ),
            ),
          ),
        );

        expect(find.text('No child'), findsOneWidget);
      });

      testWidgets('should handle builder that returns empty container', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => Container(),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Container), findsOneWidget);
      });

      testWidgets('should handle builder that returns SizedBox.shrink', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Layout(
              format: MaterialLayoutFormat(),
              child: Scaffold(
                body: AdaptiveBuilder(
                  xs: (context) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(SizedBox), findsOneWidget);
      });
    });
  });
}
