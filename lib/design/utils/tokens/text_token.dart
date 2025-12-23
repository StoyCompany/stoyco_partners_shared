import 'package:flutter/material.dart';

import 'gen/fonts.gen.dart';

/// A utility class that provides access to different text style tokens for the app's typography.
///
/// This class cannot be instantiated directly due to its private constructor (`TextTokens._internal()`).
/// Instead, it exposes static instances of text style token classes (`MontserratText`, `RobotoText`, and `GilroyText`)
/// which are also constructed privately (using the `_()` constructor).
///
/// The underscore (`_`) before a constructor or class name in Dart indicates that it is private to its library,
/// meaning it cannot be accessed from outside the file it is defined in. This is used here to enforce encapsulation,
/// ensuring that text style tokens are only accessed via the static fields of `TextTokens`.
///
/// Example usage:
/// ```dart
/// var montserrat = TextTokens.montserrat;
/// ```
class TextTokens {
  TextTokens._internal();

  static GilroyText gilroy = GilroyText._();
}

class GilroyText {
  GilroyText._();

  static const TextStyle _gilroy = TextStyle(
    fontFamily: StoycoFontFamilyToken.gilroy,
    decoration: TextDecoration.none,
  );

  // General Size

  final TextStyle light = _gilroy.copyWith(fontWeight: FontWeight.w300);
  final TextStyle regular = _gilroy.copyWith(fontWeight: FontWeight.w400);
  final TextStyle medium = _gilroy.copyWith(fontWeight: FontWeight.w500);
  final TextStyle semibold = _gilroy.copyWith(fontWeight: FontWeight.w600);
  final TextStyle bold = _gilroy.copyWith(fontWeight: FontWeight.w700);
  final TextStyle extrabold = _gilroy.copyWith(fontWeight: FontWeight.w800);

  // Font Size : 10
  final TextStyle light_10 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 10,
  );
  final TextStyle regular_10 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
  final TextStyle medium_10 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 10,
  );
  final TextStyle semibold_10 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );
  final TextStyle bold_10 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 10,
  );
  final TextStyle extrabold_10 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 10,
  );

  // Font Size : 12
  final TextStyle light_12 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );
  final TextStyle regular_12 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  final TextStyle medium_12 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  final TextStyle semibold_12 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  final TextStyle bold_12 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );
  final TextStyle extrabold_12 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 12,
  );

  // Font Size : 14
  final TextStyle light_14 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 14,
  );
  final TextStyle regular_14 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  final TextStyle medium_14 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  final TextStyle semibold_14 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  final TextStyle bold_14 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  final TextStyle extrabold_14 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 14,
  );

  // Font Size : 16
  final TextStyle light_16 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 16,
  );
  final TextStyle regular_16 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  final TextStyle medium_16 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  final TextStyle semibold_16 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  final TextStyle bold_16 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  final TextStyle extrabold_16 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 16,
  );

  // Font Size : 18
  final TextStyle light_18 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );
  final TextStyle regular_18 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  final TextStyle medium_18 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  final TextStyle semibold_18 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  final TextStyle bold_18 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
  final TextStyle extrabold_18 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 18,
  );

  // Font Size : 19
  final TextStyle light_19 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 19,
  );
  final TextStyle regular_19 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 19,
  );
  final TextStyle medium_19 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 19,
  );
  final TextStyle semibold_19 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 19,
  );
  final TextStyle bold_19 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 19,
  );
  final TextStyle extrabold_19 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 19,
  );

  // Font Size : 20
  final TextStyle light_20 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 20,
  );
  final TextStyle regular_20 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 20,
  );
  final TextStyle medium_20 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  final TextStyle semibold_20 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  final TextStyle bold_20 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  final TextStyle extrabold_20 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 20,
  );

  // Font Size : 22
  final TextStyle light_22 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 22,
  );
  final TextStyle regular_22 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 22,
  );
  final TextStyle medium_22 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );
  final TextStyle semibold_22 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  final TextStyle bold_22 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 22,
  );
  final TextStyle extrabold_22 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 22,
  );

  // Font Size : 24
  final TextStyle light_24 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 24,
  );
  final TextStyle regular_24 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
  final TextStyle medium_24 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );
  final TextStyle semibold_24 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  final TextStyle bold_24 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );
  final TextStyle extrabold_24 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 24,
  );

  // Font Size : 25
  final TextStyle light_25 = _gilroy.copyWith(
    fontWeight: FontWeight.w300,
    fontSize: 25,
  );
  final TextStyle regular_25 = _gilroy.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 25,
  );
  final TextStyle medium_25 = _gilroy.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 25,
  );
  final TextStyle semibold_25 = _gilroy.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 25,
  );
  final TextStyle bold_25 = _gilroy.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 25,
  );
  final TextStyle extrabold_25 = _gilroy.copyWith(
    fontWeight: FontWeight.w800,
    fontSize: 25,
  );
}
