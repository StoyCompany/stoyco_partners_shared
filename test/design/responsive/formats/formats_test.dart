import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/boostrap_format.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/fluid_format.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/portrait_tablet_layout_format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

void main() {
  group('FluidLayoutFormat', () {
    test('should create with default margin', () {
      final format = FluidLayoutFormat();

      expect(format.pixel, LayoutPixelFormat.logical);
      expect(format.margin, isA<LayoutValue<double>>());
      expect(format.columns, isA<ConstantLayoutValue<int>>());
    });

    test('should create with custom margin', () {
      final customMargin = const ConstantLayoutValue<double>(32.0);
      final format = FluidLayoutFormat(margin: customMargin);

      expect(format.margin, equals(customMargin));
    });

    test('should have correct Bootstrap breakpoints', () {
      final format = FluidLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 0);
      expect(format.breakpoints[LayoutBreakpoint.sm], 576);
      expect(format.breakpoints[LayoutBreakpoint.md], 768);
      expect(format.breakpoints[LayoutBreakpoint.lg], 992);
      expect(format.breakpoints[LayoutBreakpoint.xl], 1200);
    });

    test('should have correct maxFluidWidth values', () {
      final format = FluidLayoutFormat();

      expect(format.maxFluidWidth[LayoutBreakpoint.xs], 540);
      expect(format.maxFluidWidth[LayoutBreakpoint.sm], 540);
      expect(format.maxFluidWidth[LayoutBreakpoint.md], 720);
      expect(format.maxFluidWidth[LayoutBreakpoint.lg], 960);
      expect(format.maxFluidWidth[LayoutBreakpoint.xl], 1140);
    });

    test('should have responsive gutter values', () {
      final format = FluidLayoutFormat();
      final gutter = format.gutter as BreakpointValue<double>;

      expect(gutter, isA<BreakpointValue<double>>());
    });

    test('should have 12 columns', () {
      final format = FluidLayoutFormat();
      final columns = format.columns as ConstantLayoutValue<int>;

      expect(columns, isA<ConstantLayoutValue<int>>());
    });

    testWidgets('should calculate fluid width for sm breakpoint', (tester) async {
      final format = FluidLayoutFormat();

      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final width = format.calculateFluidWidth(LayoutBreakpoint.sm, 600);
                
                expect(width, isA<double>());
                expect(width, greaterThan(0));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('maxWidth should return correct value for xs breakpoint', (tester) async {
      final format = FluidLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(400, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final maxWidth = format.maxWidth.resolve(layout);
                
                expect(maxWidth, lessThanOrEqualTo(540));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('maxWidth should return fixed value for xl breakpoint', (tester) async {
      final format = FluidLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(1400, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final maxWidth = format.maxWidth.resolve(layout);
                
                expect(maxWidth, equals(1140));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('default margin should be 16 for width <= 719', (tester) async {
      final format = FluidLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(600, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final margin = format.margin.resolve(layout);
                
                expect(margin, equals(16));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('default margin should be 24 for width > 719', (tester) async {
      final format = FluidLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(800, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final margin = format.margin.resolve(layout);
                
                expect(margin, equals(24));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });
  });

  group('BootstrapLayoutFormat', () {
    test('should create with default margin', () {
      final format = BootstrapLayoutFormat();

      expect(format.pixel, LayoutPixelFormat.logical);
      expect(format.margin, isA<ConstantLayoutValue<double>>());
      expect(format.gutter, isA<ConstantLayoutValue<double>>());
    });

    test('should create with custom margin', () {
      final customMargin = const ConstantLayoutValue<double>(16.0);
      final format = BootstrapLayoutFormat(margin: customMargin);

      expect(format.margin, equals(customMargin));
    });

    test('should have constant gutter of 30', () {
      final format = BootstrapLayoutFormat();
      final gutter = format.gutter as ConstantLayoutValue<double>;

      expect(gutter, isA<ConstantLayoutValue<double>>());
    });

    test('should have correct Bootstrap breakpoints', () {
      final format = BootstrapLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 0);
      expect(format.breakpoints[LayoutBreakpoint.sm], 576);
      expect(format.breakpoints[LayoutBreakpoint.md], 768);
      expect(format.breakpoints[LayoutBreakpoint.lg], 992);
      expect(format.breakpoints[LayoutBreakpoint.xl], 1200);
    });

    test('should have correct maxWidth as BreakpointValue', () {
      final format = BootstrapLayoutFormat();

      expect(format.maxWidth, isA<BreakpointValue<double>>());
    });

    testWidgets('should resolve maxWidth for sm breakpoint', (tester) async {
      final format = BootstrapLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(600, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final maxWidth = format.maxWidth.resolve(layout);
                
                expect(maxWidth, equals(540));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('should resolve maxWidth for xl breakpoint', (tester) async {
      final format = BootstrapLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(1400, 800));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                final maxWidth = format.maxWidth.resolve(layout);
                
                expect(maxWidth, equals(1140));
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });
  });

  group('PortraitTabletLayoutFormat', () {
    test('should create with physical pixel format', () {
      final format = PortraitTabletLayoutFormat();

      expect(format.pixel, LayoutPixelFormat.physical);
    });

    test('should have correct physical pixel breakpoints', () {
      final format = PortraitTabletLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 720); // HD
      expect(format.breakpoints[LayoutBreakpoint.sm], 1080); // FHD
      expect(format.breakpoints[LayoutBreakpoint.md], 1125); // iPhone 11 Pro
      expect(format.breakpoints[LayoutBreakpoint.lg], 1440); // QHD
      expect(format.breakpoints[LayoutBreakpoint.xl], 2160); // 4K
    });

    test('should have maxWidth as BreakpointValue', () {
      final format = PortraitTabletLayoutFormat();

      expect(format.maxWidth, isA<BreakpointValue<double>>());
    });

    test('breakpoints should be in ascending order', () {
      final format = PortraitTabletLayoutFormat();
      final breakpoints = format.breakpoints;

      expect(breakpoints[LayoutBreakpoint.xs]! < breakpoints[LayoutBreakpoint.sm]!, isTrue);
      expect(breakpoints[LayoutBreakpoint.sm]! < breakpoints[LayoutBreakpoint.md]!, isTrue);
      expect(breakpoints[LayoutBreakpoint.md]! < breakpoints[LayoutBreakpoint.lg]!, isTrue);
      expect(breakpoints[LayoutBreakpoint.lg]! < breakpoints[LayoutBreakpoint.xl]!, isTrue);
    });

    testWidgets('should resolve correct breakpoint for HD resolution', (tester) async {
      final format = PortraitTabletLayoutFormat();
      
      await tester.binding.setSurfaceSize(const Size(720, 1280));
      
      await tester.pumpWidget(
        MaterialApp(
          home: Layout(
            format: format,
            child: Builder(
              builder: (context) {
                final layout = Layout.of(context);
                
                expect(layout.breakpoint, isA<LayoutBreakpoint>());
                
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });
  });

  group('Format Comparisons', () {
    test('FluidLayoutFormat and BootstrapLayoutFormat should have same breakpoints', () {
      final fluid = FluidLayoutFormat();
      final bootstrap = BootstrapLayoutFormat();

      for (final breakpoint in LayoutBreakpoint.values) {
        expect(
          fluid.breakpoints[breakpoint],
          equals(bootstrap.breakpoints[breakpoint]),
        );
      }
    });

    test('all formats should use logical pixels except PortraitTablet', () {
      final fluid = FluidLayoutFormat();
      final bootstrap = BootstrapLayoutFormat();
      final portrait = PortraitTabletLayoutFormat();

      expect(fluid.pixel, LayoutPixelFormat.logical);
      expect(bootstrap.pixel, LayoutPixelFormat.logical);
      expect(portrait.pixel, LayoutPixelFormat.physical);
    });

    test('PortraitTabletLayoutFormat should have larger breakpoint values', () {
      final bootstrap = BootstrapLayoutFormat();
      final portrait = PortraitTabletLayoutFormat();

      for (final breakpoint in LayoutBreakpoint.values) {
        expect(
          portrait.breakpoints[breakpoint]! > bootstrap.breakpoints[breakpoint]!,
          isTrue,
          reason: 'Portrait tablet $breakpoint should be larger than bootstrap',
        );
      }
    });
  });
}
