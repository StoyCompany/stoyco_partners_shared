import 'package:flutter/material.dart';

/// Extensión sobre BuildContext para proporcionar valores responsivos basados en el tamaño de la pantalla.
extension ResponsiveContext on BuildContext {
  /// Devuelve un valor basado en el tamaño de la pantalla.
  ///
  /// Parámetros:
  /// - `mobile`: Valor para pantallas móviles.
  /// - `tablet`: Valor opcional para pantallas de tabletas.
  /// - `desktop`: Valor opcional para pantallas de escritorio.
  /// - `watch`: Valor opcional para pantallas de relojes.
  ///
  /// El valor devuelto se determina en función del ancho más corto de la pantalla.
  /// Si el ancho más corto es mayor o igual a 1200, se devuelve el valor de `desktop` si está disponible.
  /// Si el ancho más corto es mayor o igual a 600, se devuelve el valor de `tablet` si está disponible.
  /// Si el ancho más corto es menor a 300, se devuelve el valor de `watch` si está disponible.
  /// En cualquier otro caso, se devuelve el valor de `mobile`.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? watch,
  }) {
    final double deviceWidth = MediaQuery.of(this).size.shortestSide;

    if (isDesktop) {
      final double fullWidth = MediaQuery.of(this).size.width;
      if (fullWidth >= 1200 && desktop != null) {
        return desktop;
      }
    }

    if (deviceWidth >= 1200 && desktop != null) {
      return desktop;
    } else if (deviceWidth >= 600 && tablet != null) {
      return tablet;
    } else if (deviceWidth < 300 && watch != null) {
      return watch;
    } else {
      return mobile;
    }
  }

  /// Verifica si la plataforma actual es una plataforma de escritorio.
  bool get isDesktop {
    final TargetPlatform platform = Theme.of(this).platform;
    return platform == TargetPlatform.macOS || platform == TargetPlatform.windows || platform == TargetPlatform.linux;
  }
}
