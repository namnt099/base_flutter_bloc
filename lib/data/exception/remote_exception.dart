import 'package:dio/dio.dart';
import 'package:sdk_wallet_flutter/utils/extensions/map_extension.dart';

import 'app_exception.dart';

class RemoteException extends AppException {
  RemoteException({
    this.httpCode = 0,
    this.overrideMessage,
    required this.kind,
  }) : super(AppExceptionType.remote);

  final int httpCode;
  final RemoteExceptionKind kind;
  final String? overrideMessage;

  factory RemoteException.fromJson(Map<String, dynamic> json) {
    return RemoteException(
      httpCode: json.intValue('statusCode'),
      kind: json.remoteExceptionKind('kind'),
    );
  }

  @override
  String get message {
    return overrideMessage ?? kind.toPrettyDescription();
  }
}

enum RemoteExceptionKind {
  noInternet,

  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// [ValidateStatus].
  badResponse,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  /// Default error type, Some other [Error]. In this case, you can use the
  unknown,
}

extension DioExceptionTypeExtension on DioExceptionType {
  RemoteExceptionKind get toRemoteKind {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return RemoteExceptionKind.connectionTimeout;
      case DioExceptionType.sendTimeout:
        return RemoteExceptionKind.sendTimeout;
      case DioExceptionType.receiveTimeout:
        return RemoteExceptionKind.receiveTimeout;
      case DioExceptionType.badCertificate:
        return RemoteExceptionKind.badCertificate;
      case DioExceptionType.badResponse:
        return RemoteExceptionKind.badResponse;
      case DioExceptionType.cancel:
        return RemoteExceptionKind.cancel;
      case DioExceptionType.connectionError:
        return RemoteExceptionKind.connectionError;
      case DioExceptionType.unknown:
        return RemoteExceptionKind.unknown;
      default:
        return RemoteExceptionKind.unknown;
    }
  }
}

extension RemoteExceptionKindExtension on RemoteExceptionKind {
  String toPrettyDescription() {
    //TODO
    switch (this) {
      case RemoteExceptionKind.connectionTimeout:
        return 'connection timeout';
      case RemoteExceptionKind.sendTimeout:
        return 'send timeout';
      case RemoteExceptionKind.receiveTimeout:
        return 'receive timeout';
      case RemoteExceptionKind.badCertificate:
        return 'bad certificate';
      case RemoteExceptionKind.badResponse:
        return 'bad response';
      case RemoteExceptionKind.cancel:
        return 'request cancelled';
      case RemoteExceptionKind.connectionError:
        return 'connection error';
      case RemoteExceptionKind.unknown:
        return 'unknown';
      case RemoteExceptionKind.noInternet:
        return 'no interet';
    }
  }
}
