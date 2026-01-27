import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/layout_all_imports.dart';

/// LayoutFormat es una clase base abstracta que define el formato de diseño para diferentes tamaños de pantalla.
/// Proporciona métodos y propiedades que deben ser implementados por las subclases para definir el comportamiento específico del diseño.
abstract class LayoutFormat {
  const LayoutFormat();

  /// El tamaño del medio en píxeles lógicos (por ejemplo, el tamaño de la pantalla).
  /// Los píxeles lógicos tienen aproximadamente el mismo tamaño visual en todos los dispositivos.
  /// Los píxeles físicos son el tamaño de los píxeles de hardware reales en el dispositivo.
  /// Un [pixel] define si se deben usar píxeles físicos o lógicos.
  LayoutPixelFormat get pixel => LayoutPixelFormat.physical;

  /// Un punto de quiebre es el rango de tamaños de pantalla predeterminados que tienen
  /// requisitos de diseño específicos. En un rango de punto de quiebre dado, el diseño se ajusta
  /// para adaptarse al tamaño y la orientación de la pantalla.
  Map<LayoutBreakpoint, double> get breakpoints => const <LayoutBreakpoint, double>{};

  /// El contenido se coloca en las áreas de la pantalla que contienen columnas.
  /// El ancho de las columnas se define utilizando porcentajes, en lugar de valores fijos,
  /// para permitir que el contenido se adapte de manera flexible a cualquier tamaño de pantalla.
  /// El número de columnas que se muestran en la cuadrícula está determinado por el
  /// rango de puntos de quiebre (un rango de tamaños de pantalla predeterminados) en el que se ve una pantalla,
  /// ya sea un punto de quiebre para móvil, tableta u otro tamaño.
  LayoutValue<int> get columns => const ConstantLayoutValue<int>(12);

  /// Los gutters son los espacios entre columnas. Ayudan a separar el contenido.
  /// Los anchos de los gutters son valores fijos en cada rango de puntos de quiebre.
  /// Para adaptarse mejor a la pantalla, el ancho del gutter puede cambiar en diferentes puntos de quiebre.
  /// Los gutters más anchos son más apropiados para pantallas más grandes, ya que crean más espacio en blanco entre columnas.
  LayoutValue<double> get gutter => const ConstantLayoutValue<double>(0);

  /// Los márgenes son el espacio entre el contenido y los bordes izquierdo y derecho de la pantalla.
  /// Los anchos de los márgenes se definen como valores fijos en cada rango de puntos de quiebre.
  /// Para adaptarse mejor a la pantalla, el ancho del margen puede cambiar en diferentes puntos de quiebre.
  /// Los márgenes más anchos son más apropiados para pantallas más grandes, ya que crean más espacio en blanco alrededor del perímetro del contenido.
  LayoutValue<double> get margin => const ConstantLayoutValue<double>(0);

  /// Ancho máximo permitido en el widget de ancho fijo.
  LayoutValue<double> get maxWidth => LayoutValue.screenWidth;

  VisualDensity visualDensity(BuildContext context) {
    return Theme.of(context).visualDensity;
  }

  Size resolveSize(Size layoutSize, MediaQueryData mediaQuery) {
    switch (pixel) {
      case LayoutPixelFormat.logical:
        return layoutSize;
      case LayoutPixelFormat.physical:
        return layoutSize * mediaQuery.devicePixelRatio;
    }
  }

  LayoutData resolve(
    Size layoutSize,
    MediaQueryData mediaQuery,
    VisualDensity visualDensity,
  ) {
    final double width = layoutSize.width;
    final LayoutContext context = LayoutContext(
        size: layoutSize,
        breakpoint: breakpointForWidth(layoutSize.width),
        devicePixelRatio: mediaQuery.devicePixelRatio,
        visualDensity: visualDensity);
    final double maxWidth = min(width, this.maxWidth.resolveForLayout(context));
    final double spacing = gutter.resolveForLayout(context);
    final double margin = this.margin.resolveForLayout(context);
    final int columns = this.columns.resolveForLayout(context);
    return LayoutData(
      format: this,
      margin: margin,
      size: layoutSize,
      maxWidth: maxWidth,
      gutter: spacing,
      columns: columns,
      breakpoint: context.breakpoint,
      devicePixelRatio: context.devicePixelRatio,
      visualDensity: visualDensity,
    );
  }

  @protected
  LayoutBreakpoint breakpointForWidth(double width) {
    // Itera todos los puntos de quiebre de mayor a menor
    for (final LayoutBreakpoint breakpoint in LayoutBreakpoint.values.reversed) {
      if (breakpoints[breakpoint] != null &&
          width >= breakpoints[breakpoint]!) {
        return breakpoint;
      }
    }
    return LayoutBreakpoint.xs;
  }
}
