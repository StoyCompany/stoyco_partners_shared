import 'package:flutter/widgets.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/text_token.dart';

class FontFoundation {
  FontFoundation._internal();

  static final _Title title = _Title._();
  static final _Subtitle subtitle = _Subtitle._();
  static final _Paragraph paragraph = _Paragraph._();
  static final _Label label = _Label._();
}

class _Title {
  _Title._();

  // Size 30 sa dark
  final TextStyle bold30saDark = TextTokens.gilroy.bold_30.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold30saDark = TextTokens.gilroy.semibold_30.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium30saDark = TextTokens.gilroy.medium_30.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular30saDark = TextTokens.gilroy.regular_30.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Sa Light General, for size add copyWith
  final TextStyle boldSaLight = TextTokens.gilroy.bold.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle semiBoldSaLight = TextTokens.gilroy.semibold.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle mediumSaLight = TextTokens.gilroy.medium.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle regularSaLight = TextTokens.gilroy.regular.copyWith(
    color: ColorFoundation.text.saLight,
  );

  // Size 25 sa light
  final TextStyle bold25saDark = TextTokens.gilroy.bold_25.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold25saDark = TextTokens.gilroy.semibold_25.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium25saDark = TextTokens.gilroy.medium_25.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular25saDark = TextTokens.gilroy.regular_25.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Size 25 sa light
  final TextStyle bold25saLight = TextTokens.gilroy.bold_25.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle semiBold25saLight = TextTokens.gilroy.semibold_25.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle medium25saLight = TextTokens.gilroy.medium_25.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle regular25saLight = TextTokens.gilroy.regular_25.copyWith(
    color: ColorFoundation.text.saLight,
  );

  // Size 24 white
  final TextStyle bold24White = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold24White = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium24White = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular24White = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 24 black
  final TextStyle bold24Black = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.black,
    letterSpacing: -0.2,
  );
  final TextStyle semiBold24Black = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.black,
    letterSpacing: -0.2,
  );
  final TextStyle medium24Black = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.black,
    letterSpacing: -0.2,
  );
  final TextStyle regular24Black = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.black,
    letterSpacing: -0.2,
  );

  // Size 24 black-1
  final TextStyle bold24Black1 = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold24Black1 = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium24Black1 = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular24Black1 = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 24 grey 1
  final TextStyle bold24Grey1 = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold24Grey1 = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium24Grey1 = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular24Grey1 = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 24 grey 2
  final TextStyle bold24Grey2 = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold24Grey2 = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium24Grey2 = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular24Grey2 = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 24 grey 3
  final TextStyle bold24Grey3 = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold24Grey3 = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium24Grey3 = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular24Grey3 = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 24 grey 4
  final TextStyle bold24Grey4 = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold24Grey4 = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium24Grey4 = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular24Grey4 = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 24 grey 5
  final TextStyle bold24Grey5 = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold24Grey5 = TextTokens.gilroy.semibold_24.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium24Grey5 = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular24Grey5 = TextTokens.gilroy.regular_24.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 24 complementary 3
  final TextStyle bold24Complementary = TextTokens.gilroy.bold_24.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold24Complementary = TextTokens.gilroy.semibold_24
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium24Complementary = TextTokens.gilroy.medium_24.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular24Complementary = TextTokens.gilroy.regular_24
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 22 white
  final TextStyle bold22White = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold22White = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium22White = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular22White = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 22 black
  final TextStyle bold22Black = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold22Black = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium22Black = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular22Black = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 22 black-1
  final TextStyle bold22Black1 = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold22Black1 = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium22Black1 = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular22Black1 = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 22 grey 1
  final TextStyle bold22Grey1 = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold22Grey1 = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium22Grey1 = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular22Grey1 = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 22 grey 2
  final TextStyle bold22Grey2 = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold22Grey2 = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium22Grey2 = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular22Grey2 = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 22 grey 3
  final TextStyle bold22Grey3 = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold22Grey3 = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium22Grey3 = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular22Grey3 = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 22 grey 4
  final TextStyle bold22Grey4 = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold22Grey4 = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium22Grey4 = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular22Grey4 = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 22 grey 5
  final TextStyle bold22Grey5 = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold22Grey5 = TextTokens.gilroy.semibold_22.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium22Grey5 = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular22Grey5 = TextTokens.gilroy.regular_22.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 22 complementary 3
  final TextStyle bold22Complementary = TextTokens.gilroy.bold_22.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold22Complementary = TextTokens.gilroy.semibold_22
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium22Complementary = TextTokens.gilroy.medium_22.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular22Complementary = TextTokens.gilroy.regular_22
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 20 white
  final TextStyle bold20White = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold20White = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium20White = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular20White = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 20 black
  final TextStyle bold20Black = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold20Black = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium20Black = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular20Black = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 20 black-1
  final TextStyle bold20Black1 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold20Black1 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium20Black1 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular20Black1 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 20 grey 1
  final TextStyle bold20Grey1 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold20Grey1 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium20Grey1 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular20Grey1 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 20 grey 2
  final TextStyle bold20Grey2 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold20Grey2 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium20Grey2 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular20Grey2 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 20 grey 3
  final TextStyle bold20Grey3 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold20Grey3 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium20Grey3 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular20Grey3 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 20 grey 4
  final TextStyle bold20Grey4 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold20Grey4 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium20Grey4 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular20Grey4 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 20 grey 5
  final TextStyle bold20Grey5 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold20Grey5 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium20Grey5 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular20Grey5 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 20 complementary 3
  final TextStyle bold20Complementary = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold20Complementary = TextTokens.gilroy.semibold_20
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium20Complementary = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular20Complementary = TextTokens.gilroy.regular_20
      .copyWith(color: ColorFoundation.text.complementary3);

  final TextStyle bold20 = TextTokens.gilroy.bold_20;
  final TextStyle modals_24 = TextTokens.gilroy.bold_24;
  final TextStyle modals_20 = TextTokens.gilroy.bold_20;
  final TextStyle drawer = TextTokens.gilroy.regular_20;
  final TextStyle screens = TextTokens.gilroy.semibold_24;
}

