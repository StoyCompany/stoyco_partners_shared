//  ..................................................
//  .██████╗.██████╗.██╗......██████╗.██████╗.███████╗
//  ██╔════╝██╔═══██╗██║.....██╔═══██╗██╔══██╗██╔════╝
//  ██║.....██║...██║██║.....██║...██║██████╔╝███████╗
//  ██║.....██║...██║██║.....██║...██║██╔══██╗╚════██║
//  ╚██████╗╚██████╔╝███████╗╚██████╔╝██║..██║███████║
//  .╚═════╝.╚═════╝.╚══════╝.╚═════╝.╚═╝..╚═╝╚══════╝
//  ..................................................

import 'package:flutter/material.dart';

import 'package:stoyco_partners_shared/design/utils/tokens/gen/colors.gen.dart';

class ColorFoundation {
  ColorFoundation._internal();

  static final _Text text = _Text._();
  static final _Background background = _Background._();
  static final _Border border = _Border._();
  static final _Gradient gradient = _Gradient._();
  static final _Shadow shadow = _Shadow._();
}

class _Text {
  _Text._();

  final Color black = StoycoColorsToken.black;
  final Color black_1 = StoycoColorsToken.black1;
  final Color black_3 = StoycoColorsToken.black3;
  final Color saDark = StoycoColorsToken.saDark;
  final Color white = StoycoColorsToken.white;
  final Color saLight = StoycoColorsToken.saLight;

  final Color grey1 = StoycoColorsToken.grey1;
  final Color grey2 = StoycoColorsToken.grey2;
  final Color grey3 = StoycoColorsToken.grey3;
  final Color grey4 = StoycoColorsToken.grey4;
  final Color grey5 = StoycoColorsToken.grey5;
  final Color grey7 = StoycoColorsToken.grey7;
  final Color grey8 = StoycoColorsToken.grey8;
  final Color grey9 = StoycoColorsToken.grey9;
  final Color grey10 = StoycoColorsToken.grey10;
  final Color grey11 = StoycoColorsToken.grey11;
  final Color grey12 = StoycoColorsToken.grey12;
  final Color grey13 = StoycoColorsToken.grey13;
  final Color grey14 = StoycoColorsToken.grey14;

  final Color success = StoycoColorsToken.complementario4;
  final Color negative = StoycoColorsToken.tertiary1;

  final Color complementary3 = StoycoColorsToken.complementario3;
  final Color complementary4 = StoycoColorsToken.complementario4;
  final Color blue10 = StoycoColorsToken.blue10;
  final Color blue30 = StoycoColorsToken.blue30;
  final Color blue5 = StoycoColorsToken.blue5;
  final Color blue11 = StoycoColorsToken.blue11;

  final Color transparent = StoycoColorsToken.transparent;

  final Color blueBackgroundIcons = StoycoColorsToken.blueBackgroundIcons;

  final Color fandom = StoycoColorsToken.saLightMenu;

  final Color saHighlights = StoycoColorsToken.saHighlights;
  final Color saTextDisabled = StoycoColorsToken.saTextDisabled;
  final Color saError = StoycoColorsToken.saError;
  final Color saSuccess = StoycoColorsToken.saSuccess;
  final Color saGreen = StoycoColorsToken.saGreen;

  final Color itemMenuBlue = StoycoColorsToken.itemMenuBlue;
  final Color itemMenuRed = StoycoColorsToken.itemMenuRed;
  final Color itemMenuYellow = StoycoColorsToken.itemMenuYellow;
  final Color itemMenuOrange = StoycoColorsToken.itemMenuOrange;

  final Color textGrayFinancialLayer = StoycoColorsToken.textGrayFinancialLayer;
  final Color darkGrayFinancialLayer = StoycoColorsToken.darkGrayFinancialLayer;
  final Color blackFinancialLayer = StoycoColorsToken.blackFinancialLayer;

  final Color greenAccent = StoycoColorsToken.greenAccent;
  final Color greenLight = StoycoColorsToken.greenLight;
  final Color saWhite = StoycoColorsToken.saWhite;
}

