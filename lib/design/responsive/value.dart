
import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';

mixin LayoutValueMixin<T> {
  T resolveForLayout(LayoutContext layout);

  T resolve(BuildContext context) {
    final LayoutData layout = Layout.of(context);
    return resolveForLayout(layout);
  }
}

typedef LayoutValueBuilder<T> = T Function(LayoutContext layout);

/// Un valor responsivo que se adapta dinámicamente al ancho de la pantalla.
///
/// El callback `valueBuilder` devuelve el valor responsivo para un ancho de contenedor dado.
///
/// ```
/// final isTablet = FluidValue.fromWidth((containerWidth) {
///     return containerWidth >= 600;
/// });
/// ```
///
/// Calcular los valores responsivos generalmente se hace automáticamente por esta biblioteca,
/// pero también se puede calcular con los siguientes métodos:
/// Para obtener el valor para un ancho de pantalla dado, use el método `resolveForWidth`.
/// Si hay un [Layout] dentro del widget, también puede usar `resolveForContext`
/// que calculará automáticamente el valor para el ancho del contenedor proporcionado por
/// el Layout más cercano dentro del árbol de widgets superior desde el `context` proporcionado como parámetro.
///
/// Véase también:
///   - [BreakpointValue], un valor que se adapta dinámicamente a los puntos de quiebre de ancho relativo de la pantalla.
abstract class LayoutValue<T> with LayoutValueMixin<T> {
  factory LayoutValue({
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
  }) = BreakpointValue<T>;
  factory LayoutValue.builder(LayoutValueBuilder<T> builder) = _DefaultLayoutValue<T>;
  factory LayoutValue.value(T value) = ConstantLayoutValue<T>;

  static const ScreenWidthValue screenWidth = ScreenWidthValue();
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

/// Un valor responsivo que se adapta dinámicamente a los puntos de quiebre de ancho relativo de la pantalla.
///
/// ```
/// final cellCount = BreakpointValue(xs: 1, s: 2, sm: 4, lg: 20);
/// ```
///
/// Esta clase generalmente no se usa directamente y si está utilizando [Layout],
/// se recomienda usar `context.layout.value(xs: 1, s: 2, sm: 4, lg: 20);`
/// para obtener directamente el valor responsivo.
///
/// Calcular los valores responsivos generalmente se hace automáticamente por esta biblioteca,
/// pero también se puede calcular con los siguientes métodos:
/// Para obtener el valor para un punto de quiebre dado, use el método `resolveForBreakpoint`.
/// Si hay un [Layout] dentro del widget, también puede usar `resolve(context)`
/// que calculará automáticamente el valor para el ancho del contenedor proporcionado por
/// el Layout más cercano dentro del árbol de widgets superior desde el `context` proporcionado como parámetro.
///
/// Véase también:
///   - [BreakpointValue], un valor que se adapta dinámicamente a los puntos de quiebre de ancho relativo de la pantalla.
class BreakpointValue<T> extends BaseLayoutValue<T> {
  const BreakpointValue({
    required this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  const BreakpointValue.all({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  BreakpointValue.fromMap(Map<LayoutBreakpoint, T> values, [T? defaultValue])
      : assert(values.length == LayoutBreakpoint.values.length || defaultValue != null, 'Se requiere un valor predeterminado si no hay un valor asignado a un punto de quiebre dentro del mapa'),
        xs = values[LayoutBreakpoint.xs] ?? defaultValue!,
        sm = values[LayoutBreakpoint.sm],
        md = values[LayoutBreakpoint.md],
        lg = values[LayoutBreakpoint.lg],
        xl = values[LayoutBreakpoint.xl];

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

/// Un valor constante de diseño.
class ConstantLayoutValue<T> extends BaseLayoutValue<T> {
  const ConstantLayoutValue(this.value);
  final T value;

  @override
  T resolveForLayout(LayoutContext layout) => value;
}

/// Un valor de ancho de pantalla.
class ScreenWidthValue extends BaseLayoutValue<double> {
  const ScreenWidthValue();

  @override
  double resolveForLayout(LayoutContext layout) => layout.width;
}
