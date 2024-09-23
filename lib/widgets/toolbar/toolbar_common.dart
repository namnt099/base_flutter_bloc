import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

AppBar toolbarCommon({
  required String title,
  required BuildContext context,
}) =>
    AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Transform.scale(
          scale: 0.4,
          child: SizedBox(
            height: Dimens.d36.responsive(),
            width: Dimens.d36.responsive(),
            child: ImageAssets.images.icBasicBack.svg(),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: AppTextStyle.regularText.copyWith(
          color: AppTheme.getInstance().textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevation: 6,
      shadowColor: Colors.transparent.withOpacity(0.1),
    );