class _Background {
  _Background._();

  final Color black = StoycoColorsToken.black;
  final Color black1 = StoycoColorsToken.black1;
  final Color black2 = StoycoColorsToken.black2;
  final Color black3 = StoycoColorsToken.black3;
  final Color black4 = StoycoColorsToken.black4;
  final Color black5 = StoycoColorsToken.black5;
  final Color saDark = StoycoColorsToken.saDark;
  final Color saDark2 = StoycoColorsToken.saDark2;
  final Color white = StoycoColorsToken.white;
  final Color saLight = StoycoColorsToken.saLight;
  final Color saWhite = StoycoColorsToken.saWhite;

  final Color greenClear = StoycoColorsToken.greenClear;
  final Color greenDark = StoycoColorsToken.greendark;
  final Color greenMenu = StoycoColorsToken.greenMenu;
  final Color greenTable = StoycoColorsToken.greenTable;
  final Color greenAccent = StoycoColorsToken.greenAccent;
  final Color greenLight = StoycoColorsToken.greenLight;

  final Color grey1 = StoycoColorsToken.grey1;
  final Color grey2 = StoycoColorsToken.grey2;
  final Color grey3 = StoycoColorsToken.grey3;
  final Color grey4 = StoycoColorsToken.grey4;
  final Color grey5 = StoycoColorsToken.grey5;
  final Color grey6 = StoycoColorsToken.grey6;
  final Color grey7 = StoycoColorsToken.grey7;
  final Color grey8 = StoycoColorsToken.grey8;
  final Color grey9 = StoycoColorsToken.grey9;
  final Color grey10 = StoycoColorsToken.grey10;
  final Color grey11 = StoycoColorsToken.grey11;
  final Color grey12 = StoycoColorsToken.grey12;
  final Color grey13 = StoycoColorsToken.grey13;
  final Color grey14 = StoycoColorsToken.grey14;
  final Color grey15 = StoycoColorsToken.grey15;
  final Color grey16 = StoycoColorsToken.grey16;

  final Color complementario1 = StoycoColorsToken.complementario1;
  final Color complementario2 = StoycoColorsToken.complementario2;
  final Color complementario3 = StoycoColorsToken.complementario3;
  final Color complementario4 = StoycoColorsToken.complementario4;
  final Color tertiary1 = StoycoColorsToken.tertiary1;
  final Color tertiary3 = StoycoColorsToken.tertiary3;

  final Color blue10 = StoycoColorsToken.blue10;
  final Color blue30 = StoycoColorsToken.blue30;
  final Color blue5 = StoycoColorsToken.blue5;
  final Color blue11 = StoycoColorsToken.blue11;

  final Color header1 = StoycoColorsToken.header1;
  final Color header2 = StoycoColorsToken.header2;

  final Color lineCard1 = StoycoColorsToken.lineCard1;
  final Color lineCard2 = StoycoColorsToken.lineCard2;

  final Color cardIntermediate1 = StoycoColorsToken.cardIntermediate1;
  final Color cardIntermediate2 = StoycoColorsToken.cardIntermediate2;

  final Color cardAffirmative1 = StoycoColorsToken.cardAffirmative1;
  final Color cardAffirmative2 = StoycoColorsToken.cardAffirmative2;

  final Color transparent = StoycoColorsToken.transparent;

  final Color blueBackgroundIcons = StoycoColorsToken.blueBackgroundIcons;

  final Color notificationSuccess = StoycoColorsToken.greenMenu;
  final Color notificationFailed = StoycoColorsToken.failed;

  final Color notificationToBack = StoycoColorsToken.black2;

  final Color blur = StoycoColorsToken.blur;

  final Color darkYellow = StoycoColorsToken.darkYellow;

  final Color saHighlights = StoycoColorsToken.saHighlights;
  final Color saLightPurple = StoycoColorsToken.saLightPurple;

