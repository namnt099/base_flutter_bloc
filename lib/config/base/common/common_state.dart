import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/exception/exception_wrapper.dart';
import '../bloc/base_state.dart';

part 'common_state.freezed.dart';

@freezed
class CommonState extends BaseState with _$CommonState {
  const factory CommonState({
    ExceptionWrapper? wrapper,
    @Default(false) bool isLoading,
  }) = _CommonState;
}
