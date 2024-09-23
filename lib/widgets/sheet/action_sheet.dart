import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../utils/style_utils.dart';
import '../cupertino/cupertino_custom.dart';

void showActionSheet(
  BuildContext context, {
  required List<Widget> actions,
  required Widget cancel,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CustomActionSheet(
      actions: actions,
      cancel: cancel,
    ),
  );
}

class CustomActionSheet extends StatelessWidget {
  final List<Widget> actions;
  final Widget cancel;
  const CustomActionSheet({
    super.key,
    required this.actions,
    required this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurfaceCustom(
      isSurfacePainted: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d8.responsive()),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.d8.responsive()),
                ),
              ),
              child: Column(children: actions),
            ),
            spaceH8,
            cancel,
            spaceH32,
          ],
        ),
      ),
    );
  }
}
