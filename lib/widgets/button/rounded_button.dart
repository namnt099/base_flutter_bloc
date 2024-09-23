import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton({super.key, required this.image, required this.onTap});
  final SvgGenImage image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: image.svg(
          color: AppTheme.getInstance().secondaryColor,
          height: Dimens.d24.responsive(),
          width: Dimens.d24.responsive(),
        ),
      ),
    );
  }
}
