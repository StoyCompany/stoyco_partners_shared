import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/button_tokens.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/text_token.dart';

void main() {
  group('ButtonVariant', () {
    test('should have all button variants', () {
      expect(ButtonVariant.values.length, 5);
      expect(ButtonVariant.values, contains(ButtonVariant.primary));
      expect(ButtonVariant.values, contains(ButtonVariant.secondary));
      expect(ButtonVariant.values, contains(ButtonVariant.outline));
      expect(ButtonVariant.values, contains(ButtonVariant.ghost));
      expect(ButtonVariant.values, contains(ButtonVariant.destructive));
    });
  });

  group('ButtonSize', () {
    test('should have all button sizes', () {
      expect(ButtonSize.values.length, 5);
      expect(ButtonSize.values, contains(ButtonSize.xs));
      expect(ButtonSize.values, contains(ButtonSize.sm));
      expect(ButtonSize.values, contains(ButtonSize.md));
      expect(ButtonSize.values, contains(ButtonSize.lg));
      expect(ButtonSize.values, contains(ButtonSize.xl));
    });
  });

  group('ButtonStyleSpec', () {
    test('should create ButtonStyleSpec with all required properties', () {
      const spec = ButtonStyleSpec(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        padding: EdgeInsets.all(16),
        height: 48,
        textStyle: TextStyle(fontSize: 16),
      );

      expect(spec.backgroundColor, Colors.blue);
      expect(spec.foregroundColor, Colors.white);
      expect(spec.borderSide, BorderSide.none);
      expect(spec.height, 48);
    });

    test('should support optional disabled colors', () {
      const spec = ButtonStyleSpec(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey,
        disabledForegroundColor: Colors.black,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        padding: EdgeInsets.all(16),
        height: 48,
        textStyle: TextStyle(fontSize: 16),
      );

      expect(spec.disabledBackgroundColor, Colors.grey);
      expect(spec.disabledForegroundColor, Colors.black);
    });

    test('should support optional loading colors', () {
      const spec = ButtonStyleSpec(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        loadingBackgroundColor: Colors.blueGrey,
        loadingForegroundColor: Colors.white70,
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        padding: EdgeInsets.all(16),
        height: 48,
        textStyle: TextStyle(fontSize: 16),
      );

      expect(spec.loadingBackgroundColor, Colors.blueGrey);
      expect(spec.loadingForegroundColor, Colors.white70);
    });
  });

  group('ButtonTokens.resolve - Primary Variant', () {
    test('should resolve primary button with xs size', () {
      final spec = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.xs);

      expect(spec.backgroundColor, isNotNull);
      expect(spec.foregroundColor, isNotNull);
      expect(spec.height, 36);
      expect(spec.textStyle.fontSize, 14);
      expect(spec.textStyle.fontFamily, StoycoFontFamilyToken.gilroy);
      expect(spec.textStyle.fontWeight, FontWeight.w800);
    });

    test('should resolve primary button with md size', () {
      final spec = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.md);

      expect(spec.height, 48);
      expect(spec.textStyle.fontSize, 16);
    });

    test('should resolve primary button with xl size', () {
      final spec = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.xl);

      expect(spec.height, 68);
      expect(spec.textStyle.fontSize, 18);
    });

    test('primary button should have loading colors', () {
      final spec = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.md);

      expect(spec.loadingBackgroundColor, isNotNull);
      expect(spec.loadingForegroundColor, isNotNull);
    });
  });

  group('ButtonTokens.resolve - Secondary Variant', () {
    test('should resolve secondary button with sm size', () {
      final spec = ButtonTokens.resolve(ButtonVariant.secondary, ButtonSize.sm);

      expect(spec.backgroundColor, isNotNull);
      expect(spec.foregroundColor, isNotNull);
      expect(spec.height, 40);
      expect(spec.textStyle.fontSize, 15);
      expect(spec.textStyle.fontWeight, FontWeight.w700);
    });
  });

  group('ButtonTokens.resolve - Outline Variant', () {
    test('should resolve outline button with border', () {
      final spec = ButtonTokens.resolve(ButtonVariant.outline, ButtonSize.md);

      expect(spec.backgroundColor, Colors.transparent);
      expect(spec.borderSide, isNot(BorderSide.none));
      expect(spec.borderSide?.width, 1.5);
      expect(spec.height, 48);
    });
  });

  group('ButtonTokens.resolve - Ghost Variant', () {
    test('should resolve ghost button with transparent background', () {
      final spec = ButtonTokens.resolve(ButtonVariant.ghost, ButtonSize.lg);

      expect(spec.backgroundColor, Colors.transparent);
      expect(spec.borderSide, BorderSide.none);
      expect(spec.height, 56);
      expect(spec.textStyle.fontSize, 17);
    });
  });

  group('ButtonTokens.resolve - Destructive Variant', () {
    test('should resolve destructive button', () {
      final spec = ButtonTokens.resolve(ButtonVariant.destructive, ButtonSize.md);

      expect(spec.backgroundColor, isNotNull);
      expect(spec.foregroundColor, isNotNull);
      expect(spec.height, 48);
      expect(spec.textStyle.fontWeight, FontWeight.w800);
    });
  });

  group('ButtonTokens.resolve - Size Consistency', () {
    test('all variants should have consistent heights for same size', () {
      final primaryMd = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.md);
      final secondaryMd = ButtonTokens.resolve(ButtonVariant.secondary, ButtonSize.md);
      final outlineMd = ButtonTokens.resolve(ButtonVariant.outline, ButtonSize.md);
      final ghostMd = ButtonTokens.resolve(ButtonVariant.ghost, ButtonSize.md);
      final destructiveMd = ButtonTokens.resolve(ButtonVariant.destructive, ButtonSize.md);

      expect(primaryMd.height, equals(secondaryMd.height));
      expect(secondaryMd.height, equals(outlineMd.height));
      expect(outlineMd.height, equals(ghostMd.height));
      expect(ghostMd.height, equals(destructiveMd.height));
    });

    test('heights should increase with size', () {
      final xs = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.xs);
      final sm = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.sm);
      final md = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.md);
      final lg = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.lg);
      final xl = ButtonTokens.resolve(ButtonVariant.primary, ButtonSize.xl);

      expect(xs.height < sm.height, isTrue);
      expect(sm.height < md.height, isTrue);
      expect(md.height < lg.height, isTrue);
      expect(lg.height < xl.height, isTrue);
    });
  });

  group('TextTokens', () {
    test('should have gilroy text token', () {
      final gilroy = TextTokens.gilroy;
      expect(gilroy, isA<GilroyText>());
    });

    test('should have akkurat text token', () {
      final akkurat = TextTokens.akkurat;
      expect(akkurat, isA<AkkuratText>());
    });
  });

  group('AkkuratText', () {
    test('should have all weight variants', () {
      final akkurat = TextTokens.akkurat;

      expect(akkurat.light.fontWeight, FontWeight.w300);
      expect(akkurat.regular.fontWeight, FontWeight.w400);
      expect(akkurat.medium.fontWeight, FontWeight.w500);
      expect(akkurat.semibold.fontWeight, FontWeight.w600);
      expect(akkurat.bold.fontWeight, FontWeight.w700);
      expect(akkurat.extrabold.fontWeight, FontWeight.w800);
    });

    test('all variants should use akkurat font family', () {
      final akkurat = TextTokens.akkurat;

      expect(akkurat.light.fontFamily, StoycoFontFamilyToken.akkurat);
      expect(akkurat.regular.fontFamily, StoycoFontFamilyToken.akkurat);
      expect(akkurat.medium.fontFamily, StoycoFontFamilyToken.akkurat);
      expect(akkurat.semibold.fontFamily, StoycoFontFamilyToken.akkurat);
      expect(akkurat.bold.fontFamily, StoycoFontFamilyToken.akkurat);
      expect(akkurat.extrabold.fontFamily, StoycoFontFamilyToken.akkurat);
    });

    test('should have no decoration', () {
      final akkurat = TextTokens.akkurat;

      expect(akkurat.light.decoration, TextDecoration.none);
      expect(akkurat.bold.decoration, TextDecoration.none);
    });
  });

  group('GilroyText', () {
    test('should have all weight variants', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light.fontWeight, FontWeight.w300);
      expect(gilroy.regular.fontWeight, FontWeight.w400);
      expect(gilroy.medium.fontWeight, FontWeight.w500);
      expect(gilroy.semibold.fontWeight, FontWeight.w600);
      expect(gilroy.bold.fontWeight, FontWeight.w700);
      expect(gilroy.extrabold.fontWeight, FontWeight.w800);
    });

    test('all variants should use gilroy font family', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light.fontFamily, StoycoFontFamilyToken.gilroy);
      expect(gilroy.regular.fontFamily, StoycoFontFamilyToken.gilroy);
      expect(gilroy.medium.fontFamily, StoycoFontFamilyToken.gilroy);
      expect(gilroy.semibold.fontFamily, StoycoFontFamilyToken.gilroy);
      expect(gilroy.bold.fontFamily, StoycoFontFamilyToken.gilroy);
      expect(gilroy.extrabold.fontFamily, StoycoFontFamilyToken.gilroy);
    });

    test('should have sized text styles - 10', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light_10.fontSize, 10);
      expect(gilroy.regular_10.fontSize, 10);
      expect(gilroy.medium_10.fontSize, 10);
      expect(gilroy.semibold_10.fontSize, 10);
      expect(gilroy.bold_10.fontSize, 10);
      expect(gilroy.extrabold_10.fontSize, 10);
    });

    test('should have sized text styles - 16', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light_16.fontSize, 16);
      expect(gilroy.regular_16.fontSize, 16);
      expect(gilroy.medium_16.fontSize, 16);
      expect(gilroy.semibold_16.fontSize, 16);
      expect(gilroy.bold_16.fontSize, 16);
      expect(gilroy.extrabold_16.fontSize, 16);
    });

    test('should have sized text styles - 24', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light_24.fontSize, 24);
      expect(gilroy.regular_24.fontSize, 24);
      expect(gilroy.medium_24.fontSize, 24);
      expect(gilroy.semibold_24.fontSize, 24);
      expect(gilroy.bold_24.fontSize, 24);
      expect(gilroy.extrabold_24.fontSize, 24);
    });

    test('should have sized text styles - 30', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light_30.fontSize, 30);
      expect(gilroy.regular_30.fontSize, 30);
      expect(gilroy.medium_30.fontSize, 30);
      expect(gilroy.semibold_30.fontSize, 30);
      expect(gilroy.bold_30.fontSize, 30);
      expect(gilroy.extrabold_30.fontSize, 30);
    });

    test('font weights should be correct for sized variants', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.light_16.fontWeight, FontWeight.w300);
      expect(gilroy.regular_16.fontWeight, FontWeight.w400);
      expect(gilroy.medium_16.fontWeight, FontWeight.w500);
      expect(gilroy.semibold_16.fontWeight, FontWeight.w600);
      expect(gilroy.bold_16.fontWeight, FontWeight.w700);
      expect(gilroy.extrabold_16.fontWeight, FontWeight.w800);
    });

    test('should have all intermediate sizes', () {
      final gilroy = TextTokens.gilroy;

      expect(gilroy.regular_12.fontSize, 12);
      expect(gilroy.regular_14.fontSize, 14);
      expect(gilroy.regular_15.fontSize, 15);
      expect(gilroy.regular_18.fontSize, 18);
      expect(gilroy.regular_19.fontSize, 19);
      expect(gilroy.regular_20.fontSize, 20);
      expect(gilroy.regular_22.fontSize, 22);
      expect(gilroy.regular_25.fontSize, 25);
    });
  });

  group('TextTokens Integration', () {
    test('gilroy and akkurat should be singleton instances', () {
      final gilroy1 = TextTokens.gilroy;
      final gilroy2 = TextTokens.gilroy;
      expect(identical(gilroy1, gilroy2), isTrue);

      final akkurat1 = TextTokens.akkurat;
      final akkurat2 = TextTokens.akkurat;
      expect(identical(akkurat1, akkurat2), isTrue);
    });

    test('text styles should be usable in Flutter widgets', () {
      final gilroy = TextTokens.gilroy;
      final akkurat = TextTokens.akkurat;

      expect(gilroy.bold_16, isA<TextStyle>());
      expect(akkurat.medium, isA<TextStyle>());
    });
  });
}
