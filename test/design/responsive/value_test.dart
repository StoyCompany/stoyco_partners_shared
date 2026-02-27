import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

void main() {
  group('BreakpointValue', () {
    test('should resolve to xs value when only xs is provided', () {
      final value = BreakpointValue<int>(xs: 1);
      final context = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );

      expect(value.resolveForLayout(context), 1);
    });

    test('should resolve to correct value for each breakpoint', () {
      final value = BreakpointValue<int>(
        xs: 1,
        sm: 2,
        md: 3,
        lg: 4,
        xl: 5,
      );

      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(320, 568),
          breakpoint: LayoutBreakpoint.xs,
          devicePixelRatio: 1.0,
        )),
        1,
      );

      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(600, 800),
          breakpoint: LayoutBreakpoint.sm,
          devicePixelRatio: 1.0,
        )),
        2,
      );

      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(900, 1200),
          breakpoint: LayoutBreakpoint.md,
          devicePixelRatio: 1.0,
        )),
        3,
      );

      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(1200, 1600),
          breakpoint: LayoutBreakpoint.lg,
          devicePixelRatio: 1.0,
        )),
        4,
      );

      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(1600, 2000),
          breakpoint: LayoutBreakpoint.xl,
          devicePixelRatio: 1.0,
        )),
        5,
      );
    });

    test('should fall back to xs value when specific breakpoint is not provided', () {
      final value = BreakpointValue<int>(xs: 1);

      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(900, 1200),
          breakpoint: LayoutBreakpoint.md,
          devicePixelRatio: 1.0,
        )),
        1,
      );
    });

    test('should fall back to nearest smaller breakpoint when value not defined', () {
      final value = BreakpointValue<String>(
        xs: 'xs',
        md: 'md',
        xl: 'xl',
      );

      // sm should fall back to xs
      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(600, 800),
          breakpoint: LayoutBreakpoint.sm,
          devicePixelRatio: 1.0,
        )),
        'xs',
      );

      // lg should fall back to md
      expect(
        value.resolveForLayout(LayoutContext(
          size: const Size(1200, 1600),
          breakpoint: LayoutBreakpoint.lg,
          devicePixelRatio: 1.0,
        )),
        'md',
      );
    });

    test('should work with different types', () {
      final intValue = BreakpointValue<int>(xs: 1, md: 3);
      final doubleValue = BreakpointValue<double>(xs: 1.5, md: 3.5);
      final stringValue = BreakpointValue<String>(xs: 'small', md: 'medium');
      final boolValue = BreakpointValue<bool>(xs: true, md: false);

      final context = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );

      expect(intValue.resolveForLayout(context), 1);
      expect(doubleValue.resolveForLayout(context), 1.5);
      expect(stringValue.resolveForLayout(context), 'small');
      expect(boolValue.resolveForLayout(context), true);
    });
  });

  group('ConstantLayoutValue', () {
    test('should always return the same value regardless of breakpoint', () {
      const value = ConstantLayoutValue<int>(42);

      for (final breakpoint in LayoutBreakpoint.values) {
        final context = LayoutContext(
          size: const Size(800, 600),
          breakpoint: breakpoint,
          devicePixelRatio: 1.0,
        );
        expect(value.resolveForLayout(context), 42);
      }
    });

    test('should work with different types', () {
      const intValue = ConstantLayoutValue<int>(42);
      const doubleValue = ConstantLayoutValue<double>(3.14);
      const stringValue = ConstantLayoutValue<String>('constant');
      const boolValue = ConstantLayoutValue<bool>(true);

      final context = LayoutContext(
        size: const Size(800, 600),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );

      expect(intValue.resolveForLayout(context), 42);
      expect(doubleValue.resolveForLayout(context), 3.14);
      expect(stringValue.resolveForLayout(context), 'constant');
      expect(boolValue.resolveForLayout(context), true);
    });
  });

  group('ScreenWidthValue', () {
    test('should return the width of the layout', () {
      const value = ScreenWidthValue();

      final context1 = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(context1), 320);

      final context2 = LayoutContext(
        size: const Size(1024, 768),
        breakpoint: LayoutBreakpoint.lg,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(context2), 1024);

      final context3 = LayoutContext(
        size: const Size(1920, 1080),
        breakpoint: LayoutBreakpoint.xl,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(context3), 1920);
    });
  });

  group('LayoutValue Factory', () {
    test('should create BreakpointValue from factory constructor', () {
      final value = LayoutValue<int>(
        xs: 1,
        sm: 2,
        md: 3,
      );

      expect(value, isA<BreakpointValue<int>>());
    });

    test('should create constant value from value factory', () {
      final value = LayoutValue<int>.value(42);

      expect(value, isA<ConstantLayoutValue<int>>());
    });

    test('should create builder value from builder factory', () {
      final value = LayoutValue<int>.builder(
        (layout) => layout.breakpoint.index * 10,
      );

      final xsContext = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(xsContext), 0);

      final mdContext = LayoutContext(
        size: const Size(900, 1200),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(mdContext), 20);
    });

    test('screenWidth should be a ScreenWidthValue', () {
      expect(LayoutValue.screenWidth, isA<ScreenWidthValue>());
    });
  });

  group('LayoutValue resolve in BuildContext', () {
    testWidgets('should resolve value from BuildContext', (tester) async {
      final value = BreakpointValue<String>(
        xs: 'mobile',
        md: 'tablet',
        xl: 'desktop',
      );

      String? resolvedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // Create a mock layout data
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final layoutContext = LayoutContext(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      breakpoint: LayoutBreakpoint.md,
                      devicePixelRatio: 1.0,
                    );
                    resolvedValue = value.resolveForLayout(layoutContext);
                    return Container();
                  },
                );
              },
            ),
          ),
        ),
      );

      expect(resolvedValue, 'tablet');
    });
  });

  group('Edge Cases', () {
    test('should handle null values in breakpoint value', () {
      final value = BreakpointValue<int?>(
        xs: null,
        md: 42,
      );

      final xsContext = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(xsContext), null);

      final mdContext = LayoutContext(
        size: const Size(900, 1200),
        breakpoint: LayoutBreakpoint.md,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(mdContext), 42);
    });

    test('should handle zero and negative values', () {
      final value = BreakpointValue<int>(
        xs: 0,
        sm: -10,
        md: -100,
      );

      final xsContext = LayoutContext(
        size: const Size(320, 568),
        breakpoint: LayoutBreakpoint.xs,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(xsContext), 0);

      final smContext = LayoutContext(
        size: const Size(600, 800),
        breakpoint: LayoutBreakpoint.sm,
        devicePixelRatio: 1.0,
      );
      expect(value.resolveForLayout(smContext), -10);
    });

    test('builder should handle complex calculations', () {
      final value = LayoutValue<double>.builder(
        (layout) {
          // Calculate value based on multiple layout properties
          return layout.width * 0.1 + layout.breakpoint.index * 10;
        },
      );

      final context = LayoutContext(
        size: const Size(1000, 800),
        breakpoint: LayoutBreakpoint.lg,
        devicePixelRatio: 2.0,
      );
      
      // 1000 * 0.1 + 3 * 10 = 100 + 30 = 130
      expect(value.resolveForLayout(context), 130);
    });
  });
}
