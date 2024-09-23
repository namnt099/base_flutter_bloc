import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../config/resources/dimens.dart';
import '../../../config/resources/styles.dart';
import '../../../config/themes/app_theme.dart';
import '../../../generated/l10n.dart';
import '../../../utils/extensions/map_extension.dart';
import 'token.dart';

enum WalletKind { custorial, noncustorial }

class Wallet {
  final String id;
  final String walletName;
  final String privateKey;
  final String seedPhrase;
  final String walletAddress;
  final List<Token> tokens;
  final WalletKind kind;
  final bool isSelectWallet;
  final int indexWallet;

  Wallet({
    this.id = '',
    this.walletName = '',
    this.tokens = const [],
    this.kind = WalletKind.noncustorial,
    this.privateKey = '',
    this.seedPhrase = '',
    this.walletAddress = '',
    this.isSelectWallet = false,
    this.indexWallet = 0,
  });

  factory Wallet.fromJson(dynamic json, {List<Token> tokens = const []}) {
    final cast = castToStringKey(json as Map);
    return Wallet(
      id: cast.stringValueOrEmpty('id'),
      walletName: cast.stringValueOrEmpty('walletName'),
      isSelectWallet: cast.boolValue('isSelectWallet'),
      indexWallet: cast.intValue('indexWallet'),
      walletAddress: cast.stringValueOrEmpty('walletAddress'),

      //todo mock datate
      tokens: tokens,
    );
  }
  factory Wallet.fromCore(dynamic json) {
    final cast = castToStringKey(json as Map);
    return Wallet(
      id: cast.stringValueOrEmpty('id'),
      walletName: cast.stringValueOrEmpty('walletName'),
      walletAddress: cast.stringValueOrEmpty('walletAddress'),
      privateKey: cast.stringValueOrEmpty('privateKey'),
      seedPhrase: cast.stringValueOrEmpty('seedPhrase'),
    );
  }

  static List<Wallet> get wallets => [
        Wallet(
          id: '1000',
          walletName: 'Wallet 1',
          kind: WalletKind.custorial,
          tokens: [
            Token(
              id: 3,
              icon: 'i',
              name: 'Bitcoin',
              symbol: 'BTC',
              balance: 1000,
            ),
            Token(
              id: 1,
              icon: 'i',
              name: 'Ethereum',
              symbol: 'ETH',
              balance: 1000,
            ),
            Token(
              id: 2,
              icon: 'i',
              name: 'Tron',
              symbol: 'TRX',
              balance: 1000,
            ),
          ],
        ),
      ];
}

extension WidgetWallet on Wallet {
  Widget systemWidget() {
    switch (kind) {
      case WalletKind.custorial:
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: Dimens.d4.responsive(),
            horizontal: Dimens.d8.responsive(),
          ),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().linearSystemWallet[0],
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimens.d4.responsive(),
              ),
            ),
          ),
          child: Text(
            S.current.system_wallet,
            style: AppTextStyle.regularText.copyWith(
              fontSize: 12,
              color: AppTheme.getInstance().formColor,
            ),
          ),
        );
      case WalletKind.noncustorial:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
