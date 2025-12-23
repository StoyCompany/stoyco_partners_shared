import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';

/// A widget that adds a padding to its child. This
/// padding is calculated by `Layout` and can be overridden
/// by the margin param
///
/// See also:
///  - [SliverMargin] An equivalent to be used inside CustomScrollView
class Margin extends StatelessWidget {
  const Margin({super.key, required this.child, this.margin});

  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding(layout: context.layout, margin: margin),
      child: child,
    );
  }

  static EdgeInsets _padding({
    required LayoutData layout,
    bool fluid = false,
    EdgeInsets? margin,
    double? maxWidth,
  }) {
    EdgeInsets padding =
        margin ?? EdgeInsets.symmetric(horizontal: layout.margin);
    if (fluid) {
      if (maxWidth != null) {
        final double fluidMargin = (layout.size.width - maxWidth) / 2;
        padding += EdgeInsets.symmetric(horizontal: fluidMargin);
      } else {
        padding += EdgeInsets.symmetric(horizontal: layout.fluidMargin);
      }
    }
    return padding;
  }
}

/// A widget that adds a padding to its sliver child. This
/// padding is calculated by `Layout` and can be overrided
/// by the margin param
///
/// See also:
///  - [Margin] An equivalent to be used outside CustomScrollView
class SliverMargin extends SingleChildRenderObjectWidget {
  const SliverMargin({super.key, required Widget sliver, this.margin})
    : super(child: sliver);
  final EdgeInsets? margin;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      margin: margin,
    );
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverPadding renderObject,
  ) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      fluid: false,
      margin: margin,
    );

    renderObject
      ..padding = padding
      ..textDirection = Directionality.of(context);
  }
}

/// A widget that adds a fluid padding to its child. This padding has the goal
/// to constrain the child to a given max width according to the screen size
///
/// This padding is calculated by [Layout]. It also containes the relative
/// margin provided by the [Margin] widget and this can be overrided
/// with the margin param.
///
/// See also:
///  - [SliverFluidMargin] An equitvalent to be used inside CustomScrollView
class FluidMargin extends StatelessWidget {
  const FluidMargin({
    super.key,
    required this.child,
    this.margin,
    this.fluid = true,
    this.maxWidth,
  });
  final Widget child;
  final bool fluid;
  final double? maxWidth;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Margin._padding(
        layout: context.layout,
        fluid: fluid,
        margin: margin,
        maxWidth: maxWidth,
      ),
      child: child,
    );
  }
}

/// Equivalent of [FluidMargin] for sliver widgets
class SliverFluidMargin extends SingleChildRenderObjectWidget {
  const SliverFluidMargin({
    super.key,
    required Widget sliver,
    this.margin,
    this.fluid = true,
    this.maxWidth,
  }) : super(child: sliver);
  final double? maxWidth;
  final EdgeInsets? margin;
  final bool fluid;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      fluid: fluid,
      margin: margin,
      maxWidth: maxWidth,
    );
    return RenderSliverPadding(
      padding: padding,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverPadding renderObject,
  ) {
    final EdgeInsets padding = Margin._padding(
      layout: context.layout,
      fluid: fluid,
      margin: margin,
      maxWidth: maxWidth,
    );

    renderObject
      ..padding = padding
      ..textDirection = Directionality.of(context);
  }
}

class SliverFluidBox extends StatelessWidget {
  const SliverFluidBox({
    super.key,
    this.child,
    this.margin,
    this.fluid = true,
    this.maxWidth,
  });
  final Widget? child;
  final double? maxWidth;
  final EdgeInsets? margin;
  final bool fluid;

  @override
  Widget build(BuildContext context) {
    return SliverFluidMargin(
      fluid: fluid,
      margin: margin,
      maxWidth: maxWidth,
      sliver: SliverToBoxAdapter(child: child),
    );
  }
}
