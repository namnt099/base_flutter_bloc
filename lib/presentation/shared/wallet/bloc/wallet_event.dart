import 'package:sdk_wallet_flutter/config/base/bloc/base_event.dart';

class WalletEvent extends BaseEvent {}

class WalletInitiated extends WalletEvent {}

class GetListSystemWallet extends WalletEvent {}

class GetListCoreWallet extends WalletEvent {}

class WalletRefreshed extends WalletEvent {}

class UpdatedWalletName extends WalletEvent {
  String newWalletName;
  String oldWalletName;
  UpdatedWalletName(this.oldWalletName, this.newWalletName);
}

class IndexedWallet extends WalletEvent {
  String walletName;
  IndexedWallet(this.walletName);
}

class DeletedWallet extends WalletEvent {
  String walletName;
  DeletedWallet(this.walletName);
}

class ExportedWallet extends WalletEvent {
  String walletAddress;
  ExportedWallet(this.walletAddress);
}
