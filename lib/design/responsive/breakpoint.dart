/// Enum que define los puntos de quiebre (breakpoints) para diferentes tamaños de pantalla.
enum LayoutBreakpoint {
  xs, // Extra Small Screens
  sm, // Small Screen
  md, // Small Screen
  lg, // Medium Screens
  xl, // Medium Screens
}

/// Extensión sobre LayoutBreakpoint para proporcionar métodos adicionales.
extension LayoutBreakpointExtension on LayoutBreakpoint {
  /// Devuelve el punto de quiebre más pequeño que el actual.
  LayoutBreakpoint? get smaller {
    return <LayoutBreakpoint, LayoutBreakpoint?>{
      LayoutBreakpoint.xs: null,
      LayoutBreakpoint.sm: LayoutBreakpoint.xs,
      LayoutBreakpoint.md: LayoutBreakpoint.sm,
      LayoutBreakpoint.lg: LayoutBreakpoint.md,
      LayoutBreakpoint.xl: LayoutBreakpoint.lg
    }[this];
  }

  /// Devuelve el punto de quiebre más grande que el actual.
  LayoutBreakpoint? get bigger {
    return <LayoutBreakpoint, LayoutBreakpoint?>{
      LayoutBreakpoint.xs: LayoutBreakpoint.sm,
      LayoutBreakpoint.sm: LayoutBreakpoint.md,
      LayoutBreakpoint.md: LayoutBreakpoint.lg,
      LayoutBreakpoint.lg: LayoutBreakpoint.xl,
      LayoutBreakpoint.xl: null,
    }[this];
  }

  /// Verifica si el punto de quiebre actual es xs (Extra Small).
  bool get isXs => LayoutBreakpoint.xs == this;

  /// Verifica si el punto de quiebre actual es sm (Small).
  bool get isSm => LayoutBreakpoint.sm == this;

  /// Verifica si el punto de quiebre actual es md (Medium).
  bool get isMd => LayoutBreakpoint.md == this;

  /// Verifica si el punto de quiebre actual es lg (Large).
  bool get isLg => LayoutBreakpoint.lg == this;

  /// Verifica si el punto de quiebre actual es xl (Extra Large).
  bool get isXl => LayoutBreakpoint.xl == this;

  bool operator <(LayoutBreakpoint breakpoint) => index < breakpoint.index;
  bool operator >(LayoutBreakpoint breakpoint) => index > breakpoint.index;
  bool operator <=(LayoutBreakpoint breakpoint) => index <= breakpoint.index;
  bool operator >=(LayoutBreakpoint breakpoint) => index >= breakpoint.index;
}
