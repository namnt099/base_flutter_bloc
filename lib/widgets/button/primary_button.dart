import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../utils/style_utils.dart';

enum ButtonType { primary, secondary }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.title,
    this.kind = ButtonKind.none,
    this.image,
    this.height,
    this.width,
    this.buttonType = ButtonType.primary,
    this.horizontalPadding,
  });
  final VoidCallback onTap;
  final String title;
  final ButtonKind kind;
  final SvgGenImage? image;
  final double? height;
  final double? width;
  final double? horizontalPadding;

  final ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: Dimens.d12.responsive(),
          horizontal: horizontalPadding ?? Dimens.d24.responsive(),
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance()
              .primaryColor
              .withOpacity(buttonType == ButtonType.primary ? 1 : 0.1),
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.d8.responsive())),
        ),
        child: kind.getChild(
          text: title,
          image: image,
          buttonType: buttonType,
        ),
      ),
    );
  }
}

enum ButtonKind { left, right, none }

extension ButtonChild on ButtonKind {
  Widget getChild({
    required String text,
    SvgGenImage? image,
    ButtonType buttonType = ButtonType.primary,
  }) {
    switch (this) {
      case ButtonKind.none:
        return Center(
          child: Text(
            text,
            style: AppTextStyle.regularText.copyWith(
              fontSize: 18,
              color: buttonType == ButtonType.primary
                  ? AppTheme.getInstance().secondaryColor
                  : AppTheme.getInstance().primaryColor,
            ),
          ),
        );
      case ButtonKind.left:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image?.svg() ?? const SizedBox.shrink(),
            spaceW8,
            Text(
              text,
              style: AppTextStyle.regularText.copyWith(
                fontSize: 18,
                color: buttonType == ButtonType.primary
                    ? AppTheme.getInstance().secondaryColor
                    : AppTheme.getInstance().primaryColor,
              ),
            ),
          ],
        );
      case ButtonKind.right:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyle.regularText.copyWith(
                fontSize: 18,
                color: buttonType == ButtonType.primary
                    ? AppTheme.getInstance().secondaryColor
                    : AppTheme.getInstance().primaryColor,
              ),
            ),
            spaceW8,
            image?.svg() ?? const SizedBox.shrink(),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
