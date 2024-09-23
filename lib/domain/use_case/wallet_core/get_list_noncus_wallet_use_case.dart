import 'package:flutter/services.dart';
import 'package:sdk_wallet_flutter/data/exception/wallet_core_exception.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_future_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';

import '../../model/wallet/token.dart';

class GetListNonCusWalletUseCase
    extends BaseFutureUseCase<GetListNonCusInput, List<Wallet>> {
  final _channel = const MethodChannel('flutter/trust_wallet');
  @override
  Future<List<Wallet>> buildUseCase(GetListNonCusInput input) async {
    final List<Wallet> wallets = [];
    try {
      final temps =
          await _channel.invokeMethod('getListWallet') as List<dynamic>;
      for (final element in temps) {
        final wallet = Wallet.fromJson(
          element,
          //TODO this is mock data
          tokens: [
            Token(
              id: 1,
              icon: 'i',
              name: 'Bitcoin',
              symbol: 'BTC',
              balance: 1000,
              addressContract: '0x1ad2c462463059e368e368a84fcd5339901ce6',
            ),
            Token(
              id: 2,
              icon: 'i',
              name: 'Ethereum',
              symbol: 'ETH',
              balance: 1000,
              addressContract: '0x1ad2c462463059e368e368a84fcd5339901ce6',
            ),
            Token(
              id: 3,
              icon: 'i',
              name: 'Tron',
              symbol: 'TRX',
              balance: 1000,
              addressContract: '0x1ad2c462463059e368e368a84fcd5339901ce6',
            ),
          ],
        );
        wallets.add(wallet);
      }
      return wallets;
    } on PlatformException catch (error) {
      throw WalletCoreException(
        kind: WalletErrorKind.unknown,
        overrideMessage: error.message,
      );
    }
  }
}

class GetListNonCusInput extends BaseInput {
  GetListNonCusInput();
}