class _Subtitle {
  _Subtitle._();

  // Size 20 white
  final TextStyle bold20White = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold20White = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium20White = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular20White = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 20 black
  final TextStyle bold20Black = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold20Black = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium20Black = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular20Black = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 20 black-1
  final TextStyle bold20Black1 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold20Black1 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium20Black1 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular20Black1 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 20 grey 1
  final TextStyle bold20Grey1 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold20Grey1 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium20Grey1 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular20Grey1 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 20 grey 2
  final TextStyle bold20Grey2 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold20Grey2 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium20Grey2 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular20Grey2 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 20 grey 3
  final TextStyle bold20Grey3 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold20Grey3 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium20Grey3 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular20Grey3 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 20 grey 4
  final TextStyle bold20Grey4 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold20Grey4 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium20Grey4 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular20Grey4 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 20 grey 5
  final TextStyle bold20Grey5 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold20Grey5 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium20Grey5 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular20Grey5 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 20  blue 11
  final TextStyle bold20Blue11 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold20Blue11 = TextTokens.gilroy.semibold_20.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium20Blue11 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular20Blue11 = TextTokens.gilroy.regular_20.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 20 Complementary 3
  final TextStyle bold20Complementary3 = TextTokens.gilroy.bold_20.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold20Complementary3 = TextTokens.gilroy.semibold_20
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium20Complementary3 = TextTokens.gilroy.medium_20.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular20Complementary3 = TextTokens.gilroy.regular_20
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 19  blue 11
  final TextStyle bold19Blue11 = TextTokens.gilroy.bold_19.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold19Blue11 = TextTokens.gilroy.semibold_19.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium19Blue11 = TextTokens.gilroy.medium_19.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular19Blue11 = TextTokens.gilroy.regular_19.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 18 white
  final TextStyle bold18White = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold18White = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium18White = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular18White = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 18 black
  final TextStyle bold18Black = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold18Black = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium18Black = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular18Black = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 18 black-1
  final TextStyle bold18Black1 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold18Black1 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium18Black1 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular18Black1 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 18 grey 1
  final TextStyle bold18Grey1 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold18Grey1 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium18Grey1 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular18Grey1 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 18 grey 2
  final TextStyle bold18Grey2 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold18Grey2 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium18Grey2 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular18Grey2 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 18 grey 3
  final TextStyle bold18Grey3 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold18Grey3 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium18Grey3 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular18Grey3 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 18 grey 4
  final TextStyle bold18Grey4 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold18Grey4 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium18Grey4 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular18Grey4 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 18 grey 5
  final TextStyle bold18Grey5 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold18Grey5 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium18Grey5 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular18Grey5 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 18 Complementary 3
  final TextStyle bold18Complementary3 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold18Complementary3 = TextTokens.gilroy.semibold_18
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium18Complementary3 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular18Complementary3 = TextTokens.gilroy.regular_18
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 18  blue 11
  final TextStyle bold18Blue11 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold18Blue11 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium18Blue11 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular18Blue11 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 16 white
  final TextStyle bold16White = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold16White = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium16White = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular16White = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 16 Complementary 3
  final TextStyle bold16Complementary3 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold16Complementary3 = TextTokens.gilroy.semibold_16
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium16Complementary3 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular16Complementary3 = TextTokens.gilroy.regular_16
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 16 Complementary 3 underlined
  final TextStyle bold16Complementary3Underlined = TextTokens.gilroy.bold_16
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle semiBold16Complementary3Underlined = TextTokens
      .gilroy
      .semibold_16
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle medium16Complementary3Underlined = TextTokens.gilroy.medium_16
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle regular16Complementary3Underlined = TextTokens
      .gilroy
      .regular_16
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );

  // Size 16 black
  final TextStyle bold16Black = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold16Black = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium16Black = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular16Black = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 16 black-1
  final TextStyle bold16Black1 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold16Black1 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium16Black1 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular16Black1 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 16 grey 1
  final TextStyle bold16Grey1 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold16Grey1 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium16Grey1 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular16Grey1 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 16 grey 2
  final TextStyle bold16Grey2 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold16Grey2 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium16Grey2 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular16Grey2 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 16 grey 3
  final TextStyle bold16Grey3 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold16Grey3 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium16Grey3 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular16Grey3 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 16 grey 4
  final TextStyle bold16Grey4 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold16Grey4 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium16Grey4 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular16Grey4 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 16 grey 5
  final TextStyle bold16Grey5 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold16Grey5 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium16Grey5 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular16Grey5 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 16  blue 11
  final TextStyle bold16Blue11 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold16Blue11 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium16Blue11 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular16Blue11 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
}

