import 'package:sdk_wallet_flutter/config/base/bloc/base_event.dart';

import '../../../data/exception/exception_wrapper.dart';

class CommonEvent extends BaseEvent {
  const CommonEvent();
}

class ExceptionEmitted extends CommonEvent {
  const ExceptionEmitted({required this.wrapper});
  final ExceptionWrapper wrapper;
}

class LoadingVisibilityEmitted extends CommonEvent {
  const LoadingVisibilityEmitted({
    required this.isLoading,
  });
  final bool isLoading;
}
