import 'package:flutter/material.dart';

/// Atom: BoldTextSpan
///
/// A utility widget for displaying bold text spans within a string.
///
/// This atom parses the input [text] and applies the [boldStyle] to any segment
/// wrapped with `#` characters (e.g., `This is #bold# text`).
/// All other text is rendered using the provided [style].
///
/// Example usage:
/// ```dart
/// BoldTextSpan(
///   'This is #bold# text',
///   style: TextStyle(fontSize: 16),
///   boldStyle: TextStyle(fontWeight: FontWeight.bold),
/// )
/// ```
///
/// - [text]: The string to display, with bold segments marked by `#`.
/// - [style]: The style for normal text.
/// - [boldStyle]: The style for bold text.
/// - [textAlign]: Optional alignment for the text.
///
/// This widget is useful for emphasizing parts of a string without manual span creation.
///
/// Category: Atom
///
/// Author: Stoyco Partners Shared
/// Date: March 10, 2026
///
/// See also:
/// - [RichText]
/// - [TextSpan]
///
/// Example:
/// ```dart
/// BoldTextSpan(
///   'Hello #World#!',
///   style: TextStyle(color: Colors.black),
///   boldStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
/// )
/// ```

/// Utility widget to display bold text for segments marked with `#`.
///
/// Parses the input string and applies [boldStyle] to text between `#` markers.
///
/// Example:
/// ```dart
/// BoldTextSpan(
///   'This is #bold# text',
///   style: TextStyle(fontSize: 16),
///   boldStyle: TextStyle(fontWeight: FontWeight.bold),
/// )
/// ```
class BoldTextSpan extends StatelessWidget {

  /// Creates a [BoldTextSpan] widget.
  ///
  /// [text]: The string to display, with bold segments marked by `#`.
  /// [style]: The style for normal text.
  /// [boldStyle]: The style for bold text.
  /// [textAlign]: Optional alignment for the text.
  const BoldTextSpan(
    this.text, {
    super.key,
    required this.style,
    required this.boldStyle,
    this.textAlign,
  });

  /// The string to display, with bold segments marked by `#`.
  final String text;
  /// The style for normal text.
  final TextStyle style;
  /// The style for bold text.
  final TextStyle boldStyle;
  /// Optional alignment for the text.
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> spans = <TextSpan>[];
    final RegExp exp = RegExp(r'#(.*?)#');
    int lastMatchEnd = 0;
    final Iterable<RegExpMatch> matches = exp.allMatches(text);
    for (final RegExpMatch match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: style,
          ),
        );
      }
      spans.add(TextSpan(text: match.group(1), style: boldStyle));
      lastMatchEnd = match.end;
    }
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd), style: style));
    }
    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(children: spans),
    );
  }
}
