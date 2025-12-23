import 'dart:math';

import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/format.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';
import 'package:stoyco_partners_shared/design/responsive/pixel.dart';
import 'package:stoyco_partners_shared/design/responsive/value.dart';

class FluidLayoutFormat extends LayoutFormat {
  FluidLayoutFormat({LayoutValue<double>? margin})
    : margin = margin ?? _defaultMargin;

  @override
  final LayoutPixelFormat pixel = LayoutPixelFormat.logical;

  @override
  LayoutValue<double> get maxWidth {
    return LayoutValue<double>.builder((LayoutContext layout) {
      final double width = layout.width;
      final LayoutBreakpoint breakpoint = breakpointForWidth(width);
      switch (breakpoint) {
        case LayoutBreakpoint.xs:
          return min(width, maxFluidWidth[breakpoint]!);
        case LayoutBreakpoint.sm:
        case LayoutBreakpoint.md:
        case LayoutBreakpoint.lg:
          return calculateFluidWidth(breakpoint, width);
        case LayoutBreakpoint.xl:
          return maxFluidWidth[breakpoint]!;
      }
    });
  }

  double calculateFluidWidth(LayoutBreakpoint breakpoint, double layoutWidth) {
    //Distance to next width breakpoint
    final double width = breakpoints[breakpoint] ?? layoutWidth;

    final double currentDistance = width - layoutWidth;

    final double totalDistance = width - breakpoints[breakpoint.smaller]!;

    final double totalFluidDistance =
        maxFluidWidth[breakpoint]! - maxFluidWidth[breakpoint.smaller]!;
    final double progress = currentDistance / totalDistance;
    final double maxFluid =
        maxFluidWidth[breakpoint.bigger]! - totalFluidDistance * progress;
    return maxFluid;
  }

  @override
  LayoutValue<double> get gutter {
    const double spacer = 16;
    return const BreakpointValue<double>.all(
      xs: spacer * 1,
      sm: spacer * 1.25,
      md: spacer * 1.5,
      lg: spacer * 2,
      xl: spacer * 3,
    );
  }

  @override
  LayoutValue<int> get columns => const ConstantLayoutValue<int>(12);

  @override
  final LayoutValue<double> margin;

  static final LayoutValue<double> _defaultMargin = LayoutValue<double>.builder(
    (LayoutContext layout) {
      return layout.width <= 719 ? 16 : 24;
    },
  );

  @override
  Map<LayoutBreakpoint, double> get breakpoints => <LayoutBreakpoint, double>{
    LayoutBreakpoint.xs: 0,
    LayoutBreakpoint.sm: 576,
    LayoutBreakpoint.md: 768,
    LayoutBreakpoint.lg: 992,
    LayoutBreakpoint.xl: 1200,
  };

  Map<LayoutBreakpoint, double> get maxFluidWidth => <LayoutBreakpoint, double>{
    LayoutBreakpoint.xs: 540,
    LayoutBreakpoint.sm: 540,
    LayoutBreakpoint.md: 720,
    LayoutBreakpoint.lg: 960,
    LayoutBreakpoint.xl: 1140,
  };
}
