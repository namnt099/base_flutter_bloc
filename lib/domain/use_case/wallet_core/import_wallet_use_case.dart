import 'package:flutter/services.dart';
import 'package:sdk_wallet_flutter/data/exception/app_exception.dart';
import 'package:sdk_wallet_flutter/data/exception/wallet_core_exception.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_future_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';
import 'package:sdk_wallet_flutter/utils/extensions/map_extension.dart';

class ImportWalletUseCase extends BaseFutureUseCase<ImportWalletInput, Wallet> {
  final _channel = const MethodChannel('flutter/trust_wallet');
  @override
  Future<Wallet> buildUseCase(ImportWalletInput input) async {
    try {
      final data = {
        'type': input.type,
        'chainType': input.chainType,
        'content': input.content,
        'walletName': input.walletName,
      };
      final json = await _channel.invokeMethod('importWallet', data) as Map;
      final Map<String, dynamic> hash = castToStringKey(json);
      final code = hash.intValue('code');
      final exception = code.toWalletException();
      if (exception != null) {
        throw exception;
      } else {
        final wallets = hash.arrayValueOrEmpty('data');
        if (wallets.isEmpty) {
          throw UnCatchException();
        }
        return Wallet.fromCore(wallets.first);
      }
    } on PlatformException catch (error) {
      throw UnCatchException(overridMessage: error.message);
    }
  }
}

class ImportWalletInput extends BaseInput {
  String type;
  String content;
  String walletName;
  String chainType;
  ImportWalletInput({
    required this.type,
    required this.content,
    required this.walletName,
    required this.chainType,
  });
}
