import 'package:flutter/material.dart';

const colorPrimary = Color(0xff038757);
const colorForm = Color(0xffE5F0F2);
const colorTextPrimary = Color(0xff2C2C2C);
const colorSecondary = Color(0xff9E9E9E);
const colorStroke = Color(0xff999999);
const colorComplete = Color(0xff0ACF97);
const colorPending = Color(0xffFAA500);
const colorFail = Color(0xffDE3138);
const colorLeftLiner = Color(0xff2C9F78);
const colorRightLinear = Color(0xff00B67F);
const colorSystemLeft = Color(0xff2C9F78);
const colorSystemRight = Color(0xff00B67F);
const colorShadow6 = Color(0xff162731);
const colorShadow9 = Color(0xff162731);
const colorBorder = Color(0xffEDEDED);
const colorChip = Color(0xffF0F0F0);
const colorExchange = Color(0xff596E73);

///=========== Using to make change app theme ================================
abstract class AppColor {
  Color get primaryColor;
  Color get formColor;
  Color get textPrimary;
  Color get textSecondary;
  Color get textStroke;
  Color get statusComplete;
  Color get statusPending;
  Color get statusFail;
  Color get shadow6;
  Color get shadow9;
  Color get secondaryColor;
  Color get dividerColor;
  Color get chipColor;
  Color get barrierColor;
  Color get exchangeColor;
  List<Color> get linearOnboarding;
  List<Color> get linearToolbar;
  List<Color> get linearSystemWallet;
}

class LightApp extends AppColor {
  @override
  Color get primaryColor {
    return colorPrimary;
  }

  @override
  Color get formColor {
    return colorForm;
  }

  @override
  Color get statusComplete {
    return colorComplete;
  }

  @override
  Color get statusFail {
    return colorFail;
  }

  @override
  Color get statusPending {
    return colorPending;
  }

  @override
  Color get textPrimary {
    return colorTextPrimary;
  }

  @override
  Color get textSecondary {
    return colorSecondary;
  }

  @override
  List<Color> get linearOnboarding {
    return [colorForm, Colors.white];
  }

  @override
  List<Color> get linearToolbar => [
        colorLeftLiner.withOpacity(0.2),
        colorRightLinear.withOpacity(0.2),
      ];

  @override
  List<Color> get linearSystemWallet => [
        colorSystemLeft,
        colorSystemRight,
      ];

  @override
  Color get shadow6 => colorShadow6;

  @override
  Color get secondaryColor => Colors.white;

  @override
  Color get dividerColor => colorBorder;

  @override
  Color get chipColor => colorChip;

  @override
  Color get shadow9 => colorShadow9;

  @override
  Color get textStroke => colorStroke;

  @override
  Color get barrierColor => textSecondary.withOpacity(0.3);

  @override
  Color get exchangeColor => colorExchange;
}

class DarkApp extends AppColor {
  @override
  Color get primaryColor {
    return colorPrimary;
  }

  @override
  Color get formColor {
    return colorForm;
  }

  @override
  Color get statusComplete {
    return colorComplete;
  }

  @override
  Color get statusFail {
    return colorFail;
  }

  @override
  Color get statusPending {
    return colorPending;
  }

  @override
  Color get textPrimary {
    return colorTextPrimary;
  }

  @override
  Color get textSecondary {
    return colorSecondary;
  }

  @override
  List<Color> get linearOnboarding {
    // TODO: implement linearColor
    throw UnimplementedError();
  }

  @override
  // TODO: implement linerToolbar
  List<Color> get linearToolbar => throw UnimplementedError();

  @override
  // TODO: implement linearSystemWallet
  List<Color> get linearSystemWallet => throw UnimplementedError();

  @override
  // TODO: implement shadow6
  Color get shadow6 => throw UnimplementedError();

  @override
  // TODO: implement secondary
  Color get secondaryColor => throw UnimplementedError();

  @override
  // TODO: implement borderColor
  Color get dividerColor => throw UnimplementedError();

  @override
  // TODO: implement chipColor
  Color get chipColor => throw UnimplementedError();

  @override
  // TODO: implement shadow9
  Color get shadow9 => throw UnimplementedError();

  @override
  // TODO: implement textStroke
  Color get textStroke => throw UnimplementedError();

  @override
  // TODO: implement barrierColor
  Color get barrierColor => throw UnimplementedError();

  @override
  // TODO: implement exchangeColor
  Color get exchangeColor => throw UnimplementedError();
}

///============ End setup app theme ======================================
