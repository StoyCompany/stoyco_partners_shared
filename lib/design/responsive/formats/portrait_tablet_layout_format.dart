import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

class PortraitTabletLayoutFormat extends LayoutFormat {
  PortraitTabletLayoutFormat();

  @override
  LayoutPixelFormat get pixel => LayoutPixelFormat.physical;

  @override
  Map<LayoutBreakpoint, double> get breakpoints => <LayoutBreakpoint, double>{
    LayoutBreakpoint.xs: 720, // HD
    LayoutBreakpoint.sm: 1080, // FHD
    LayoutBreakpoint.md: 1125, // iPhone 11 Pro
    LayoutBreakpoint.lg: 1440, // QHD
    LayoutBreakpoint.xl: 2160, //  4K
  };

  @override
  LayoutValue<double> get maxWidth => const BreakpointValue<double>.all(
    xs: 720,
    sm: 1080,
    md: 1125,
    lg: 1440,
    xl: 2160,
  );
}
