import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';

import '../config/resources/dimens.dart';
import 'extensions/app_dimen.dart';

const emptyView = SizedBox.shrink();

SizedBox toolBarHeight = SizedBox(
  height: kToolbarHeight.responsive(),
);
SizedBox navBarHeight = SizedBox(
  height: kBottomNavigationBarHeight.responsive(),
);

/// height and width space
SizedBox spaceH1 = SizedBox(height: Dimens.d1.responsive());
SizedBox spaceH2 = SizedBox(height: Dimens.d2.responsive());
SizedBox spaceH3 = SizedBox(height: Dimens.d3.responsive());
SizedBox spaceH4 = SizedBox(height: Dimens.d4.responsive());
SizedBox spaceH5 = SizedBox(height: Dimens.d5.responsive());
SizedBox spaceH6 = SizedBox(height: Dimens.d6.responsive());
SizedBox spaceH8 = SizedBox(height: Dimens.d8.responsive());
SizedBox spaceH9 = SizedBox(height: Dimens.d9.responsive());
SizedBox spaceH10 = SizedBox(height: Dimens.d10.responsive());
SizedBox spaceH12 = SizedBox(height: Dimens.d12.responsive());
SizedBox spaceH13 = SizedBox(height: Dimens.d13.responsive());
SizedBox spaceH14 = SizedBox(height: Dimens.d14.responsive());
SizedBox spaceH15 = SizedBox(height: Dimens.d15.responsive());
SizedBox spaceH16 = SizedBox(height: Dimens.d16.responsive());
SizedBox spaceH18 = SizedBox(height: Dimens.d18.responsive());
SizedBox spaceH20 = SizedBox(height: Dimens.d20.responsive());
SizedBox spaceH22 = SizedBox(height: Dimens.d22.responsive());
SizedBox spaceH24 = SizedBox(height: Dimens.d24.responsive());
SizedBox spaceH25 = SizedBox(height: Dimens.d25.responsive());
SizedBox spaceH26 = SizedBox(height: Dimens.d26.responsive());
SizedBox spaceH28 = SizedBox(height: Dimens.d28.responsive());
SizedBox spaceH30 = SizedBox(height: Dimens.d30.responsive());
SizedBox spaceH32 = SizedBox(height: Dimens.d32.responsive());
SizedBox spaceH34 = SizedBox(height: Dimens.d34.responsive());
SizedBox spaceH35 = SizedBox(height: Dimens.d35.responsive());
SizedBox spaceH36 = SizedBox(height: Dimens.d36.responsive());
SizedBox spaceH40 = SizedBox(height: Dimens.d40.responsive());
SizedBox spaceH42 = SizedBox(height: Dimens.d42.responsive());
SizedBox spaceH44 = SizedBox(height: Dimens.d44.responsive());
SizedBox spaceH48 = SizedBox(height: Dimens.d48.responsive());
SizedBox spaceH50 = SizedBox(height: Dimens.d50.responsive());
SizedBox spaceH56 = SizedBox(height: Dimens.d56.responsive());
SizedBox spaceH60 = SizedBox(height: Dimens.d60.responsive());
SizedBox spaceH64 = SizedBox(height: Dimens.d64.responsive());
SizedBox spaceH70 = SizedBox(height: Dimens.d70.responsive());
SizedBox spaceH84 = SizedBox(height: Dimens.d84.responsive());
SizedBox spaceH85 = SizedBox(height: Dimens.d85.responsive());
SizedBox spaceH100 = SizedBox(height: Dimens.d100.responsive());
SizedBox spaceH200 = SizedBox(height: Dimens.d200.responsive());

///W
SizedBox spaceW1 = SizedBox(width: Dimens.d1.responsive());
SizedBox spaceW2 = SizedBox(width: Dimens.d2.responsive());
SizedBox spaceW3 = SizedBox(width: Dimens.d3.responsive());
SizedBox spaceW4 = SizedBox(width: Dimens.d4.responsive());
SizedBox spaceW5 = SizedBox(width: Dimens.d5.responsive());
SizedBox spaceW6 = SizedBox(width: Dimens.d6.responsive());
SizedBox spaceW8 = SizedBox(width: Dimens.d8.responsive());
SizedBox spaceW9 = SizedBox(width: Dimens.d9.responsive());
SizedBox spaceW10 = SizedBox(width: Dimens.d10.responsive());
SizedBox spaceW12 = SizedBox(width: Dimens.d12.responsive());
SizedBox spaceW14 = SizedBox(width: Dimens.d14.responsive());
SizedBox spaceW15 = SizedBox(width: Dimens.d15.responsive());
SizedBox spaceW16 = SizedBox(width: Dimens.d16.responsive());
SizedBox spaceW18 = SizedBox(width: Dimens.d18.responsive());
SizedBox spaceW20 = SizedBox(width: Dimens.d20.responsive());
SizedBox spaceW24 = SizedBox(width: Dimens.d24.responsive());
SizedBox spaceW25 = SizedBox(width: Dimens.d25.responsive());
SizedBox spaceW28 = SizedBox(width: Dimens.d28.responsive());
SizedBox spaceW30 = SizedBox(width: Dimens.d30.responsive());
SizedBox spaceW32 = SizedBox(width: Dimens.d32.responsive());
SizedBox spaceW36 = SizedBox(width: Dimens.d36.responsive());
SizedBox spaceW48 = SizedBox(width: Dimens.d48.responsive());
SizedBox spaceW64 = SizedBox(width: Dimens.d64.responsive());

class ShadowUtil {
  ShadowUtil._();

  static final List<BoxShadow> shadowB20 = [
    BoxShadow(
      color: Colors.transparent.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];
  static final List<BoxShadow> shadowB146 = [
    BoxShadow(
      color: AppTheme.getInstance().shadow6.withOpacity(0.06),
      blurRadius: 14,
    ),
  ];
  static final List<BoxShadow> shadowB149 = [
    BoxShadow(
      color: AppTheme.getInstance().shadow9.withOpacity(0.09),
      blurRadius: 14,
    ),
  ];
  static final List<BoxShadow> shadowB15 = [
    BoxShadow(
      color: Colors.transparent.withOpacity(0.1),
      blurRadius: 15,
    ),
  ];
  static final List<BoxShadow> shadowB17 = [
    BoxShadow(
      color: Colors.transparent.withOpacity(0.1),
      blurRadius: 17,
    ),
  ];
  static Divider divider({Color? color, double? thick}) => Divider(
        color: color ?? AppTheme.getInstance().dividerColor,
        thickness: thick,
      );
}
