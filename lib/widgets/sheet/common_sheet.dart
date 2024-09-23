import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../config/resources/dimens.dart';
import '../../utils/style_utils.dart';

class CommonSheet extends StatefulWidget {
  const CommonSheet({super.key, required this.title, this.actions = const []});
  final String title;
  final List<Widget> actions;

  @override
  State<CommonSheet> createState() => _CommonSheetState();
}

class _CommonSheetState extends State<CommonSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().secondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimens.d32.responsive()),
            topRight: Radius.circular(Dimens.d32.responsive()),
          ),
        ),
        padding: EdgeInsets.all(Dimens.d20.responsive()),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: ImageAssets.images.icClose.svg(),
                ),
                Text(
                  widget.title,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ...widget.actions,
              ],
            ),
            spaceH20,
          ],
        ),
      ),
    );
  }
}
