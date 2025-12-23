class AppValidators {
  static String? Function(String?) required([String? message]) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message ?? 'Este campo es requerido';
      }
      return null;
    };
  }

  static String? Function(String?) email([String? message]) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
      if (!emailRegex.hasMatch(value)) {
        return message ?? '*Favor ingresar un correo válido';
      }
      return null;
    };
  }

  static String? Function(String?) password([String? message]) {
    return (value) {
      if (value == null || value.isEmpty) return null;

      final lengthOK = value.length >= 8;
      final upperOK = value.contains(RegExp(r'[A-Z]'));
      final lowerOK = value.contains(RegExp(r'[a-z]'));
      final digitOK = value.contains(RegExp(r'\d'));

      if (!(lengthOK && upperOK && lowerOK && digitOK)) {
        return message ?? '*Contraseña incorrecta';
      }
      return null;
    };
  }
}
