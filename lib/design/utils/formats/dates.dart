class DatesFormats {
  static String formatDateDDMMYYYY(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatDateDDMMYYYYWithDashes(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }
}
