import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/config/base/page/base_page_state.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';
import 'package:sdk_wallet_flutter/presentation/non_custorial/detail_token/ui/detail_token_screen.dart';
import 'package:sdk_wallet_flutter/presentation/shared/token/token_list_screen.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/bloc/wallet_bloc.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/bloc/wallet_event.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/bloc/wallet_state.dart';

import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/button/primary_button.dart';
import 'package:sdk_wallet_flutter/widgets/dialog/custom_alert_dialog.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_arc.dart';

import '../../../../config/resources/dimens.dart';
import '../../../../config/resources/styles.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../domain/model/wallet/token.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/button/common_back_button.dart';
import '../../../../widgets/dialog/custom_enter_dialog.dart';
import '../../../../widgets/sheet/action_sheet.dart';

class DetailWalletPage extends StatefulWidget {
  const DetailWalletPage({super.key, required this.model});
  final Wallet model;

  @override
  State<DetailWalletPage> createState() => _DetailWalletPageState();
}

class _DetailWalletPageState
    extends BasePageState<DetailWalletPage, WalletBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ToolbarArc(
                  height: widget.model.kind == WalletKind.custorial
                      ? Dimens.d222.responsive()
                      : null,
                  title: BlocBuilder<WalletBloc, WalletState>(
                    bloc: bloc,
                    buildWhen: (previous, current) =>
                        previous.currentWalletName != current.currentWalletName,
                    builder: (context, state) {
                      return Text(
                        state.currentWalletName ?? '',
                        style: AppTextStyle.boldText.copyWith(
                          color: AppTheme.getInstance().secondaryColor,
                        ),
                      );
                    },
                  ),
                  leading: const CommonButtonBack(),
                  actions: [
                    GestureDetector(
                      onTap: _onPressAction,
                      child: ImageAssets.images.icMoreHozirontal.svg(),
                    )
                  ],
                  bottomWidget: Column(
                    children: [
                      Text(
                        //TODO
                        '\$10000',
                        style: AppTextStyle.boldText.copyWith(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                      if (widget.model.kind == WalletKind.custorial) spaceH16,
                      widget.model.systemWidget(),
                    ],
                  ),
                ),
                spaceH32,
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
                  child: Text(
                    S.current.token_list,
                    style: AppTextStyle.regularText.copyWith(
                      color: AppTheme.getInstance().textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                spaceH6,
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.d20.responsive(),
                    ),
                    itemCount: widget.model.tokens.length,
                    itemBuilder: (context, index) => _itemTokenBuilder(
                      widget.model.tokens[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d20.responsive(),
            ),
            child: PrimaryButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TokenListScreen(
                      title: S.current.token_list,
                    ),
                  ),
                );
              },
              title: S.current.add_token,
              buttonType: ButtonType.secondary,
            ),
          ),
          spaceH40,
        ],
      ),
    );
  }

  void _onPressAction() {
    showActionSheet(
      context,
      actions: _buildActionChildren,
      cancel: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.d8.responsive()),
          ),
        ),
        child: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            S.current.cancel,
            style: AppTextStyle.regularText.copyWith(
              color: AppTheme.getInstance().textSecondary,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _buildActionChildren => [
        _actionChild(
          callback: () {
            showDialog(
              barrierColor: AppTheme.getInstance().barrierColor,
              context: context,
              builder: (context) => CustomEnterDialog(
                hintext: S.current.enter_name,
                onConfirm: (value) {
                  bloc.add(
                    UpdatedWalletName(
                      widget.model.walletName,
                      value,
                    ),
                  );
                },
                title: S.current.rename_wallet,
              ),
            );
          },
          image: ImageAssets.images.icEdit,
          text: S.current.rename,
        ),
        _actionChild(
          callback: () {
            bloc.add(ExportedWallet(widget.model.walletAddress));
          },
          image: ImageAssets.images.icExport,
          text: S.current.export_wallet,
        ),
        _actionChild(
          callback: () {
            showDialog(
              barrierColor: AppTheme.getInstance().barrierColor,
              context: context,
              builder: (context) => CustomAlertDialog(
                onConfirm: () {
                  Get.back();
                  bloc.add(DeletedWallet(widget.model.walletName));
                },
                title: S.current.are_you_remove_wallet,
                content: S.current.content_warning_delete_wallet,
              ),
            );
          },
          image: ImageAssets.images.icRemove,
          text: S.current.remove_wallet,
          showDivider: false,
        ),
      ];

  Widget _actionChild({
    required String text,
    required SvgGenImage image,
    required VoidCallback callback,
    bool showDivider = true,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().secondaryColor,
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: AppTheme.getInstance().dividerColor,
                  ),
                )
              : null,
        ),
        child: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            callback.call();
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: Dimens.d24.responsive(),
              vertical: Dimens.d8.responsive(),
            ),
            child: Row(
              children: [
                image.svg(),
                spaceW20,
                Text(
                  text,
                  style: AppTextStyle.regularText.copyWith(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      );

  Widget _itemTokenBuilder(Token model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailTokenScreen(token: model)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(Dimens.d16.responsive()),
        margin: EdgeInsets.symmetric(vertical: Dimens.d6.responsive()),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.d10.responsive())),
          color: AppTheme.getInstance().secondaryColor,
          boxShadow: ShadowUtil.shadowB146,
        ),
        child: Row(
          children: [
            //TODO
            ImageAssets.images.logoBtc.image(),
            spaceW12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: model.name,
                      style: AppTextStyle.boldText.copyWith(
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${model.symbol}',
                          style: AppTextStyle.lightText.copyWith(
                            color: AppTheme.getInstance().textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  spaceH6,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${model.balance} ${model.symbol}',
                        style: AppTextStyle.regularText.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ///TODO
                        '\$2000',
                        style: AppTextStyle.regularText.copyWith(
                          fontSize: 14,
                          color: AppTheme.getInstance().textSecondary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
