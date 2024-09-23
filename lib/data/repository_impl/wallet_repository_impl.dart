import 'package:sdk_wallet_flutter/data/response/data_wallet_response/data_wallet_response.dart';
import 'package:sdk_wallet_flutter/data/result/result.dart';
import 'package:sdk_wallet_flutter/data/services/wallet_service.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';
import 'package:sdk_wallet_flutter/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  final WalletService _service;
  WalletRepositoryImpl(this._service);
  @override
  Future<Result<List<Wallet>>> getListCustorialWallets() {
    return runCatchingAsync<DataWalletResponse, List<Wallet>>(
      () => _service.getListCustorialWallets(),
      (res) => res.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
