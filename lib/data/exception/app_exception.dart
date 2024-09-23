import '../../generated/l10n.dart';

abstract class AppException implements Exception {
  final AppExceptionType type;

  AppException(this.type);

  String get message;
}

class UnCatchException extends AppException {
  UnCatchException({this.overridMessage}) : super(AppExceptionType.unknown);
  final String? overridMessage;

  @override
  String get message {
    return overridMessage ?? S.current.something_went_wrong;
  }
}

enum AppExceptionType {
  remote,
  wallet_core,
  unknown,
}
