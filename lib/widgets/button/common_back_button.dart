import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';

class CommonButtonBack extends StatelessWidget {
  const CommonButtonBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: ImageAssets.images.icBasicBack.svg(
          color: AppTheme.getInstance().formColor,
        ),
      ),
    );
  }
}
