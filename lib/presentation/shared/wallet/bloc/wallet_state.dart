import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_state.dart';
import '../../../../domain/model/wallet/wallet.dart';


part 'wallet_state.freezed.dart';

@freezed
class WalletState extends BaseState with _$WalletState {
  factory WalletState({
    @Default(<Wallet>[]) List<Wallet> custorialWallets,
    @Default(<Wallet>[]) List<Wallet> coreWallet,
    String? currentWalletName,
  }) = _WalletState;
}
