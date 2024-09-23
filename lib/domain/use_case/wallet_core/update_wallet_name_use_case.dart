import 'package:flutter/services.dart';
import 'package:sdk_wallet_flutter/data/exception/app_exception.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_future_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';
import 'package:sdk_wallet_flutter/utils/extensions/map_extension.dart';

class UpdateWalletNameUseCase
    extends BaseFutureUseCase<UpdateWalletNameInput, bool> {
  final _channel = const MethodChannel('flutter/trust_wallet');
  @override
  Future<bool> buildUseCase(UpdateWalletNameInput input) async {
    try {
      final data = {
        'walletNameOld': input.oldName,
        'walletNameNew': input.newName,
      };
      final json = await _channel.invokeMethod('updateWalletName', data) as Map;
      final Map<String, dynamic> hash = castToStringKey(json);
      final success = hash.boolValue('isSuccess');

      return success;
    } on PlatformException catch (error) {
      throw UnCatchException(overridMessage: error.message);
    }
  }
}

class UpdateWalletNameInput extends BaseInput {
  String oldName;
  String newName;

  UpdateWalletNameInput({
    required this.oldName,
    required this.newName,
  });
}
