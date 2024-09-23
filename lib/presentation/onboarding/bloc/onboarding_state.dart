import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sdk_wallet_flutter/config/base/bloc/base_state.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState extends BaseState with _$OnboardingState {
  const factory OnboardingState({@Default(0) int page}) = _OnboardingState;
}
