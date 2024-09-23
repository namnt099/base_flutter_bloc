import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_state.dart';
import 'package:sdk_wallet_flutter/data/exception/app_exception.dart';
import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';

import '../connect_wallet_screen.dart';

part 'connect_wallet_state.freezed.dart';

@freezed
class ConnectWalletState extends BaseState with _$ConnectWalletState {
  factory ConnectWalletState({
    //todo[hoang] hard code enabledButton true
    @Default(true) bool enabledButton,
    @Default(WalletAction.create) WalletAction action,
    @Default('') String walletName,
    @Default('') String chainType,
    @Default('') String secretKeyType,
    @Default('') String content,
    @Default(false) bool obscureText,
    AppException? exception,
    SecretKeyKind? kind,
  }) = _ConnectWalletState;
}
