import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';
import 'package:sdk_wallet_flutter/presentation/shared/token/token_list_screen.dart';

import '../../../../domain/use_case/wallet_core/import_wallet_use_case.dart';
import '../connect_wallet_screen.dart';
import 'connect_wallet_event.dart';
import 'connect_wallet_state.dart';

class ConnectWalletBloc
    extends BaseBloc<ConnectWalletEvent, ConnectWalletState> {
  ConnectWalletBloc() : super(ConnectWalletState()) {
    on<InitiatedEvent>(_onInitiatedEvent);
    on<SecretKeyKindOnChanged>(_onSecretKeyKindOnChange);
    on<WalletNameOnChanged>(_onWalletNameOnChanged);
    on<ChainOnChanged>(_onChainOnChanged);
    on<SecretKeyOnChanged>(_onSecretKeyOnChanged);
    on<ButtonOnPressed>(_onButtonOnPressed);
  }

  //final _custorialWalletsUc = GetListCustorialWalletUseCase(Get.find());
  final _importUc = ImportWalletUseCase();

  FutureOr<void> _onSecretKeyKindOnChange(
    SecretKeyKindOnChanged event,
    Emitter<ConnectWalletState> emit,
  ) {
    emit(
      state.copyWith(
        secretKeyType: event.kind.key,
        kind: event.kind,
        enabledButton: _isEnableButton(
          event.kind.key,
          state.chainType,
        ),
      ),
    );
  }

  FutureOr<void> _onChainOnChanged(
    ChainOnChanged event,
    Emitter<ConnectWalletState> emit,
  ) {
    emit(
      state.copyWith(
        chainType: event.kind.key,
        enabledButton: _isEnableButton(
          state.secretKeyType,
          event.kind.key,
        ),
      ),
    );
  }

  FutureOr<void> _onSecretKeyOnChanged(
    SecretKeyOnChanged event,
    Emitter<ConnectWalletState> emit,
  ) {
    emit(
      state.copyWith(
        content: event.secretKey,
      ),
    );
  }

  bool _isEnableButton(String secretKeyType, String chain) =>
      state.action == WalletAction.import
          ? secretKeyType.isNotEmpty && chain.isNotEmpty
          : chain.isNotEmpty;

  FutureOr<void> _onWalletNameOnChanged(
    WalletNameOnChanged event,
    Emitter<ConnectWalletState> emit,
  ) {}

  FutureOr<void> _onInitiatedEvent(
    InitiatedEvent event,
    Emitter<ConnectWalletState> emit,
  ) {
    emit(state.copyWith(action: event.action));
  }

  FutureOr<void> _onButtonOnPressed(
    ButtonOnPressed event,
    Emitter<ConnectWalletState> emit,
  ) {
    if (state.action == WalletAction.create) {
      //todo call api create wallet(không cần chain id)
      Get.to(const TokenListScreen(title: 'Add Crypto to Wallet'));
    } else {
      return blocCatching(
        action: _importUc.execute(
          ImportWalletInput(
            type: state.kind!.value,
            content: state.content,
            walletName: state.walletName,
            chainType: state.chainType,
          ),
        ),
        onSuccess: (value) {
          Get.to(const TokenListScreen(title: 'Add Crypto to Wallet'));
        },
      );
    }
  }
}
