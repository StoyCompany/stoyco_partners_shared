import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/responsive/layout.dart';

/// Margin es un widget que agrega un padding a su hijo.
/// Este padding es calculado por `Layout` y puede ser sobrescrito
/// por el parámetro `margin`.
///
/// Véase también:
///  - [SliverMargin] Un equivalente para ser usado dentro de CustomScrollView.
class Margin extends StatelessWidget {

  const Margin({
    super.key,
    required this.child,
    this.margin,
  });

  final Widget child;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding(
        layout: context.layout,
        margin: margin,
      ),
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

/// SliverMargin es un widget que agrega un padding a su hijo dentro de un diseño sliver.
/// Este padding es calculado por `Layout` y puede ser sobrescrito
/// por el parámetro `margin`.
class SliverMargin extends SingleChildRenderObjectWidget {

  const SliverMargin({
    super.key,
    required Widget sliver,
    this.margin,
  }) : super(child: sliver);
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
      BuildContext context, RenderSliverPadding renderObject) {
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

/// Un widget que agrega un padding fluido a su hijo. Este padding tiene como objetivo
/// restringir el hijo a un ancho máximo dado según el tamaño de la pantalla.
///
/// Este padding es calculado por [Layout]. También contiene el margen relativo
/// proporcionado por el widget [Margin] y este puede ser sobrescrito
/// con el parámetro margin.
///
/// Véase también:
///  - [SliverFluidMargin] Un equivalente para ser usado dentro de CustomScrollView
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
      BuildContext context, RenderSliverPadding renderObject) {
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
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}
