import 'package:flutter/material.dart';

import 'app_exception.dart';

class ExceptionWrapper {
  final AppException exception;
  final VoidCallback? doOnRetry;

  ExceptionWrapper(this.exception, this.doOnRetry);
}
