final class NumbersFormat {
  const NumbersFormat._();

  static String formatCompact(double number, {int decimals = 1}) {
    if (number < 0) {
      return '-${formatCompact(number.abs(), decimals: decimals)}';
    }

    if (number >= 1000000000) {
      final double value = number / 1000000000;
      return _formatValue(value, 'mm', decimals);
    }

    if (number >= 1000000) {
      final double value = number / 1000000;
      return _formatValue(value, 'm', decimals);
    }

    if (number >= 1000) {
      final double value = number / 1000;
      return _formatValue(value, 'k', decimals);
    }

    return number.toStringAsFixed(0);
  }

  static String formatWithCommas(double number, {int decimals = 0}) {
    final bool isNegative = number < 0;
    final double absNumber = number.abs();
    
    // Usar toString() y parsearlo manualmente para evitar problemas de localización
    final String numberStr = absNumber.toString();
    
    // Separar parte entera y decimal
    final List<String> parts = numberStr.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';
    
    // Si necesitamos decimales, ajustar la parte decimal
    if (decimals > 0) {
      if (decimalPart.length < decimals) {
        decimalPart = decimalPart.padRight(decimals, '0');
      } else if (decimalPart.length > decimals) {
        // Redondear manualmente
        final double rounded = double.parse('0.$decimalPart');
        final double roundedValue = double.parse((rounded * (decimals == 0 ? 1 : 10)).toStringAsFixed(decimals));
        decimalPart = roundedValue.toString().split('.').last.padRight(decimals, '0');
      }
    } else {
      // Sin decimales, redondear la parte entera si es necesario
      integerPart = absNumber.round().toString();
      decimalPart = '';
    }
    
    final StringBuffer buffer = StringBuffer();
    int count = 0;
    
    for (int i = integerPart.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
      count++;
    }
    
    final String formattedInteger = buffer.toString().split('').reversed.join('');
    
    String result = formattedInteger;
    if (decimals > 0 && decimalPart.isNotEmpty) {
      result += '.$decimalPart';
    }
    
    return isNegative ? '-$result' : result;
  }

  static String formatWithCommasInt(int number) {
    return formatWithCommas(number.toDouble(), decimals: 0);
  }

  static String formatCurrency(double number, {String currency = 'MXN', int decimals = 0}) {
    final String formattedNumber = formatWithCommas(number, decimals: decimals);
    return '\$$formattedNumber $currency';
  }

  static String _formatValue(double value, String suffix, int decimals) {
    if (value % 1 == 0) {
      return '${value.toStringAsFixed(0)}$suffix';
    }
    
    final String formatted = value.toStringAsFixed(decimals);
    final String cleaned = formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    
    return '$cleaned$suffix';
  }
}
