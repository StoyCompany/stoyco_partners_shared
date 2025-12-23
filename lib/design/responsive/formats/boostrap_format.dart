import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

class BootstrapLayoutFormat extends LayoutFormat {
  BootstrapLayoutFormat({LayoutValue<double>? margin})
    : margin = margin ?? const ConstantLayoutValue<double>(0);

  @override
  final LayoutPixelFormat pixel = LayoutPixelFormat.logical;

  @override
  final LayoutValue<double> gutter = const ConstantLayoutValue<double>(30.0);

  @override
  final LayoutValue<double> margin;

  @override
  Map<LayoutBreakpoint, double> get breakpoints => <LayoutBreakpoint, double>{
    LayoutBreakpoint.xs: 0,
    LayoutBreakpoint.sm: 576,
    LayoutBreakpoint.md: 768,
    LayoutBreakpoint.lg: 992,
    LayoutBreakpoint.xl: 1200,
  };

  @override
  final LayoutValue<double> maxWidth = const BreakpointValue<double>.all(
    xs: 576, // Always maxWitdh == width
    sm: 540,
    md: 720,
    lg: 960,
    xl: 1140,
  );
}
