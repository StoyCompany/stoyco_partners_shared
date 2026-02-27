import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/material_format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/margin.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

void main() {
  group('Margin Widget', () {
    testWidgets('should render with default margin from layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Margin), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should use layout margin when margin is null', (tester) async {
      double? capturedMargin;

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  capturedMargin = context.layout.margin;
                  return Margin(
                    child: Container(),
                  );
                },
              ),
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(
        padding.padding,
        EdgeInsets.symmetric(horizontal: capturedMargin!),
      );
    });

    testWidgets('should use custom margin when provided', (tester) async {
      const customMargin = EdgeInsets.all(32.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                margin: customMargin,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, customMargin);
    });

    testWidgets('should support asymmetric margins', (tester) async {
      const customMargin = EdgeInsets.only(
        left: 10,
        right: 20,
        top: 30,
        bottom: 40,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                margin: customMargin,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, customMargin);
    });
  });

  group('SliverMargin Widget', () {
    testWidgets('should render in CustomScrollView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverMargin(
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SliverMargin), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should use layout margin when margin is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverMargin(
                    sliver: SliverToBoxAdapter(
                      child: Container(height: 100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SliverMargin), findsOneWidget);
    });

    testWidgets('should use custom margin when provided', (tester) async {
      const customMargin = EdgeInsets.all(24.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverMargin(
                    margin: customMargin,
                    sliver: SliverToBoxAdapter(
                      child: Container(height: 100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final sliverMargin = tester.widget<SliverMargin>(find.byType(SliverMargin));
      expect(sliverMargin.margin, customMargin);
    });
  });

  group('FluidMargin Widget', () {
    testWidgets('should render with fluid margin', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: FluidMargin(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FluidMargin), findsOneWidget);
      expect(find.byType(Padding), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should calculate fluid margin correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  return FluidMargin(
                    child: Container(),
                  );
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(FluidMargin), findsOneWidget);
    });

    testWidgets('should support custom maxWidth', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: FluidMargin(
                maxWidth: 800,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final fluidMargin = tester.widget<FluidMargin>(find.byType(FluidMargin));
      expect(fluidMargin.maxWidth, 800);
    });

    testWidgets('should support fluid flag', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: FluidMargin(
                fluid: false,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final fluidMargin = tester.widget<FluidMargin>(find.byType(FluidMargin));
      expect(fluidMargin.fluid, false);
    });

    testWidgets('should combine custom margin with fluid margin', (tester) async {
      const customMargin = EdgeInsets.symmetric(vertical: 16.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: FluidMargin(
                margin: customMargin,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final fluidMargin = tester.widget<FluidMargin>(find.byType(FluidMargin));
      expect(fluidMargin.margin, customMargin);
    });
  });

  group('SliverFluidMargin Widget', () {
    testWidgets('should render in CustomScrollView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidMargin(
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SliverFluidMargin), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should support maxWidth', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidMargin(
                    maxWidth: 1000,
                    sliver: SliverToBoxAdapter(
                      child: Container(height: 100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final sliverFluidMargin =
          tester.widget<SliverFluidMargin>(find.byType(SliverFluidMargin));
      expect(sliverFluidMargin.maxWidth, 1000);
    });

    testWidgets('should support fluid flag', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidMargin(
                    fluid: false,
                    sliver: SliverToBoxAdapter(
                      child: Container(height: 100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final sliverFluidMargin =
          tester.widget<SliverFluidMargin>(find.byType(SliverFluidMargin));
      expect(sliverFluidMargin.fluid, false);
    });

    testWidgets('should support custom margin', (tester) async {
      const customMargin = EdgeInsets.all(20.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidMargin(
                    margin: customMargin,
                    sliver: SliverToBoxAdapter(
                      child: Container(height: 100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final sliverFluidMargin =
          tester.widget<SliverFluidMargin>(find.byType(SliverFluidMargin));
      expect(sliverFluidMargin.margin, customMargin);
    });
  });

  group('SliverFluidBox Widget', () {
    testWidgets('should render in CustomScrollView', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidBox(
                    child: Container(
                      height: 100,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SliverFluidBox), findsOneWidget);
      expect(find.byType(SliverFluidMargin), findsOneWidget);
      expect(find.byType(SliverToBoxAdapter), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should support null child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: const Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidBox(
                    child: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SliverFluidBox), findsOneWidget);
    });

    testWidgets('should pass properties to SliverFluidMargin', (tester) async {
      const customMargin = EdgeInsets.all(12.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverFluidBox(
                    margin: customMargin,
                    maxWidth: 600,
                    fluid: false,
                    child: Container(height: 100),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      final sliverFluidBox =
          tester.widget<SliverFluidBox>(find.byType(SliverFluidBox));
      expect(sliverFluidBox.margin, customMargin);
      expect(sliverFluidBox.maxWidth, 600);
      expect(sliverFluidBox.fluid, false);
    });
  });

  group('Edge Cases', () {
    testWidgets('should handle zero margin', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                margin: EdgeInsets.zero,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, EdgeInsets.zero);
    });

    testWidgets('should handle very large margins', (tester) async {
      const largeMargin = EdgeInsets.all(1000.0);

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                margin: largeMargin,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, largeMargin);
    });

    testWidgets('should handle maxWidth of zero', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: FluidMargin(
                maxWidth: 0,
                child: Container(),
              ),
            ),
          ),
        ),
      );

      final fluidMargin = tester.widget<FluidMargin>(find.byType(FluidMargin));
      expect(fluidMargin.maxWidth, 0);
    });
  });

  group('Integration Tests', () {
    testWidgets('should work with nested margins', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                margin: const EdgeInsets.all(16.0),
                child: Margin(
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Margin), findsNWidgets(2));
      expect(find.byType(Padding), findsNWidgets(2));
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('should work with Margin and FluidMargin together', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: MaterialLayoutFormat(),
            child: Scaffold(
              body: Margin(
                margin: const EdgeInsets.all(16.0),
                child: FluidMargin(
                  child: Container(
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Margin), findsOneWidget);
      expect(find.byType(FluidMargin), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });
  });
}
