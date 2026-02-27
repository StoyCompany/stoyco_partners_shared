import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/boostrap_format.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/material_format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';

void main() {
  group('LayoutFormat', () {
    test('should have default pixel format as physical', () {
      final format = MaterialLayoutFormat();
      expect(format.pixel, LayoutPixelFormat.logical);
    });

    test('breakpointForWidth should return correct breakpoint', () {
      final format = MaterialLayoutFormat();

      expect(format.breakpointForWidth(0), LayoutBreakpoint.xs);
      expect(format.breakpointForWidth(320), LayoutBreakpoint.xs);
      expect(format.breakpointForWidth(600), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(800), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(1024), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(1200), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(1440), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(1600), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(1920), LayoutBreakpoint.xl);
      expect(format.breakpointForWidth(2560), LayoutBreakpoint.xl);
    });

    test('breakpointForWidth should handle edge cases at boundaries', () {
      final format = MaterialLayoutFormat();

      expect(format.breakpointForWidth(599.99), LayoutBreakpoint.xs);
      expect(format.breakpointForWidth(600), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(1023.99), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(1024), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(1439.99), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(1440), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(1919.99), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(1920), LayoutBreakpoint.xl);
    });

    test('should resolve layout data correctly', () {
      final format = MaterialLayoutFormat();
      final mediaQuery = const MediaQueryData(size: Size(800, 600));
      final visualDensity = VisualDensity.standard;

      final layoutData = format.resolve(
        const Size(800, 600),
        mediaQuery,
        visualDensity,
      );

      expect(layoutData.breakpoint, LayoutBreakpoint.sm);
      expect(layoutData.size.width, 800);
      expect(layoutData.size.height, 600);
      expect(layoutData.devicePixelRatio, mediaQuery.devicePixelRatio);
    });
  });

  group('MaterialLayoutFormat', () {
    test('should have correct breakpoints', () {
      final format = MaterialLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 0);
      expect(format.breakpoints[LayoutBreakpoint.sm], 600);
      expect(format.breakpoints[LayoutBreakpoint.md], 1024);
      expect(format.breakpoints[LayoutBreakpoint.lg], 1440);
      expect(format.breakpoints[LayoutBreakpoint.xl], 1920);
    });

    test('should use logical pixel format', () {
      final format = MaterialLayoutFormat();
      expect(format.pixel, LayoutPixelFormat.logical);
    });

    test('should have default margin that adapts to width', () {
      final format = MaterialLayoutFormat();

      // Small screen (≤ 719)
      final smallContext = LayoutContext(
        size: const Size(600, 800),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(format.margin.resolveForLayout(smallContext), 16);

      // Large screen (> 719)
      final largeContext = LayoutContext(
        size: const Size(1000, 1200),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );
      expect(format.margin.resolveForLayout(largeContext), 24);
    });

    test('should have correct maxWidth for each breakpoint', () {
      final format = MaterialLayoutFormat();

      final xsContext = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(xsContext), 600);

      final smContext = LayoutContext(
        size: const Size(600, 800),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(smContext), 540);

      final mdContext = LayoutContext(
        size: const Size(1024, 768),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(mdContext), 720);

      final lgContext = LayoutContext(
        size: const Size(1440, 900),
        breakpoint: LayoutBreakpoint.lg,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(lgContext), 960);

      final xlContext = LayoutContext(
        size: const Size(1920, 1080),
        breakpoint: LayoutBreakpoint.xl,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(xlContext), 1140);
    });

    test('should calculate columns based on breakpoint', () {
      final format = MaterialLayoutFormat();

      final xsContext = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(format.columns.resolveForLayout(xsContext), greaterThan(0));

      final xlContext = LayoutContext(
        size: const Size(1920, 1080),
        breakpoint: LayoutBreakpoint.xl,
        devicePixelRatio: 1.0,
      );
      expect(format.columns.resolveForLayout(xlContext), greaterThan(0));
    });

    test('should support custom margin', () {
      final format = MaterialLayoutFormat(
        margin: const ConstantLayoutValue(32.0),
      );

      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(format.margin.resolveForLayout(context), 32.0);
    });

    test('should support custom gutter', () {
      final format = MaterialLayoutFormat(
        gutter: const ConstantLayoutValue(16.0),
      );

      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(format.gutter.resolveForLayout(context), 16.0);
    });
  });

  group('BootstrapLayoutFormat', () {
    test('should have correct breakpoints', () {
      final format = BootstrapLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 0);
      expect(format.breakpoints[LayoutBreakpoint.sm], 576);
      expect(format.breakpoints[LayoutBreakpoint.md], 768);
      expect(format.breakpoints[LayoutBreakpoint.lg], 992);
      expect(format.breakpoints[LayoutBreakpoint.xl], 1200);
    });

    test('should use logical pixel format', () {
      final format = BootstrapLayoutFormat();
      expect(format.pixel, LayoutPixelFormat.logical);
    });

    test('should have constant gutter of 30', () {
      final format = BootstrapLayoutFormat();

      for (final breakpoint in LayoutBreakpoint.values) {
        final context = LayoutContext(
          size: const Size(800, 600),
          breakpoint: breakpoint,
          devicePixelRatio: 1.0,
        );
        expect(format.gutter.resolveForLayout(context), 30.0);
      }
    });

    test('should have default margin of 0', () {
      final format = BootstrapLayoutFormat();

      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(format.margin.resolveForLayout(context), 0);
    });

    test('should have correct maxWidth for each breakpoint', () {
      final format = BootstrapLayoutFormat();

      final xsContext = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(xsContext), 576);

      final smContext = LayoutContext(
        size: const Size(600, 800),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(smContext), 540);

      final mdContext = LayoutContext(
        size: const Size(800, 768),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(mdContext), 720);

      final lgContext = LayoutContext(
        size: const Size(1000, 900),
        breakpoint: LayoutBreakpoint.lg,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(lgContext), 960);

      final xlContext = LayoutContext(
        size: const Size(1400, 1080),
        breakpoint: LayoutBreakpoint.xl,
        devicePixelRatio: 1.0,
      );
      expect(format.maxWidth.resolveForLayout(xlContext), 1140);
    });

    test('should support custom margin', () {
      final format = BootstrapLayoutFormat(
        margin: const ConstantLayoutValue(20.0),
      );

      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(format.margin.resolveForLayout(context), 20.0);
    });

    test('should determine breakpoint correctly for different widths', () {
      final format = BootstrapLayoutFormat();

      expect(format.breakpointForWidth(320), LayoutBreakpoint.xs);
      expect(format.breakpointForWidth(576), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(768), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(992), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(1200), LayoutBreakpoint.xl);
    });
  });

  group('Format Comparison', () {
    test('MaterialLayoutFormat and BootstrapLayoutFormat should have different breakpoints', () {
      final material = MaterialLayoutFormat();
      final bootstrap = BootstrapLayoutFormat();

      expect(material.breakpoints, isNot(equals(bootstrap.breakpoints)));
      expect(material.breakpoints[LayoutBreakpoint.sm], 600);
      expect(bootstrap.breakpoints[LayoutBreakpoint.sm], 576);
    });

    test('should resolve to different breakpoints at same width', () {
      final material = MaterialLayoutFormat();
      final bootstrap = BootstrapLayoutFormat();

      // At width 590, material is still xs, bootstrap is sm
      expect(material.breakpointForWidth(590), LayoutBreakpoint.xs);
      expect(bootstrap.breakpointForWidth(590), LayoutBreakpoint.sm);

      // At width 700, both are sm
      expect(material.breakpointForWidth(700), LayoutBreakpoint.sm);
      expect(bootstrap.breakpointForWidth(700), LayoutBreakpoint.sm);
    });
  });

  group('Integration Tests', () {
    testWidgets('should work with Layout widget using MaterialFormat', (tester) async {
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

    testWidgets('should work with Layout widget using BootstrapFormat', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: BootstrapLayoutFormat(),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  final layout = Layout.of(context);
                  return Text('Gutter: ${layout.gutter}');
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Gutter: 30.0'), findsOneWidget);
    });
  });

  group('Edge Cases', () {
    test('should handle width of 0', () {
      final format = MaterialLayoutFormat();
      expect(format.breakpointForWidth(0), LayoutBreakpoint.xs);
    });

    test('should handle very large widths', () {
      final format = MaterialLayoutFormat();
      expect(format.breakpointForWidth(10000), LayoutBreakpoint.xl);
    });

    test('should handle negative widths gracefully', () {
      final format = MaterialLayoutFormat();
      expect(() => format.breakpointForWidth(-100), returnsNormally);
      expect(format.breakpointForWidth(-100), LayoutBreakpoint.xs);
    });
  });
}
