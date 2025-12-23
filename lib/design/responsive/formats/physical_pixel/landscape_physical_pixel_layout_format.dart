import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

class LandscapePhysicalPixelLayoutFormat extends LayoutFormat {
  LandscapePhysicalPixelLayoutFormat({
    LayoutValue<double>? margin,
    LayoutValue<double>? gutter,
  }) : margin = margin ?? const ConstantLayoutValue<double>(0),
       gutter = gutter ?? const ConstantLayoutValue<double>(0);

  @override
  final LayoutPixelFormat pixel = LayoutPixelFormat.physical;

  @override
  final LayoutValue<double> gutter;

  @override
  final LayoutValue<double> margin;

  @override
  final Map<LayoutBreakpoint, double> breakpoints = <LayoutBreakpoint, double>{
    LayoutBreakpoint.xs: 854, // FWVGA
    LayoutBreakpoint.sm: 1180, // HD
    LayoutBreakpoint.md: 1920, // FHD
    LayoutBreakpoint.lg: 2260, //
    LayoutBreakpoint.xl: 2960, // QHD
  };

  @override
  final LayoutValue<double> maxWidth = const BreakpointValue<double>.all(
    xs: 854,
    sm: 1180,
    md: 1920,
    lg: 2260,
    xl: 2960,
  );
}
