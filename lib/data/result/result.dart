// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:sdk_wallet_flutter/data/exception/app_exception.dart';
import 'package:sdk_wallet_flutter/data/exception/exception_handler.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.error(AppException exception) = Error<T>;
}

Result<T> runCatching<T>(T Function() block) {
  try {
    return Result.success(block());
  } catch (e) {
    return Result.error(UnCatchException());
  }
}

Future<Result<E>> runCatchingAsync<T, E>(
  Future<T> Function() block,
  E Function(T) map,
) async {
  try {
    final response = await block();
    return Result.success(map(response));
  } catch (e) {
    logger.e(e);
    return Result.error(ExceptionHandler.catchingRemoteExeption(e));
  }
}

final logger = Logger(
  // Use the default LogFilter (-> only log in debug mode)
  printer: Foundation.kDebugMode ? PrettyPrinter() : null,
);
