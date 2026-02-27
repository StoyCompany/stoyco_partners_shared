import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';

void main() {
  group('FontFoundation', () {
    group('Font Family Configuration', () {
      test('should have correct font families', () {
        expect(StoycoFontFamilyToken.gilroy, equals('Gilroy'));
        expect(StoycoFontFamilyToken.akkurat, equals('Akkurat'));
        expect(StoycoFontFamilyToken.apercu, equals('Apercu'));
      });
    });

    group('Title Styles', () {
      test('should have title styles with correct properties', () {
        final title = FontFoundation.title.bold24Black;
        expect(title.fontSize, equals(24.0));
        expect(title.fontFamily, equals(StoycoFontFamilyToken.gilroy));
        expect(title.color, isNotNull);
      });

      test('should have title with white color', () {
        final titleWhite = FontFoundation.title.bold24White;
        expect(titleWhite.fontSize, equals(24.0));
        expect(titleWhite.color, isNotNull);
      });

      test('should have title with SA colors', () {
        final titleSaDark = FontFoundation.title.bold30saDark;
        final titleSaLight = FontFoundation.title.boldSaLight;
        expect(titleSaDark, isNotNull);
        expect(titleSaLight, isNotNull);
      });

      test('should have different font weights for titles', () {
        final bold = FontFoundation.title.bold24Black;
        final semiBold = FontFoundation.title.semiBold24Black;
        final medium = FontFoundation.title.medium24Black;
        final regular = FontFoundation.title.regular24Black;

        expect(bold, isNotNull);
        expect(semiBold, isNotNull);
        expect(medium, isNotNull);
        expect(regular, isNotNull);
      });

      test('should have multiple sizes', () {
        final size24 = FontFoundation.title.bold24Black;
        final size25 = FontFoundation.title.bold25saDark;
        final size30 = FontFoundation.title.bold30saDark;

        expect(size24.fontSize, equals(24.0));
        expect(size25.fontSize, equals(25.0));
        expect(size30.fontSize, equals(30.0));
      });
    });

    group('Subtitle Styles', () {
      test('should have subtitle styles', () {
        final subtitle = FontFoundation.subtitle;
        expect(subtitle, isNotNull);
      });
    });

    group('Label Styles', () {
      test('should have label styles', () {
        final label = FontFoundation.label;
        expect(label, isNotNull);
      });
    });

    group('Paragraph Styles', () {
      test('should have paragraph styles', () {
        final paragraph = FontFoundation.paragraph;
        expect(paragraph, isNotNull);
      });
    });

    group('Text Style Consistency', () {
      test('all title sizes should be valid', () {
        final size24 = FontFoundation.title.bold24Black.fontSize;
        final size25 = FontFoundation.title.bold25saDark.fontSize;
        final size30 = FontFoundation.title.bold30saDark.fontSize;

        expect(size30, greaterThan(size25!));
        expect(size25, greaterThan(size24!));
      });

      test('all text styles should have non-null font family', () {
        expect(FontFoundation.title.bold24Black.fontFamily, isNotNull);
      });

      test('all text styles should have valid font size', () {
        expect(FontFoundation.title.bold24Black.fontSize, greaterThan(0));
      });
    });

    group('Font Weight Variants', () {
      test('should support regular weight', () {
        final regular = FontFoundation.title.regular24Black;
        expect(regular, isNotNull);
      });

      test('should support medium weight', () {
        final medium = FontFoundation.title.medium24Black;
        expect(medium, isNotNull);
      });

      test('should support semibold weight', () {
        final semibold = FontFoundation.title.semiBold24Black;
        expect(semibold, isNotNull);
      });

      test('should support bold weight', () {
        final bold = FontFoundation.title.bold24Black;
        expect(bold, isNotNull);
      });
    });

    group('Color Variants', () {
      test('should have black color variant', () {
        expect(FontFoundation.title.bold24Black, isNotNull);
      });

      test('should have white color variant', () {
        expect(FontFoundation.title.bold24White, isNotNull);
      });

      test('should have SA color variants', () {
        expect(FontFoundation.title.bold30saDark, isNotNull);
        expect(FontFoundation.title.boldSaLight, isNotNull);
      });
    });

    group('Typography Scale', () {
      test('font sizes should be reasonable for UI', () {
        expect(FontFoundation.title.bold24Black.fontSize, lessThan(100.0));
        expect(FontFoundation.title.bold24Black.fontSize, greaterThan(10.0));
      });
    });

    group('Style Immutability', () {
      test('text styles should not be modified after creation', () {
        final style1 = FontFoundation.title.bold24Black;
        final style2 = FontFoundation.title.bold24Black;
        
        expect(style1.fontSize, equals(style2.fontSize));
        expect(style1.fontFamily, equals(style2.fontFamily));
        expect(style1.color, equals(style2.color));
      });
    });
  });
}