class _Paragraph {
  _Paragraph._();

  // Sa highlights General
  final TextStyle extraBoldSaHighlights = TextTokens.gilroy.extrabold.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle boldSaHighlights = TextTokens.gilroy.bold.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle semiBoldSaHighlights = TextTokens.gilroy.semibold.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle mediumSaHighlights = TextTokens.gilroy.medium.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle regularSaHighlights = TextTokens.gilroy.regular.copyWith(
    color: ColorFoundation.text.saHighlights,
  );

  // Size 12 white
  final TextStyle bold12White = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold12White = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium12White = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular12White = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 12 black
  final TextStyle bold12Black = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold12Black = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium12Black = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular12Black = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 12 black-1
  final TextStyle bold12Black1 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold12Black1 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium12Black1 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular12Black1 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 12 Complementary 3
  final TextStyle bold12Complementary3 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold12Complementary3 = TextTokens.gilroy.semibold_12
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium12Complementary3 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular12Complementary3 = TextTokens.gilroy.regular_12
      .copyWith(color: ColorFoundation.text.complementary3);

  //Size 12 Complementary 3 Underlined
  final TextStyle bold12Complementary3Underlined = TextTokens.gilroy.bold_12
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle semiBold12Complementary3Underlined = TextTokens
      .gilroy
      .semibold_12
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle medium12Complementary3Underlined = TextTokens.gilroy.medium_12
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle regular12Complementary3Underlined = TextTokens
      .gilroy
      .regular_12
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );

  // Size 12 grey 1
  final TextStyle bold12Grey1 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold12Grey1 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium12Grey1 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular12Grey1 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 12 grey 2
  final TextStyle bold12Grey2 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold12Grey2 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium12Grey2 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular12Grey2 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 12 grey 3
  final TextStyle bold12Grey3 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold12Grey3 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium12Grey3 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular12Grey3 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 12 grey 4
  final TextStyle bold12Grey4 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold12Grey4 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium12Grey4 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular12Grey4 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 12 grey 5
  final TextStyle bold12Grey5 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold12Grey5 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium12Grey5 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular12Grey5 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 12  blue 11
  final TextStyle bold12Blue11 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold12Blue11 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium12Blue11 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular12Blue11 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 12 negative
  final TextStyle bold12Negative = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle semiBold12Negative = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle medium12Negative = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle regular12Negative = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.negative,
  );

  // Size 12 grey 7
  final TextStyle bold12Grey7 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey7,
  );
  final TextStyle semiBold12Grey7 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey7,
  );
  final TextStyle medium12Grey7 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey7,
  );
  final TextStyle regular12Grey7 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey7,
  );

  // Size 14 white
  final TextStyle bold14White = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold14White = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium14White = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular14White = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 14 black
  final TextStyle bold14Black = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold14Black = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium14Black = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular14Black = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 14 black-1
  final TextStyle bold14Black1 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold14Black1 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium14Black1 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular14Black1 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 14 Complementary 3
  final TextStyle bold14Complementary3 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold14Complementary3 = TextTokens.gilroy.semibold_14
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium14Complementary3 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular14Complementary3 = TextTokens.gilroy.regular_14
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 14 Complementary 3 Underlined
  final TextStyle bold14Complementary3Underlined = TextTokens.gilroy.bold_14
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle semiBold14Complementary3Underlined = TextTokens
      .gilroy
      .semibold_14
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle medium14Complementary3Underlined = TextTokens.gilroy.medium_14
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );
  final TextStyle regular14Complementary3Underlined = TextTokens
      .gilroy
      .regular_14
      .copyWith(
        color: ColorFoundation.text.complementary3,
        decoration: TextDecoration.underline,
        decorationColor: ColorFoundation.text.complementary3,
      );

  // Size 14 grey 1
  final TextStyle bold14Grey1 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold14Grey1 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium14Grey1 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular14Grey1 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 14 grey 2
  final TextStyle bold14Grey2 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold14Grey2 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium14Grey2 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular14Grey2 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 14 grey 3
  final TextStyle bold14Grey3 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold14Grey3 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium14Grey3 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular14Grey3 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 14 grey 4
  final TextStyle bold14Grey4 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold14Grey4 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium14Grey4 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular14Grey4 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 14 grey 5
  final TextStyle bold14Grey5 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold14Grey5 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium14Grey5 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular14Grey5 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 14 grey 7
  final TextStyle bold14Grey7 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey7,
  );
  final TextStyle semiBold14Grey7 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey7,
  );
  final TextStyle medium14Grey7 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey7,
  );
  final TextStyle regular14Grey7 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey7,
  );

  // Size 14  blue 11
  final TextStyle bold14Blue11 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold14Blue11 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium14Blue11 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular14Blue11 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 14 negative
  final TextStyle bold14Negative = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle semiBold14Negative = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle medium14Negative = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle regular14Negative = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.negative,
  );

  // Size 14 Sa Dark
  final TextStyle bold14SaDark = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold14SaDark = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium14SaDark = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular14SaDark = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Size 14 Sa highlights
  final TextStyle extraBold14SaHighlights = TextTokens.gilroy.extrabold_14
      .copyWith(color: ColorFoundation.text.saHighlights);
  final TextStyle bold14SaHighlights = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle semiBold14SaHighlights = TextTokens.gilroy.semibold_14
      .copyWith(color: ColorFoundation.text.saHighlights);
  final TextStyle medium14SaHighlights = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle regular14SaHighlights = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.saHighlights,
  );

  // Size 15 Sa Light
  final TextStyle bold15SaLight = TextTokens.gilroy.bold_15.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle semiBold15SaLight = TextTokens.gilroy.semibold_15.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle medium15SaLight = TextTokens.gilroy.medium_15.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle regular15SaLight = TextTokens.gilroy.regular_15.copyWith(
    color: ColorFoundation.text.saLight,
  );

  // Size 15 Sa Dark
  final TextStyle bold15SaDark = TextTokens.gilroy.bold_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold15SaDark = TextTokens.gilroy.semibold_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium15SaDark = TextTokens.gilroy.medium_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular15SaDark = TextTokens.gilroy.regular_15.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Size 16 white
  final TextStyle bold16White = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold16White = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium16White = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular16White = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 16 black
  final TextStyle bold16Black = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold16Black = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium16Black = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular16Black = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 16 black-1
  final TextStyle bold16Black1 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold16Black1 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium16Black1 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular16Black1 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 16 blue
  final TextStyle semiBold16Blue30 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.blue30,
  );
  // Size 14 black-1
  final TextStyle semiBold14Blue30 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.blue30,
  );
  // Size 12 black-1
  final TextStyle semiBold12Blue30 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.blue30,
  );

  // Size 16 Complementary 3
  final TextStyle bold16Complementary3 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold16Complementary3 = TextTokens.gilroy.semibold_16
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium16Complementary3 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular16Complementary3 = TextTokens.gilroy.regular_16
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 16 Complementary 4
  final TextStyle bold16Complementary4 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.complementary4,
  );
  final TextStyle semiBold16Complementary4 = TextTokens.gilroy.semibold_16
      .copyWith(color: ColorFoundation.text.complementary4);
  final TextStyle medium16Complementary4 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.complementary4,
  );
  final TextStyle regular16Complementary4 = TextTokens.gilroy.regular_16
      .copyWith(color: ColorFoundation.text.complementary4);

  // Size 16 grey 1
  final TextStyle bold16Grey1 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold16Grey1 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium16Grey1 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular16Grey1 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 16 grey 2
  final TextStyle bold16Grey2 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold16Grey2 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium16Grey2 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular16Grey2 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 16 grey 3
  final TextStyle bold16Grey3 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold16Grey3 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium16Grey3 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular16Grey3 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 16 grey 4
  final TextStyle bold16Grey4 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold16Grey4 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium16Grey4 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular16Grey4 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 16 grey 5
  final TextStyle bold16Grey5 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold16Grey5 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium16Grey5 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular16Grey5 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 16  blue 11
  final TextStyle bold16Blue11 = TextTokens.gilroy.bold_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold16Blue11 = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium16Blue11 = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular16Blue11 = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 16 negative
  final TextStyle bold16Negative = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle semiBold16Negative = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle medium16Negative = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle regular16Negative = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.negative,
  );

  // Size 16 negative
  final TextStyle bold16saDark = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold16saDark = TextTokens.gilroy.semibold_16.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium16saDark = TextTokens.gilroy.medium_16.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular16saDark = TextTokens.gilroy.regular_16.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Size 18 white
  final TextStyle bold18White = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold18White = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium18White = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular18White = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 18 black
  final TextStyle bold18Black = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold18Black = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium18Black = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular18Black = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 18 black-1
  final TextStyle bold18Black1 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold18Black1 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium18Black1 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular18Black1 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 18 Complementary 3
  final TextStyle bold18Complementary3 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold18Complementary3 = TextTokens.gilroy.semibold_18
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium18Complementary3 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular18Complementary3 = TextTokens.gilroy.regular_18
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 18 grey 1
  final TextStyle bold18Grey1 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold18Grey1 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium18Grey1 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular18Grey1 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 18 grey 2
  final TextStyle bold18Grey2 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold18Grey2 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium18Grey2 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular18Grey2 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 18 grey 3
  final TextStyle bold18Grey3 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold18Grey3 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium18Grey3 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular18Grey3 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 18 grey 4
  final TextStyle bold18Grey4 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold18Grey4 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium18Grey4 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular18Grey4 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 18 grey 5
  final TextStyle bold18Grey5 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold18Grey5 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium18Grey5 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular18Grey5 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 18  blue 11
  final TextStyle bold18Blue11 = TextTokens.gilroy.bold_18.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle semiBold18Blue11 = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle medium18Blue11 = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.blue11,
  );
  final TextStyle regular18Blue11 = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.blue11,
  );

  // Size 18 negative
  final TextStyle bold18Negative = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle semiBold18Negative = TextTokens.gilroy.semibold_18.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle medium18Negative = TextTokens.gilroy.medium_18.copyWith(
    color: ColorFoundation.text.negative,
  );
  final TextStyle regular18Negative = TextTokens.gilroy.regular_18.copyWith(
    color: ColorFoundation.text.negative,
  );
}

