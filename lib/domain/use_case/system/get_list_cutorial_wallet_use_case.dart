import 'package:sdk_wallet_flutter/data/result/result.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';
import 'package:sdk_wallet_flutter/domain/repository/wallet_repository.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_future_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';

class GetListCustorialWalletUseCase
    extends BaseFutureUseCase<NoneInput, Result<List<Wallet>>> {
  final WalletRepository _repository;
  GetListCustorialWalletUseCase(this._repository);

  @override
  Future<Result<List<Wallet>>> buildUseCase(NoneInput input) async {
    return _repository.getListCustorialWallets();
  }
}
