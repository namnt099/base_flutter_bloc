import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_widget/flutter_expandable_widget.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../../config/resources/dimens.dart';
import '../../../../config/resources/styles.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/toolbar/toolbar_common.dart';

class ExportWalletPage extends StatefulWidget {
  const ExportWalletPage({
    super.key,
    required this.privateKey,
  });

  final String privateKey;

  @override
  State<ExportWalletPage> createState() => _ExportWalletPageState();
}

class _ExportWalletPageState extends State<ExportWalletPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(
        title: S.current.export_wallet,
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
        child: Column(
          children: [
            spaceH16,
            _buildItem(
              callback: () {},
              text: S.current.private_key,
              child: Padding(
                padding: EdgeInsets.only(
                  right: Dimens.d16.responsive(),
                  left: Dimens.d16.responsive(),
                  bottom: Dimens.d16.responsive(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.privateKey,
                      style: AppTextStyle.regularText.copyWith(fontSize: 12),
                    ),
                    spaceH24,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.privateKey),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            S.current.copy,
                            style: AppTextStyle.regularText.copyWith(
                              fontSize: 12,
                              color: AppTheme.getInstance().primaryColor,
                            ),
                          ),
                          spaceW8,
                          ImageAssets.images.icCopy.svg()
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            spaceH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageAssets.images.icWarning.svg(),
                spaceW16,
                Expanded(
                  child: Text(
                    S.current.warning_export,
                    style: AppTextStyle.lightText.copyWith(
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    required String text,
    required VoidCallback callback,
    required Widget child,
  }) =>
      GestureDetector(
        onTap: callback,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.getInstance().textPrimary,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.d8.responsive()),
            ),
          ),
          child: ExpandableWidget.content(
            padding: EdgeInsets.zero,
            trailingStartTurns: 0.5,
            titleMargin: EdgeInsets.only(right: Dimens.d14.responsive()),
            trailing: Transform.rotate(
              angle: pi / 2,
              child: Transform.scale(
                scale: 0.5,
                child: ImageAssets.images.icBasicBack.svg(
                  color: AppTheme.getInstance().textSecondary,
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.all(Dimens.d16.responsive()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppTextStyle.regularText.copyWith(
                      fontSize: 14,
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            content: child,
          ),
        ),
      );

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
