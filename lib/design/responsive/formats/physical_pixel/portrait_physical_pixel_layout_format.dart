import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

class PortraitPhysicalPixelLayoutFormat extends LayoutFormat {
  PortraitPhysicalPixelLayoutFormat({
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
    LayoutBreakpoint.xs: 480, // FWVGA
    LayoutBreakpoint.sm: 720, // HD
    LayoutBreakpoint.md: 1080, // FHD
    LayoutBreakpoint.lg: 1440, //
    LayoutBreakpoint.xl: 1768, // QHD
  };

  @override
  final LayoutValue<double> maxWidth = const BreakpointValue<double>.all(
    xs: 480,
    sm: 720,
    md: 1080,
    lg: 1125,
    xl: 1440,
  );
}
