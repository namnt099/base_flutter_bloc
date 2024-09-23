import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends BaseBloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<EmmittedPageAction>(_onPageIndex);
  }

  FutureOr<void> _onPageIndex(
    EmmittedPageAction event,
    Emitter<OnboardingState> emit,
  ) {
    emit(
      state.copyWith(
        page: event.action == PageAction.next ? state.page + 1 : state.page - 1,
      ),
    );
  }
}