  final Color saDisabled = StoycoColorsToken.saDisabled;

  final Color saViolet = StoycoColorsToken.saViolet;

  final Color fandom = StoycoColorsToken.saLightMenu;

  final Color divider = StoycoColorsToken.saLight.withOpacity(0.3);

  final Color chartBlue = StoycoColorsToken.blueChart;
  final Color chartGreen = StoycoColorsToken.greenChart;
  final Color chartPurple = StoycoColorsToken.purpleChart;
  final Color chartBlack = StoycoColorsToken.blackChart;

  final Color errorAler = StoycoColorsToken.saError;
  final Color successAler = StoycoColorsToken.spGreen;
  final Color warningAler = StoycoColorsToken.itemMenuYellow;

  final Color saSkeleton = StoycoColorsToken.saSkeleton;

  final Color saDisabled2 = StoycoColorsToken.saDisabled2;

  final Color deepCharcoal = StoycoColorsToken.deepCharcoal;

  final Color cardFinancialLayer = StoycoColorsToken.cardFinancialLayer;

  final Color cardGrayFinancialLayer = StoycoColorsToken.darkGrayFinancialLayer;

  final Color blackFinancialLayer = StoycoColorsToken.blackFinancialLayer;

  final Color cardFinancialLayerType2 =
      StoycoColorsToken.cardFinancialLayerType2;
  final Color borderFinancialLayerType2 =
      StoycoColorsToken.borderFinancialLayerType2;
}

class _Border {
  _Border._();

  final Color googleButton = StoycoColorsToken.blue11;
  final Color buttonPrimary = StoycoColorsToken.complementario3;
  final Color buttonDisable = StoycoColorsToken.transparent;
  final Color buttonSelector = StoycoColorsToken.grey3;
  final Color buttonText = StoycoColorsToken.complementario3;
  final Color textFieldInactivate = StoycoColorsToken.grey3;
  final Color textFieldActivate = StoycoColorsToken.complementario3;
  final Color textFieldError = StoycoColorsToken.tertiary1;
  final Color customerCard = StoycoColorsToken.grey4;
  final Color greenBorder = StoycoColorsToken.greenClear;

  final Color saError = StoycoColorsToken.saError;
  final Color saDark = StoycoColorsToken.saDark;
  final Color saLight = StoycoColorsToken.saLight;
  final Color saHighlights = StoycoColorsToken.saHighlights;
  final Color saBorderHeader = StoycoColorsToken.grey7;
}

class _Shadow {
  _Shadow._();

  final Color cardHelp = StoycoColorsToken.shadow1;
  final Color buttom = StoycoColorsToken.transparent;
  final Color saHighlights = StoycoColorsToken.saHighlights;
}

class _Gradient {
  _Gradient._();

  final List<Color> headerApp = <Color>[
    StoycoColorsToken.header1,
    StoycoColorsToken.header2,
  ];

  final List<Color> borderBox = <Color>[
    StoycoColorsToken.complementario3,
    StoycoColorsToken.lineCard2,
  ];

  final List<Color> drawerApp = <Color>[
    StoycoColorsToken.lineCard1.withOpacity(0.4),
    StoycoColorsToken.lineCard2.withOpacity(0.4),
  ];

  final List<Color> cardAffirmative = <Color>[
    StoycoColorsToken.cardAffirmative1,
    StoycoColorsToken.cardAffirmative2,
  ];

  final List<Color> cardIntermediate = <Color>[
    StoycoColorsToken.cardIntermediate1,
    StoycoColorsToken.cardIntermediate2,
  ];

  final List<Color> cardNegative = <Color>[
    StoycoColorsToken.cardNegative1,
    StoycoColorsToken.cardNegative2,
  ];

  final List<Color> cardInfo = <Color>[
    StoycoColorsToken.lineCard1,
    StoycoColorsToken.lineCard2,
  ];

  final List<Color> white = <Color>[
    StoycoColorsToken.whiteGradient,
    StoycoColorsToken.white,
  ];
}
