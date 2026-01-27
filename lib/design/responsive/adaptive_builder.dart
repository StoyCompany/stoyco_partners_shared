
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';

/// Define un tipo de función que construye un widget basado en el contexto de construcción,
/// el contexto de diseño y un widget hijo opcional.
typedef LayoutWidgetBuilder = Widget Function(
  BuildContext context,
  LayoutContext layout,
  Widget? child,
);

/// AdaptiveBuilder es un widget que construye su contenido de manera adaptativa
/// basado en los puntos de quiebre definidos en el diseño.
/// Permite definir diferentes constructores de widgets para diferentes tamaños de pantalla.
class AdaptiveBuilder extends StatelessWidget {
  /// Constructor que acepta diferentes constructores de widgets para diferentes puntos de quiebre.
  AdaptiveBuilder({
    super.key,
    required WidgetBuilder xs,
    WidgetBuilder? sm,
    WidgetBuilder? md,
    WidgetBuilder? lg,
    WidgetBuilder? xl,
  })  : child = BreakpointValue<Widget Function(BuildContext)>(xs: xs, sm: sm, md: md, lg: lg, xl: xl);

  /// Constructor que acepta un constructor de widget basado en el contexto de diseño.
  AdaptiveBuilder.builder({
    super.key,
    required LayoutWidgetBuilder builder,
    Widget? child,
  })  : child = LayoutValue<Widget Function(BuildContext)>.builder((LayoutContext layoutContext) {
    return (BuildContext context) => builder(context, layoutContext, child);
  });

  /// Constructor que acepta un valor de diseño crudo.
  const AdaptiveBuilder.raw({super.key, required this.child});
  /// Valor de diseño que contiene los constructores de widgets para diferentes puntos de quiebre.
  final LayoutValue<WidgetBuilder> child;

  @override
  Widget build(BuildContext context) {
    return context.layout.resolve(child)(context);
  }
}
