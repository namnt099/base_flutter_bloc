// ignore_for_file: depend_on_referenced_packages

import 'package:meta/meta.dart';
import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';

abstract class BaseUseCase<Input extends BaseInput, Output> {
  const BaseUseCase();

  @protected
  Output buildUseCase(Input input);
}
