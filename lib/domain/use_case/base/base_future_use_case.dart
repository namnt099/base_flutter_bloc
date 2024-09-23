import 'package:sdk_wallet_flutter/domain/use_case/base/base_input.dart';

import 'base_use_case.dart';

abstract class BaseFutureUseCase<Input extends BaseInput, Output>
    extends BaseUseCase<Input, Future<Output>> {
  const BaseFutureUseCase();

  Future<Output> execute(Input input) async {
    final output = await buildUseCase(input);
    return output;
  }
}
