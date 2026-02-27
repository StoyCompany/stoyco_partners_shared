import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gap/gap.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/material_format.dart';
import 'package:stoyco_partners_shared/design/responsive/gutter.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';

void main() {
  group('Gutter Widget', () {
    testWidgets('should render with default extent from layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return const Gutter();
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Gutter), findsOneWidget);
      expect(find.byType(Gap), findsOneWidget);
    });

    testWidgets('should render with custom extent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: const Scaffold(
              body: Gutter(24.0),
            ),
          ),
        ),
      );

      expect(find.byType(Gutter), findsOneWidget);
      final gutter = tester.widget<Gutter>(find.byType(Gutter));
      expect(gutter.extent, 24.0);
    });

    testWidgets('should use layout gutter when extent is null', (tester) async {
      double? capturedGutter;

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedGutter = context.layout.gutter;
                  return const Gutter();
                },
              ),
            ),
          ),
        ),
      );

      final gap = tester.widget<Gap>(find.byType(Gap));
      expect(gap.mainAxisExtent, capturedGutter);
    });

    testWidgets('should override layout gutter when extent is provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: const Scaffold(
              body: Gutter(32.0),
            ),
          ),
        ),
      );

      final gap = tester.widget<Gap>(find.byType(Gap));
      expect(gap.mainAxisExtent, 32.0);
    });
  });

  group('SliverGutter Widget', () {
    testWidgets('should render in CustomScrollView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(height: 50, color: Colors.red),
                  ),
                  const SliverGutter(),
                  SliverToBoxAdapter(
                    child: Container(height: 50, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SliverGutter), findsOneWidget);
      expect(find.byType(SliverGap), findsOneWidget);
    });

    testWidgets('should use custom extent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(height: 50),
                  ),
                  const SliverGutter(48.0),
                  SliverToBoxAdapter(
                    child: Container(height: 50),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final sliverGutter = tester.widget<SliverGutter>(find.byType(SliverGutter));
      expect(sliverGutter.extent, 48.0);
    });

    testWidgets('should use layout gutter when extent is null', (tester) async {
      double? capturedGutter;

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedGutter = context.layout.gutter;
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(height: 50),
                      ),
                      const SliverGutter(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );

      final sliverGap = tester.widget<SliverGap>(find.byType(SliverGap));
      expect(sliverGap.mainAxisExtent, capturedGutter);
    });
  });

  group('Gutter.separateChildren', () {
    test('should return empty list when children is empty', () {
      final result = Gutter.separateChildren(
        children: [],
        extent: 16.0,
      );

      expect(result, isEmpty);
    });

    test('should return same list when only one child', () {
      final widget = Container();
      final result = Gutter.separateChildren(
        children: [widget],
        extent: 16.0,
      );

      expect(result.length, 1);
      expect(result[0], widget);
    });

    test('should insert gutters between children', () {
      final widgets = [
        Container(key: const Key('1')),
        Container(key: const Key('2')),
        Container(key: const Key('3')),
      ];

      final result = Gutter.separateChildren(
        children: widgets,
        extent: 16.0,
      );

      // Should have original widgets + gutters
      // 3 widgets + 2 gutters = 5 total
      expect(result.length, 5);

      // Check structure: widget, gutter, widget, gutter, widget
      expect(result[0], widgets[0]);
      expect(result[1], isA<Gutter>());
      expect(result[2], widgets[1]);
      expect(result[3], isA<Gutter>());
      expect(result[4], widgets[2]);

      // Check gutter extents
      expect((result[1] as Gutter).extent, 16.0);
      expect((result[3] as Gutter).extent, 16.0);
    });

    test('should handle null extent', () {
      final widgets = [
        Container(),
        Container(),
      ];

      final result = Gutter.separateChildren(
        children: widgets,
        extent: null,
      );

      expect(result.length, 3);
      expect(result[1], isA<Gutter>());
      expect((result[1] as Gutter).extent, isNull);
    });

    test('should work with different extent values', () {
      final widgets = [
        Container(),
        Container(),
        Container(),
      ];

      final result = Gutter.separateChildren(
        children: widgets,
        extent: 32.0,
      );

      expect(result.length, 5);
      expect((result[1] as Gutter).extent, 32.0);
      expect((result[3] as Gutter).extent, 32.0);
    });
  });

  group('ListGutter Extension', () {
    test('should separate list with gutters', () {
      final widgets = [
        Container(key: const Key('1')),
        Container(key: const Key('2')),
        Container(key: const Key('3')),
      ];

      final result = widgets.separate(24.0);

      expect(result.length, 5);
      expect(result[0], widgets[0]);
      expect(result[1], isA<Gutter>());
      expect(result[2], widgets[1]);
      expect(result[3], isA<Gutter>());
      expect(result[4], widgets[2]);
    });

    test('should handle empty list', () {
      final List<Widget> widgets = [];
      final result = widgets.separate(16.0);

      expect(result, isEmpty);
    });

    test('should handle single widget', () {
      final widget = Container();
      final result = [widget].separate(16.0);

      expect(result.length, 1);
      expect(result[0], widget);
    });

    test('should handle null extent', () {
      final widgets = [
        Container(),
        Container(),
      ];

      final result = widgets.separate(null);

      expect(result.length, 3);
      final gutter = result[1] as Gutter;
      expect(gutter.extent, isNull);
    });

    test('should work with many widgets', () {
      final widgets = List.generate(10, (i) => Container(key: Key('$i')));
      final result = widgets.separate(8.0);

      // 10 widgets + 9 gutters = 19 total
      expect(result.length, 19);

      // Verify alternating pattern
      for (var i = 0; i < result.length; i++) {
        if (i.isEven) {
          expect(result[i], isA<Container>());
        } else {
          expect(result[i], isA<Gutter>());
          expect((result[i] as Gutter).extent, 8.0);
        }
      }
    });
  });

  group('Integration Tests', () {
    testWidgets('should work in Column with separateChildren', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Column(
                children: Gutter.separateChildren(
                  children: [
                    Container(height: 50, color: Colors.red),
                    Container(height: 50, color: Colors.blue),
                    Container(height: 50, color: Colors.green),
                  ],
                  extent: 16.0,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byType(Gutter), findsNWidgets(2));
    });

    testWidgets('should work in Row with extension', (tester) async {
      final widgets = [
        Container(width: 50, height: 50, color: Colors.red),
        Container(width: 50, height: 50, color: Colors.blue),
        Container(width: 50, height: 50, color: Colors.green),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Row(
                children: widgets.separate(12.0),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Container), findsNWidgets(3));
      expect(find.byType(Gutter), findsNWidgets(2));
    });

    testWidgets('should adapt to different layout gutters', (tester) async {
      // Test with different screen sizes that trigger different breakpoints
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      Text('Gutter: ${context.layout.gutter}'),
                      const Gutter(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Gutter), findsOneWidget);
      
      // Reset surface size
      await tester.binding.setSurfaceSize(null);
    });
  });

  group('Edge Cases', () {
    testWidgets('should handle zero extent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: const Scaffold(
              body: Gutter(0.0),
            ),
          ),
        ),
      );

      final gap = tester.widget<Gap>(find.byType(Gap));
      expect(gap.mainAxisExtent, 0.0);
    });

    testWidgets('should handle very large extent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: const Scaffold(
              body: Gutter(1000.0),
            ),
          ),
        ),
      );

      final gap = tester.widget<Gap>(find.byType(Gap));
      expect(gap.mainAxisExtent, 1000.0);
    });

    test('should handle negative extent gracefully', () {
      final widgets = [Container(), Container()];
      final result = widgets.separate(-16.0);

      expect(result.length, 3);
      expect((result[1] as Gutter).extent, -16.0);
    });
  });
}
