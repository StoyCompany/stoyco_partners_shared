import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';

mixin LayoutValueMixin<T> {
  T resolveForLayout(LayoutContext layout);

  T resolve(BuildContext context) {
    final LayoutData layout = Layout.of(context);
    return resolveForLayout(layout);
  }
}

typedef LayoutValueBuilder<T> = T Function(LayoutContext layout);

/// A responsive value that adapts dynamically to the width of the screen.
///
/// The `valueBuilder` callback returns the responsive value for a given container
/// width.
///
/// ```
/// final isTablet = FluidValue.fromWidth((containerWidth) {
///     return containerWidth >= 600;
/// });
/// ```
///
/// Calculating the responsive values is usually done by this library automatically
/// but it can also be calculated with the following methods:
/// To get the value for a given width screen use the method `resolveForWidth`.
/// If there is a [Layout] inside the widget you can also use `resolveForContext`
/// that will automatically calulate the value for the container width provided by
/// the closest Layout inside the upper widget tree from the `context` referenced
/// provided as param.
///
/// See also:
///   - [BreakpointValue], a value that adapts dinamically to relative width
///     screen breakpoints
abstract class LayoutValue<T> with LayoutValueMixin<T> {
  factory LayoutValue({required T xs, T? sm, T? md, T? lg, T? xl}) =
      BreakpointValue<T>;
  factory LayoutValue.builder(LayoutValueBuilder<T> builder) =
      _DefaultLayoutValue<T>;
  factory LayoutValue.value(T value) = ConstantLayoutValue<T>;

  static const _ScreenWidthValue screenWidth = _ScreenWidthValue();
}

abstract class BaseLayoutValue<T> implements LayoutValue<T> {
  const BaseLayoutValue();

  @override
  T resolve(BuildContext context) {
    final LayoutData layout = Layout.of(context);
    return resolveForLayout(layout);
  }
}

class _DefaultLayoutValue<T> extends BaseLayoutValue<T> {
  const _DefaultLayoutValue(this.builder);
  final LayoutValueBuilder<T> builder;

  @override
  T resolveForLayout(LayoutContext layout) => builder(layout);
}

/// A responsive value that adapts dynamically dinamically to relative width
/// screen breakpoints
///
/// ```
/// final cellCount = BreakpointValue(xs: 1, s: 2, sm: 4, lg: 20);
/// ```
///
/// This class is not usually used directly and if you are using [Layout],
/// it is recommended to use the `context.layout.value(xs: 1, s: 2, sm: 4, lg: 20);`
/// to get directly the responsive value.
///
/// Calculating the responsive values is usually done by this library automatically
/// but it can also be calculated with the following methods:
/// To get the value for a given breakpoint use the method `resolveForBreakpoint`.
/// If there is a [Layout] inside the widget you can also use `resolve(context)`
/// that will automatically calulate the value for the container width provided by
/// the closest `Layout` inside the upper widget tree from the `context` referenced
/// provided as param.
///
/// See also:
///   - [BreakpointValue], a value that adapts dinamically to relative width
///     screen breakpoints
class BreakpointValue<T> extends BaseLayoutValue<T> {
  const BreakpointValue({required this.xs, this.sm, this.md, this.lg, this.xl});

  const BreakpointValue.all({
    required T xs,
    required T sm,
    required T md,
    required T lg,
    required T xl,
  }) : this.xs = xs,
       this.sm = sm,
       this.md = md,
       this.lg = lg,
       this.xl = xl;

  BreakpointValue.fromMap(Map<LayoutBreakpoint, T> values, [T? defaultValue])
    : assert(
        values.length == LayoutBreakpoint.values.length || defaultValue != null,
        'A default value is required if there is not a value asigned to a breakpoint inside the map',
      ),
      this.xs = values[LayoutBreakpoint.xs] ?? defaultValue!,
      this.sm = values[LayoutBreakpoint.sm],
      this.md = values[LayoutBreakpoint.md],
      this.lg = values[LayoutBreakpoint.lg],
      this.xl = values[LayoutBreakpoint.xl];
  final T xs;
  final T? sm;
  final T? md;
  final T? lg;
  final T? xl;

  T resolveForBreakpoint(LayoutBreakpoint breakpoint) {
    switch (breakpoint) {
      case LayoutBreakpoint.xs:
        return xs;
      case LayoutBreakpoint.sm:
        return sm ?? xs;
      case LayoutBreakpoint.md:
        return md ?? sm ?? xs;
      case LayoutBreakpoint.lg:
        return lg ?? md ?? sm ?? xs;
      case LayoutBreakpoint.xl:
        return xl ?? lg ?? md ?? sm ?? xs;
    }
  }

  @override
  T resolveForLayout(LayoutContext layout) {
    return resolveForBreakpoint(layout.breakpoint);
  }
}

class ConstantLayoutValue<T> extends BaseLayoutValue<T> {
  const ConstantLayoutValue(this.value);
  final T value;

  @override
  T resolveForLayout(LayoutContext layout) => value;
}

class _ScreenWidthValue extends BaseLayoutValue<double> {
  const _ScreenWidthValue();

  @override
  double resolveForLayout(LayoutContext layout) => layout.width;
}
