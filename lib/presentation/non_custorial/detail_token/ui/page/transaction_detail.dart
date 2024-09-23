import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/token_transaction.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

import '../../../../../utils/style_utils.dart';

class TransactionDetail extends StatelessWidget {
  const TransactionDetail({
    super.key,
    required this.transaction,
  });
  final TokenTransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(
        title: S.current.transaction_detail,
        context: context,
      ),
      body: Column(
        children: [
          spaceH16,
          rowItem('Receiver', transaction.walletAddressTo),
          rowItem('Sender', transaction.walletAddressFrom),
          rowItem('Network', transaction.network),
          //todo
          rowItem('Crypto type', transaction.symbol),
          rowItem('Amount', transaction.amountFormatted),
          rowItem('Time stamp', transaction.dateTime),
          rowItem('Status', transaction.status),
          rowItem('Gas fee', '${transaction.gasFee} ${transaction.gasSymbol}'),
        ],
      ),
    );
  }

  Widget rowItem(String title, String content) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimens.d20.responsive(),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Dimens.d12.responsive(),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.getInstance().dividerColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.regularText.copyWith(
              fontSize: 14,
              color: AppTheme.getInstance().textSecondary,
            ),
          ),
          Text(
            content,
            style: AppTextStyle.regularText.copyWith(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
