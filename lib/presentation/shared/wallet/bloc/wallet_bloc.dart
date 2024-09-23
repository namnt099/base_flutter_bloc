import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';
import 'package:sdk_wallet_flutter/domain/use_case/wallet_core/delete_wallet_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/wallet_core/export_wallet_use_case.dart';
import 'package:sdk_wallet_flutter/domain/use_case/wallet_core/update_wallet_name_use_case.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/bloc/wallet_event.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/ui/export_page.dart';

import '../../../../domain/model/wallet/wallet.dart';
import '../../../../domain/use_case/system/get_list_cutorial_wallet_use_case.dart';
import '../../../../domain/use_case/wallet_core/get_list_noncus_wallet_use_case.dart';
import 'wallet_state.dart';

class WalletBloc extends BaseBloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletState()) {
    on<WalletInitiated>(_onWalletInitiated);
    on<WalletRefreshed>(_onWalletRefreshed);
    on<GetListSystemWallet>(_onGetListSystemWallet);
    on<GetListCoreWallet>(_onGetListCoreWallet);
    on<UpdatedWalletName>(_onUpdatedWalletName);
    on<IndexedWallet>(_onIndexedWallet);
    on<DeletedWallet>(_onRemovedWallet);
    on<ExportedWallet>(_onExportedWallet);
  }
  final _custorialWalletsUc = GetListCustorialWalletUseCase(Get.find());
  final _nonCusWalletUc = GetListNonCusWalletUseCase();
  final _updateWalletNameUc = UpdateWalletNameUseCase();
  final _deleteWalletUc = DeleteWalletUseCase();
  final _exportWallerUc = ExportWalletUseCase();

  FutureOr<void> _onGetListCoreWallet(
    GetListCoreWallet event,
    Emitter<WalletState> emit,
  ) async {
    return blocCatching<List<Wallet>>(
      action: _nonCusWalletUc.execute(GetListNonCusInput()),
      onSuccess: (nonWallets) {
        emit(
          state.copyWith(
            coreWallet: nonWallets,
          ),
        );
      },
    );
  }

  FutureOr<void> _onGetListSystemWallet(
    GetListSystemWallet event,
    Emitter<WalletState> emit,
  ) {
    return blocResultCatching<List<Wallet>>(
      action: _custorialWalletsUc.execute(const NoneInput()),
      onSuccess: (data) {
        emit(state.copyWith(custorialWallets: data));
      },
      doOnRetry: () {
        add(GetListSystemWallet());
      },
    );
  }

  FutureOr<void> _onWalletInitiated(
    WalletInitiated event,
    Emitter<WalletState> emit,
  ) {
    emit(WalletState());
  }

  FutureOr<void> _onWalletRefreshed(
    WalletRefreshed event,
    Emitter<WalletState> emit,
  ) {}

  FutureOr<void> _onUpdatedWalletName(
    UpdatedWalletName event,
    Emitter<WalletState> emit,
  ) {
    return blocCatching<bool>(
      action: _updateWalletNameUc.execute(
        UpdateWalletNameInput(
          oldName: event.oldWalletName,
          newName: event.newWalletName,
        ),
      ),
      onSuccess: (value) {
        if (value) {
          emit(state.copyWith(currentWalletName: event.newWalletName));
          add(GetListCoreWallet());
        }
      },
    );
  }

  FutureOr<void> _onIndexedWallet(
    IndexedWallet event,
    Emitter<WalletState> emit,
  ) {
    emit(state.copyWith(currentWalletName: event.walletName));
  }

  FutureOr<void> _onRemovedWallet(
    DeletedWallet event,
    Emitter<WalletState> emit,
  ) {
    return blocCatching<bool>(
      action: _deleteWalletUc
          .execute(DeleteWalletInput(walletName: event.walletName)),
      onSuccess: (value) {
        if (value) {
          Get.back();
          add(GetListCoreWallet());
        }
      },
    );
  }

  FutureOr<void> _onExportedWallet(
    ExportedWallet event,
    Emitter<WalletState> emit,
  ) {
    return blocCatching<ExportWalletOutPut>(
      action: _exportWallerUc
          .execute(ExportWalletInput(walletAddress: event.walletAddress)),
      onSuccess: (output) {
        Get.to(
          () => ExportWalletPage(
            privateKey: output.privateKey,
          ),
        );
      },
    );
  }
}
