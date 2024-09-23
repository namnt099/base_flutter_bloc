import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/utils/style_utils.dart';

import '../../config/resources/dimens.dart';
import '../../config/themes/app_theme.dart';

class ToolbarArc extends StatelessWidget {
  const ToolbarArc({
    super.key,
    this.height,
    required this.title,
    this.leading,
    this.actions,
    required this.bottomWidget,
  });
  final double? height;
  final Widget title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Dimens.d180.responsive(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppTheme.getInstance().linearToolbar,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.d36.responsive()),
          bottomRight: Radius.circular(Dimens.d36.responsive()),
        ),
      ),
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: Dimens.d6.responsive()),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimens.d32.responsive()),
            bottomRight: Radius.circular(Dimens.d32.responsive()),
          ), // BorderRadius
        ),
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.d20.responsive(),
            vertical: Dimens.d12.responsive(),
          ),
          height: kToolbarHeight,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  leading ?? spaceW20,
                  title,
                  ...actions ?? [spaceW20],
                ],
              ),
              spaceH16,
              bottomWidget
            ],
          ),
        ), // BoxDecoration
      ),
    );
  }
}