class _Label {
  _Label._();

  // Sa Highlights Akkurat General
  final TextStyle akkuratExtraBoldSaHighlights = TextTokens.akkurat.extrabold
      .copyWith(color: ColorFoundation.text.saHighlights);
  final TextStyle akkuratBoldSaHighlights = TextTokens.akkurat.bold.copyWith(
    color: ColorFoundation.text.saHighlights,
  );
  final TextStyle akkuratSemiBoldSaHighlights = TextTokens.akkurat.semibold
      .copyWith(color: ColorFoundation.text.saHighlights);
  final TextStyle akkuratMediumSaHighlights = TextTokens.akkurat.medium
      .copyWith(color: ColorFoundation.text.saHighlights);
  final TextStyle akkuratRegularSaHighlights = TextTokens.akkurat.regular
      .copyWith(color: ColorFoundation.text.saHighlights);

  // Sa Dark General
  final TextStyle extraBoldSaDark = TextTokens.gilroy.extrabold.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle boldSaDark = TextTokens.gilroy.bold.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBoldSaDark = TextTokens.gilroy.semibold.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle mediumSaDark = TextTokens.gilroy.medium.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regularSaDark = TextTokens.gilroy.regular.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Size 10 white
  final TextStyle bold10White = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold10White = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium10White = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular10White = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 10 Black
  final TextStyle bold10Black = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold10Black = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium10Black = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular10Black = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 10 black-1
  final TextStyle bold10Black1 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold10Black1 = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium10Black1 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular10Black1 = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 10 Complementary 3
  final TextStyle bold10Complementary3 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold10Complementary3 = TextTokens.gilroy.semibold_10
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium10Complementary3 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular10Complementary3 = TextTokens.gilroy.regular_10
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 10 Complementary 4
  final TextStyle bold10Complementary4 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.complementary4,
  );
  final TextStyle semiBold10Complementary4 = TextTokens.gilroy.semibold_10
      .copyWith(color: ColorFoundation.text.complementary4);
  final TextStyle medium10Complementary4 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.complementary4,
  );
  final TextStyle regular10Complementary4 = TextTokens.gilroy.regular_10
      .copyWith(color: ColorFoundation.text.complementary4);

  // Size 10 grey 1
  final TextStyle bold10Grey1 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold10Grey1 = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium10Grey1 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular10Grey1 = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 10 grey 2
  final TextStyle bold10Grey2 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold10Grey2 = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium10Grey2 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular10Grey2 = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 10 grey 3
  final TextStyle bold10Grey3 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold10Grey3 = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium10Grey3 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular10Grey3 = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 10 grey 4
  final TextStyle bold10Grey4 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold10Grey4 = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium10Grey4 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular10Grey4 = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 10 grey 5
  final TextStyle bold10Grey5 = TextTokens.gilroy.bold_10.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold10Grey5 = TextTokens.gilroy.semibold_10.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium10Grey5 = TextTokens.gilroy.medium_10.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular10Grey5 = TextTokens.gilroy.regular_10.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 12 white
  final TextStyle bold12White = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold12White = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium12White = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular12White = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 12 black
  final TextStyle bold12Black = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold12Black = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium12Black = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular12Black = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 12 black-1
  final TextStyle bold12Black1 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold12Black1 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium12Black1 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular12Black1 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 12 Complementary 3
  final TextStyle bold12Complementary3 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold12Complementary3 = TextTokens.gilroy.semibold_12
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium12Complementary3 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular12Complementary3 = TextTokens.gilroy.regular_12
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 12 grey 1
  final TextStyle bold12Grey1 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold12Grey1 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium12Grey1 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular12Grey1 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 12 grey 2
  final TextStyle bold12Grey2 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold12Grey2 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium12Grey2 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular12Grey2 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 12 grey 3
  final TextStyle bold12Grey3 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold12Grey3 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium12Grey3 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular12Grey3 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 12 grey 4
  final TextStyle bold12Grey4 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold12Grey4 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium12Grey4 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular12Grey4 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 12 grey 5
  final TextStyle bold12Grey5 = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold12Grey5 = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium12Grey5 = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular12Grey5 = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 12 sa error
  final TextStyle bold12SaError = TextTokens.gilroy.bold_12.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle semiBold12SaError = TextTokens.gilroy.semibold_12.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle medium12SaError = TextTokens.gilroy.medium_12.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle regular12SaError = TextTokens.gilroy.regular_12.copyWith(
    color: ColorFoundation.text.saError,
  );

  // Size 14 white
  final TextStyle bold14White = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle semiBold14White = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle medium14White = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.white,
  );
  final TextStyle regular14White = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.white,
  );

  // Size 14 black
  final TextStyle bold14Black = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle semiBold14Black = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle medium14Black = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.black,
  );
  final TextStyle regular14Black = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.black,
  );

  // Size 14 black-1
  final TextStyle bold14Black1 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle semiBold14Black1 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle medium14Black1 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.black_1,
  );
  final TextStyle regular14Black1 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.black_1,
  );

  // Size 14 Complementary 3
  final TextStyle bold14Complementary3 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle semiBold14Complementary3 = TextTokens.gilroy.semibold_14
      .copyWith(color: ColorFoundation.text.complementary3);
  final TextStyle medium14Complementary3 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.complementary3,
  );
  final TextStyle regular14Complementary3 = TextTokens.gilroy.regular_14
      .copyWith(color: ColorFoundation.text.complementary3);

  // Size 14 Complementary 4
  final TextStyle bold14Complementary4 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.complementary4,
  );
  final TextStyle semiBold14Complementary4 = TextTokens.gilroy.semibold_14
      .copyWith(color: ColorFoundation.text.complementary4);
  final TextStyle medium14Complementary4 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.complementary4,
  );
  final TextStyle regular14Complementary4 = TextTokens.gilroy.regular_14
      .copyWith(color: ColorFoundation.text.complementary4);

  // Size 14 grey 1
  final TextStyle bold14Grey1 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle semiBold14Grey1 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle medium14Grey1 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey1,
  );
  final TextStyle regular14Grey1 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey1,
  );

  // Size 14 grey 2
  final TextStyle bold14Grey2 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle semiBold14Grey2 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle medium14Grey2 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey2,
  );
  final TextStyle regular14Grey2 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey2,
  );

  // Size 14 grey 3
  final TextStyle bold14Grey3 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle semiBold14Grey3 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle medium14Grey3 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey3,
  );
  final TextStyle regular14Grey3 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey3,
  );

  // Size 14 grey 4
  final TextStyle bold14Grey4 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle semiBold14Grey4 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle medium14Grey4 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey4,
  );
  final TextStyle regular14Grey4 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey4,
  );

  // Size 14 grey 5
  final TextStyle bold14Grey5 = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle semiBold14Grey5 = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle medium14Grey5 = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.grey5,
  );
  final TextStyle regular14Grey5 = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.grey5,
  );

  // Size 14 saDark
  final TextStyle extraBold14SaDark = TextTokens.gilroy.extrabold_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle bold14SaDark = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold14SaDark = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium14SaDark = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular14SaDark = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.saDark,
  );

  // Size 14 saLight
  final TextStyle extraBold14SaLight = TextTokens.gilroy.extrabold_14.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle bold14SaLight = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle semiBold14SaLight = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle medium14SaLight = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.saLight,
  );
  final TextStyle regular14SaLight = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.saLight,
  );

  // Size 14 saError
  final TextStyle extraBold14saError = TextTokens.gilroy.extrabold_14.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle bold14saError = TextTokens.gilroy.bold_14.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle semiBold14saError = TextTokens.gilroy.semibold_14.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle medium14saError = TextTokens.gilroy.medium_14.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle regular14saError = TextTokens.gilroy.regular_14.copyWith(
    color: ColorFoundation.text.saError,
  );

  // Size 15 saError
  final TextStyle extraBold15saError = TextTokens.gilroy.extrabold_15.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle bold15saError = TextTokens.gilroy.bold_15.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle semiBold15saError = TextTokens.gilroy.semibold_15.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle medium15saError = TextTokens.gilroy.medium_15.copyWith(
    color: ColorFoundation.text.saError,
  );
  final TextStyle regular15saError = TextTokens.gilroy.regular_15.copyWith(
    color: ColorFoundation.text.saError,
  );

  // 15 size Sa Dark
  final TextStyle extraBold15saDark = TextTokens.gilroy.extrabold_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle bold15saDark = TextTokens.gilroy.bold_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle semiBold15saDark = TextTokens.gilroy.semibold_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle medium15saDark = TextTokens.gilroy.medium_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
  final TextStyle regular15saDark = TextTokens.gilroy.regular_15.copyWith(
    color: ColorFoundation.text.saDark,
  );
}

// subtitulo , paraafo 12-18, label 10-14
