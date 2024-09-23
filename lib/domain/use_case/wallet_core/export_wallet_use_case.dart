import 'package:flutter/services.dart';
import 'package:sdk_wallet_flutter/data/exception/app_exception.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_future_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';
import 'package:sdk_wallet_flutter/utils/extensions/map_extension.dart';

class ExportWalletUseCase
    extends BaseFutureUseCase<ExportWalletInput, ExportWalletOutPut> {
  final _channel = const MethodChannel('flutter/trust_wallet');
  @override
  Future<ExportWalletOutPut> buildUseCase(ExportWalletInput input) async {
    try {
      final data = {
        'walletAddress': input.walletAddress,
      };
      final json = await _channel.invokeMethod('exportWallet', data) as Map;
      final Map<String, dynamic> hash = castToStringKey(json);

      return ExportWalletOutPut(
        privateKey: hash.stringValueOrEmpty('privateKey'),
        walletAddress: hash.stringValueOrEmpty('seedPhrase'),
      );
    } on PlatformException catch (error) {
      throw UnCatchException(overridMessage: error.message);
    }
  }
}

class ExportWalletInput extends BaseInput {
  String walletAddress;

  ExportWalletInput({
    required this.walletAddress,
  });
}

class ExportWalletOutPut extends BaseInput {
  String privateKey;
  String walletAddress;

  ExportWalletOutPut({
    required this.privateKey,
    required this.walletAddress,
  });
}
