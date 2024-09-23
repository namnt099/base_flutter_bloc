import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    super.key,
    required this.title,
    this.outlineColor,
    this.backgroundColor,
    this.titleColor,
    required this.buttonSize,
    required this.onPress,
  });
  final String title;
  final ButtonSize buttonSize;
  final VoidCallback onPress;
  final Color? outlineColor;
  final Color? backgroundColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: buttonSize.padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.d8.responsive())),
          border: Border.all(
            color: outlineColor ?? AppTheme.getInstance().primaryColor,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.mediumText.copyWith(
              color: titleColor ?? AppTheme.getInstance().primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonSize {
  normal,
  wrap,
  small,
}

extension Parameter on ButtonSize {
  EdgeInsets get padding {
    switch (this) {
      case ButtonSize.normal:
        return EdgeInsets.symmetric(
          vertical: Dimens.d12.responsive(),
          horizontal: Dimens.d12.responsive(),
        );
      case ButtonSize.wrap:
        return EdgeInsets.symmetric(
          vertical: Dimens.d6.responsive(),
          horizontal: Dimens.d24.responsive(),
        );
      case ButtonSize.small:
        return EdgeInsets.symmetric(
          vertical: Dimens.d6.responsive(),
          horizontal: Dimens.d12.responsive(),
        );
      default:
        return EdgeInsets.zero;
    }
  }
}
