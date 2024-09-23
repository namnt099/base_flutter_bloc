import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';

import '../../data/result/result.dart';

abstract class WalletRepository {
  Future<Result<List<Wallet>>> getListCustorialWallets();
}
