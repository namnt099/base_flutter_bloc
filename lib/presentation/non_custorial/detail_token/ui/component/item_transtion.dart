import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../../../config/resources/dimens.dart';
import '../../../../../config/resources/styles.dart';
import '../../../../../config/themes/app_theme.dart';
import '../../../../../domain/model/wallet/token_transaction.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/style_utils.dart';
import '../page/transaction_detail.dart';

Widget itemTransaction(TokenTransactionModel transaction) {
  return GestureDetector(
    onTap: () {
      Get.to(TransactionDetail(transaction: transaction));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: Dimens.d4.responsive()),
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.d12.responsive(),
        vertical: Dimens.d16.responsive(),
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().secondaryColor,
        boxShadow: ShadowUtil.shadowB149,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.d8.responsive())),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  transaction.getSmallIcon,
                  spaceW8,
                  Text(
                    transaction.type,
                    style: AppTextStyle.boldText.copyWith(fontSize: 14),
                  ),
                ],
              ),
              Text(
                transaction.dateTime,
                style: AppTextStyle.lightText.copyWith(
                  fontSize: 12,
                  color: AppTheme.getInstance().textSecondary,
                ),
              ),
            ],
          ),
          spaceH8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  transaction.getStatus,
                  spaceW8,
                  Text(
                    '${S.current.to}: ${transaction.walletAddressTo}',
                    style: AppTextStyle.lightText.copyWith(
                      fontSize: 14,
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                ],
              ),
              Text(
                transaction.amountFormatted,
                style: AppTextStyle.regularText.copyWith(
                  fontSize: 14,
                  color: AppTheme.getInstance().statusFail,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
