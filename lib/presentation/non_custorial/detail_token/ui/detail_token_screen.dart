import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/config/base/page/base_page_state.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/token_transaction.dart';
import 'package:sdk_wallet_flutter/presentation/non_custorial/detail_token/ui/page/receive_token.dart';
import 'package:sdk_wallet_flutter/presentation/non_custorial/detail_token/ui/page/send_token.dart';

import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

import '../../../../config/resources/dimens.dart';
import '../../../../config/resources/styles.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../domain/model/wallet/token.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/style_utils.dart';
import '../bloc/detail_token_bloc.dart';
import 'component/item_transtion.dart';
import 'page/funding_token.dart';
import 'page/transaction_history.dart';

class DetailTokenScreen extends StatefulWidget {
  const DetailTokenScreen({super.key, required this.token});
  final Token token;

  @override
  State<DetailTokenScreen> createState() => _DetailTokenScreenState();
}

class _DetailTokenScreenState
    extends BasePageState<DetailTokenScreen, DetailTokenBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().secondaryColor,
      appBar: toolbarCommon(
        title: '${widget.token.name}(${widget.token.symbol})',
        context: context,
      ),
      body: Column(
        children: [
          _buildHeaderToken(),
          spaceH32,
          _buildListTransactionHistory(),
        ],
      ),
    );
  }

  Widget _buildHeaderToken() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().secondaryColor,
        boxShadow: ShadowUtil.shadowB146,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            Dimens.d16.responsive(),
          ),
          bottomRight: Radius.circular(
            Dimens.d16.responsive(),
          ),
        ),
      ),
      child: Column(
        children: [
          spaceH20,
          //TODO
          ImageAssets.images.logoBtc.image(
            height: Dimens.d80.responsive(),
            width: Dimens.d80.responsive(),
            fit: BoxFit.cover,
          ),
          spaceH10,
          RichText(
            text: TextSpan(
              text: widget.token.symbol,
              style: AppTextStyle.mediumText.copyWith(
                fontSize: 32,
              ),
              children: [
                TextSpan(
                  text: ' ${widget.token.balance}',
                  style: AppTextStyle.mediumText.copyWith(
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),

          Text(
            ///TODO
            'USD:\$2000',
            style: AppTextStyle.lightText.copyWith(
              fontSize: 16,
            ),
          ),
          spaceH24,
          _buildActionToken(),
          spaceH30,
        ],
      ),
    );
  }

  Widget _buildActionToken() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _itemActionToken(
          callback: () {
            Get.to(
              () => SendToken(
                token: widget.token,
              ),
            );
          },
          actionName: S.current.send,
          image: ImageAssets.images.icSend,
        ),
        _itemActionToken(
          callback: () {
            Get.to(
              () => FundingToken(
                token: widget.token,
              ),
            );
          },
          actionName: S.current.funding,
          image: ImageAssets.images.icFunding,
        ),
        _itemActionToken(
          callback: () {
            Get.to(
              () => ReceiveToken(
                token: widget.token,
              ),
            );
          },
          actionName: S.current.receive,
          image: ImageAssets.images.icReceive,
        ),
      ],
    );
  }

  Widget _itemActionToken({
    required String actionName,
    required SvgGenImage image,
    required VoidCallback callback,
  }) {
    /// Width of screen minus two side padding(20 X 2)
    /// and space between three action (8 * 3) => d64
    ///  divide 3 get size one container action
    final width =
        (MediaQuery.of(context).size.width - Dimens.d64.responsive()) / 3;
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().secondaryColor,
          boxShadow: ShadowUtil.shadowB17,
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.d10.responsive())),
        ),
        padding: EdgeInsets.all(
          Dimens.d8.responsive(),
        ),
        child: Column(
          children: [
            image.svg(),
            spaceH4,
            Text(
              actionName,
              style: AppTextStyle.regularText.copyWith(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListTransactionHistory() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          //vertical: Dimens.d16.responsive(),
          horizontal: Dimens.d20.responsive(),
        ),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.lastest_transaction,
                  style: AppTextStyle.mediumText.copyWith(fontSize: 17),
                ),
              ],
            ),
            spaceH16,
            Expanded(
              child: ListView.builder(
                itemCount: TokenTransactionModel.transactions.length,
                itemBuilder: (context, index) => itemTransaction(
                  TokenTransactionModel.transactions[index],
                ),
              ),
            ),
            spaceH16,
            GestureDetector(
              onTap: () {
                Get.to(
                  TransactionHistory(
                    trans: TokenTransactionModel.transactions,
                  ),
                );
              },
              child: Text(
                S.current.see_all,
                style: AppTextStyle.regularText.apply(
                  color: AppTheme.getInstance().primaryColor,
                ),
              ),
            ),
            spaceH16,
          ],
        ),
      ),
    );
  }
}
