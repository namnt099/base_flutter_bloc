import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/number_ext.dart';
import 'package:sdk_wallet_flutter/utils/extensions/string_ext.dart';

import '../../../config/themes/app_theme.dart';
import '../../../generated/l10n.dart';

class TokenTransactionModel {
  String type;
  String addressTo;
  double amount;
  String symbol;
  String dateTime;
  String id;

  ///for detail
  double gasFee;
  String? gasSymbol;
  String status;
  String txnHash;
  String addressFrom;
  String none;
  String network;
  String? title;

  TokenTransactionModel({
    this.type = '',
    this.addressTo = '',
    this.amount = 0,
    this.symbol = '',
    this.dateTime = '',
    this.id = '',
    this.addressFrom = '',
    this.gasFee = 0,
    this.none = '',
    this.status = '',
    this.txnHash = '',
    this.network = '',
  });

  static List<TokenTransactionModel> transactions = [
    TokenTransactionModel(
      type: 'send',
      addressTo: '0xe2d3A739EFFCd3A99387d015E260eEFAc72EBea1',
      amount: 1000,
      symbol: 'ETH',
      dateTime: '13/08/18 13:44:59',
      gasFee: 0.00023,
      status: 'completed',
      txnHash:
          '0x8b67886c43def2ebed7c0ce33895ace0c28009bf3209ceb33b2e41f7b48bfa3f',
      addressFrom: '0xe2d3A739EFFCd3A99387d015E260eEFAc72EBea1',
      none: '#382',
      network: 'Binance',
    ),
    
  ];

  String get walletAddressTo => addressTo.formatAddressActivityFire();

  String get walletAddressFrom => addressFrom.formatAddressActivityFire();

  String get amountFormatted => '${amount.formatToCurrency()} $symbol';

  String get txnHashFormatted => txnHash.formatAddressActivityFire();

  Widget get getStatus {
    switch (status) {
      case 'completed':
        return Text(
          S.current.success,
          style: AppTextStyle.lightText.copyWith(
            color: AppTheme.getInstance().statusComplete,
            fontSize: 14,
          ),
        );
      case 'pending':
        return Text(
          S.current.pending,
          style: AppTextStyle.lightText.copyWith(
            color: AppTheme.getInstance().statusPending,
            fontSize: 14,
          ),
        );
      default:
        return Text(
          S.current.success,
          style: AppTextStyle.lightText.copyWith(
            color: AppTheme.getInstance().statusFail,
            fontSize: 14,
          ),
        );
    }
  }

  Color getColorStatus() {
    switch (status) {
      case 'completed':
        return AppTheme.getInstance().statusComplete;
      case 'pending':
        return AppTheme.getInstance().statusPending;
      case 'fail':
        return AppTheme.getInstance().statusFail;
      default:
        return AppTheme.getInstance().statusComplete;
    }
  }

  Widget get getSmallIcon {
    switch (type) {
      case 'send':
        return ImageAssets.images.icSend.svg();
      case 'funding':
        return ImageAssets.images.icFunding.svg();
      case 'receive':
        return ImageAssets.images.icReceive.svg();
      default:
        return const SizedBox.shrink();
    }
  }
}
