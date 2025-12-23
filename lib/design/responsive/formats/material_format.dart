import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

class MaterialLayoutFormat extends LayoutFormat {
  MaterialLayoutFormat({
    LayoutValue<double>? margin,
    LayoutValue<double>? gutter,
  }) : margin = margin ?? _defaultMargin,
       gutter = gutter ?? _defaultMargin;

  @override
  final LayoutPixelFormat pixel = LayoutPixelFormat.logical;

  @override
  final LayoutValue<double> gutter;

  @override
  final LayoutValue<double> margin;

  static final LayoutValue<double> _defaultMargin = LayoutValue<double>.builder(
    (LayoutContext layout) {
      return layout.width <= 719 ? 16 : 24;
    },
  );

  @override
  final Map<LayoutBreakpoint, double> breakpoints = <LayoutBreakpoint, double>{
    LayoutBreakpoint.xs: 0,
    LayoutBreakpoint.sm: 600,
    LayoutBreakpoint.md: 1024,
    LayoutBreakpoint.lg: 1440,
    LayoutBreakpoint.xl: 1920,
  };

  @override
  final LayoutValue<double> maxWidth = const BreakpointValue<double>.all(
    xs: 600,
    sm: 540,
    md: 720,
    lg: 960,
    xl: 1140,
  );

  @override
  final LayoutValue<int> columns = LayoutValue<int>.builder((
    LayoutContext layout,
  ) {
    final double width = layout.width;
    if (width <= 599) {
      return 4;
    } else if (width <= 839) {
      return 8;
    } else {
      return 12;
    }
  });
}
