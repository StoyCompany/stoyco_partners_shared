import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/physical_pixel/landscape_physical_pixel_layout_format.dart';
import 'package:stoyco_partners_shared/design/responsive/formats/physical_pixel/portrait_physical_pixel_layout_format.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

void main() {
  group('PortraitPhysicalPixelLayoutFormat', () {
    test('should create format with default margin and gutter', () {
      final format = PortraitPhysicalPixelLayoutFormat();

      expect(format.pixel, LayoutPixelFormat.physical);
      expect(format.margin, isA<ConstantLayoutValue<double>>());
      expect(format.gutter, isA<ConstantLayoutValue<double>>());
    });

    test('should create format with custom margin and gutter', () {
      final customMargin = const ConstantLayoutValue<double>(16.0);
      final customGutter = const ConstantLayoutValue<double>(8.0);

      final format = PortraitPhysicalPixelLayoutFormat(
        margin: customMargin,
        gutter: customGutter,
      );

      expect(format.margin, equals(customMargin));
      expect(format.gutter, equals(customGutter));
    });

    test('should have correct breakpoints for portrait physical pixels', () {
      final format = PortraitPhysicalPixelLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 480); // FWVGA
      expect(format.breakpoints[LayoutBreakpoint.sm], 720); // HD
      expect(format.breakpoints[LayoutBreakpoint.md], 1080); // FHD
      expect(format.breakpoints[LayoutBreakpoint.lg], 1440);
      expect(format.breakpoints[LayoutBreakpoint.xl], 1768); // QHD
    });

    test('should have correct maxWidth values', () {
      final format = PortraitPhysicalPixelLayoutFormat();

      expect(format.maxWidth, isA<BreakpointValue<double>>());
    });

    test('should resolve breakpoints correctly for different widths', () {
      final format = PortraitPhysicalPixelLayoutFormat();

      expect(format.breakpointForWidth(400), LayoutBreakpoint.xs);
      expect(format.breakpointForWidth(600), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(900), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(1300), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(1800), LayoutBreakpoint.xl);
    });
  });

  group('LandscapePhysicalPixelLayoutFormat', () {
    test('should create format with default margin and gutter', () {
      final format = LandscapePhysicalPixelLayoutFormat();

      expect(format.pixel, LayoutPixelFormat.physical);
      expect(format.margin, isA<ConstantLayoutValue<double>>());
      expect(format.gutter, isA<ConstantLayoutValue<double>>());
    });

    test('should create format with custom margin and gutter', () {
      final customMargin = const ConstantLayoutValue<double>(20.0);
      final customGutter = const ConstantLayoutValue<double>(12.0);

      final format = LandscapePhysicalPixelLayoutFormat(
        margin: customMargin,
        gutter: customGutter,
      );

      expect(format.margin, equals(customMargin));
      expect(format.gutter, equals(customGutter));
    });

    test('should have correct breakpoints for landscape physical pixels', () {
      final format = LandscapePhysicalPixelLayoutFormat();

      expect(format.breakpoints[LayoutBreakpoint.xs], 854); // FWVGA
      expect(format.breakpoints[LayoutBreakpoint.sm], 1180); // HD
      expect(format.breakpoints[LayoutBreakpoint.md], 1920); // FHD
      expect(format.breakpoints[LayoutBreakpoint.lg], 2260);
      expect(format.breakpoints[LayoutBreakpoint.xl], 2960); // QHD
    });

    test('should have correct maxWidth values for landscape', () {
      final format = LandscapePhysicalPixelLayoutFormat();

      expect(format.maxWidth, isA<BreakpointValue<double>>());
    });

    test('should resolve breakpoints correctly for landscape widths', () {
      final format = LandscapePhysicalPixelLayoutFormat();

      expect(format.breakpointForWidth(800), LayoutBreakpoint.xs);
      expect(format.breakpointForWidth(1100), LayoutBreakpoint.sm);
      expect(format.breakpointForWidth(1500), LayoutBreakpoint.md);
      expect(format.breakpointForWidth(2300), LayoutBreakpoint.lg);
      expect(format.breakpointForWidth(3000), LayoutBreakpoint.xl);
    });

    test('landscape should have larger breakpoints than portrait', () {
      final portrait = PortraitPhysicalPixelLayoutFormat();
      final landscape = LandscapePhysicalPixelLayoutFormat();

      for (final breakpoint in LayoutBreakpoint.values) {
        expect(
          landscape.breakpoints[breakpoint]! > portrait.breakpoints[breakpoint]!,
          isTrue,
          reason: 'Landscape $breakpoint should be larger than portrait',
        );
      }
    });

    test('both formats should use physical pixels', () {
      final portrait = PortraitPhysicalPixelLayoutFormat();
      final landscape = LandscapePhysicalPixelLayoutFormat();

      expect(portrait.pixel, LayoutPixelFormat.physical);
      expect(landscape.pixel, LayoutPixelFormat.physical);
    });
  });
}
