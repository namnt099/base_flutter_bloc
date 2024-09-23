import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';
import 'package:sdk_wallet_flutter/config/base/common/common_event.dart';
import 'package:sdk_wallet_flutter/config/base/common/common_state.dart';

class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState()) {
    on<LoadingVisibilityEmitted>(
      _onLoadingVisibilityEmitted,
    );

    on<ExceptionEmitted>(
      _onExceptionEmitted,
    );
  }

  FutureOr<void> _onLoadingVisibilityEmitted(
    LoadingVisibilityEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  FutureOr<void> _onExceptionEmitted(
    ExceptionEmitted event,
    Emitter<CommonState> emit,
  ) {
    emit(state.copyWith(wrapper: event.wrapper));
  }
}
