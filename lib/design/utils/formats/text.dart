final class TextFormat {
  const TextFormat._();

  /// Truncates text to a specified maximum length.
  /// If it exceeds the length, adds "..." at the end.
  /// 
  /// [text] - The text to truncate
  /// [maxLength] - Maximum character length (default: 42)
  /// [ellipsis] - Text to add at the end when truncated (default: "...")
  static String truncate(
    String text, {
    int maxLength = 42,
    String ellipsis = '...',
  }) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}$ellipsis';
  }
}
