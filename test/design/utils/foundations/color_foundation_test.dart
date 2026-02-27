import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/colors.gen.dart';

void main() {
  group('ColorFoundation', () {
    group('Text Colors', () {
      test('should have correct black color values', () {
        expect(ColorFoundation.text.black.value, equals(0xFF2F2F2F));
        expect(ColorFoundation.text.black_1.value, equals(0xFF4E4E4E));
      });

      test('should have correct white color value', () {
        expect(ColorFoundation.text.white.value, equals(0xFFFFFFFF));
      });

      test('should have correct SA color values', () {
        expect(ColorFoundation.text.saDark.value, equals(0xFF14121D));
        expect(ColorFoundation.text.saLight.value, equals(0xFFF2E9F2));
        expect(ColorFoundation.text.saHighlights.value, equals(0xFF9E80E1));
        expect(ColorFoundation.text.saError.value, equals(0xFFE87D99));
      });

      test('should have correct grey scale colors', () {
        expect(ColorFoundation.text.grey1, isNotNull);
        expect(ColorFoundation.text.grey2, isNotNull);
        expect(ColorFoundation.text.grey3, isNotNull);
        expect(ColorFoundation.text.grey4, isNotNull);
        expect(ColorFoundation.text.grey5, isNotNull);
        expect(ColorFoundation.text.grey7, isNotNull);
      });

      test('should have correct blue palette values', () {
        expect(ColorFoundation.text.blue5.value, equals(0xFFE6F4F9));
        expect(ColorFoundation.text.blue10.value, equals(0xFFCDE8F2));
        expect(ColorFoundation.text.blue30.value, equals(0xFFB4DDEC));
        expect(ColorFoundation.text.blue11.value, equals(0xFF006DB3));
      });

      test('should have correct complementary colors', () {
        expect(ColorFoundation.text.complementary3, isNotNull);
        expect(ColorFoundation.text.complementary4, isNotNull);
      });

      test('should have correct state colors', () {
        expect(ColorFoundation.text.success, isNotNull);
        expect(ColorFoundation.text.negative, isNotNull);
      });

      test('should have transparent color', () {
        expect(ColorFoundation.text.transparent.value, equals(0x00000000));
      });
    });

    group('Background Colors', () {
      test('should have correct white background', () {
        expect(ColorFoundation.background.white, isA<Color>());
        expect(ColorFoundation.background.white.value, equals(0xFFFFFFFF));
      });

      test('should have correct grey backgrounds', () {
        expect(ColorFoundation.background.grey1, isA<Color>());
        expect(ColorFoundation.background.grey2, isA<Color>());
        expect(ColorFoundation.background.grey3, isA<Color>());
        expect(ColorFoundation.background.grey4, isA<Color>());
        expect(ColorFoundation.background.grey5, isA<Color>());
        expect(ColorFoundation.background.grey6, isA<Color>());
      });

      test('should have correct SA backgrounds', () {
        expect(ColorFoundation.background.saDark, isA<Color>());
        expect(ColorFoundation.background.saLight, isA<Color>());
      });

      test('should have chart colors', () {
        expect(ColorFoundation.background.chartBlack, isA<Color>());
        expect(ColorFoundation.background.chartBlue, isA<Color>());
        expect(ColorFoundation.background.chartGreen, isA<Color>());
        expect(ColorFoundation.background.chartPurple, isA<Color>());
      });

      test('should have card background colors', () {
        expect(ColorFoundation.background.cardIntermediate1, isA<Color>());
        expect(ColorFoundation.background.cardIntermediate2, isA<Color>());
        expect(ColorFoundation.background.cardAffirmative1, isA<Color>());
        expect(ColorFoundation.background.cardAffirmative2, isA<Color>());
      });

      test('should have transparent background', () {
        expect(ColorFoundation.background.transparent.value, equals(0x00000000));
      });

      test('should have blur color', () {
        expect(ColorFoundation.background.blur, isA<Color>());
      });

      test('should have notification colors', () {
        expect(ColorFoundation.background.notificationSuccess, isA<Color>());
        expect(ColorFoundation.background.notificationFailed, isA<Color>());
        expect(ColorFoundation.background.notificationToBack, isA<Color>());
      });
    });

    group('Border Colors', () {
      test('should have button border colors', () {
        expect(ColorFoundation.border.googleButton, isA<Color>());
        expect(ColorFoundation.border.buttonPrimary, isA<Color>());
        expect(ColorFoundation.border.buttonDisable, isA<Color>());
        expect(ColorFoundation.border.buttonSelector, isA<Color>());
        expect(ColorFoundation.border.buttonText, isA<Color>());
      });

      test('should have textfield border colors', () {
        expect(ColorFoundation.border.textFieldInactivate, isA<Color>());
        expect(ColorFoundation.border.textFieldActivate, isA<Color>());
        expect(ColorFoundation.border.textFieldError, isA<Color>());
      });

      test('should have card border colors', () {
        expect(ColorFoundation.border.customerCard, isA<Color>());
        expect(ColorFoundation.border.greenBorder, isA<Color>());
      });

      test('should have SA border colors', () {
        expect(ColorFoundation.border.saError, isA<Color>());
        expect(ColorFoundation.border.saDark, isA<Color>());
        expect(ColorFoundation.border.saLight, isA<Color>());
        expect(ColorFoundation.border.saHighlights, isA<Color>());
      });
    });

    group('Gradient Colors', () {
      test('should have header app gradient', () {
        expect(ColorFoundation.gradient.headerApp, isA<List<Color>>());
        expect(ColorFoundation.gradient.headerApp.length, equals(2));
      });

      test('should have border box gradient', () {
        expect(ColorFoundation.gradient.borderBox, isA<List<Color>>());
        expect(ColorFoundation.gradient.borderBox.length, equals(2));
      });

      test('should have drawer app gradient', () {
        expect(ColorFoundation.gradient.drawerApp, isA<List<Color>>());
        expect(ColorFoundation.gradient.drawerApp.length, equals(2));
      });

      test('should have card gradients', () {
        expect(ColorFoundation.gradient.cardAffirmative, isA<List<Color>>());
        expect(ColorFoundation.gradient.cardIntermediate, isA<List<Color>>());
      });
    });

    group('Shadow Colors', () {
      test('should have shadow colors', () {
        expect(ColorFoundation.shadow.cardHelp, isA<Color>());
        expect(ColorFoundation.shadow.buttom, isA<Color>());
        expect(ColorFoundation.shadow.saHighlights, isA<Color>());
      });
    });

    group('Color Consistency', () {
      test('all text colors should be non-null', () {
        expect(ColorFoundation.text.black, isNotNull);
        expect(ColorFoundation.text.white, isNotNull);
        expect(ColorFoundation.text.grey1, isNotNull);
        expect(ColorFoundation.text.saHighlights, isNotNull);
      });

      test('all background colors should be non-null', () {
        expect(ColorFoundation.background.white, isNotNull);
        expect(ColorFoundation.background.chartBlack, isNotNull);
        expect(ColorFoundation.background.blur, isNotNull);
      });

      test('color values should match token values', () {
        expect(
          ColorFoundation.text.black.value,
          equals(StoycoColorsToken.black.value),
        );
        expect(
          ColorFoundation.text.white.value,
          equals(StoycoColorsToken.white.value),
        );
        expect(
          ColorFoundation.text.saHighlights.value,
          equals(StoycoColorsToken.saHighlights.value),
        );
      });
    });

    group('Color Accessibility', () {
      test('should have sufficient contrast for text on backgrounds', () {
        final blackOnWhite = _calculateContrast(
          ColorFoundation.text.black,
          ColorFoundation.background.white,
        );
        expect(blackOnWhite, greaterThan(4.5)); // WCAG AA standard
      });

      test('should have sufficient contrast for white text on dark backgrounds', () {
        final whiteOnDark = _calculateContrast(
          ColorFoundation.text.white,
          ColorFoundation.background.chartBlack,
        );
        expect(whiteOnDark, greaterThan(4.5));
      });
    });
  });
}

/// Calculate color contrast ratio for accessibility testing
double _calculateContrast(Color foreground, Color background) {
  final double l1 = _relativeLuminance(foreground);
  final double l2 = _relativeLuminance(background);
  
  final double lighter = l1 > l2 ? l1 : l2;
  final double darker = l1 > l2 ? l2 : l1;
  
  return (lighter + 0.05) / (darker + 0.05);
}

/// Calculate relative luminance of a color
double _relativeLuminance(Color color) {
  final double r = _luminanceComponent(color.red / 255.0);
  final double g = _luminanceComponent(color.green / 255.0);
  final double b = _luminanceComponent(color.blue / 255.0);
  
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

double _luminanceComponent(double component) {
  return component <= 0.03928
      ? component / 12.92
      : math.pow((component + 0.055) / 1.055, 2.4).toDouble();
}
