import 'package:sdk_wallet_flutter/config/base/bloc/base_event.dart';
import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';

import '../connect_wallet_screen.dart';

class ConnectWalletEvent extends BaseEvent {}

class InitiatedEvent extends ConnectWalletEvent {
  final WalletAction action;

  InitiatedEvent(this.action);
}

class WalletNameOnChanged extends ConnectWalletEvent {
  String walletName;
  WalletNameOnChanged(this.walletName);
}

class SecretKeyKindOnChanged extends ConnectWalletEvent {
  SecretKeyKind kind;
  SecretKeyKindOnChanged(this.kind);
}

class ChainOnChanged extends ConnectWalletEvent {
  ChainKind kind;
  ChainOnChanged(this.kind);
}

class SecretKeyOnChanged extends ConnectWalletEvent {
  String secretKey;
  SecretKeyOnChanged(this.secretKey);
}

class ButtonOnPressed extends ConnectWalletEvent {}

class WalletImported extends ConnectWalletEvent {
  String type;
  String content;
  String walletName;
  WalletImported({
    required this.type,
    required this.content,
    required this.walletName,
  });
}

class WalletInRefreshed extends ConnectWalletEvent {}
