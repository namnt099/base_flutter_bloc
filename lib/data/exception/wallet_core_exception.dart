import 'package:sdk_wallet_flutter/data/exception/app_exception.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';

class WalletCoreException extends AppException {
  final WalletErrorKind kind;
  final String? overrideMessage;
  WalletCoreException({
    required this.kind,
    this.overrideMessage,
  }) : super(AppExceptionType.wallet_core);

  @override
  String get message {
    return overrideMessage ?? kind.toPrettyString();
  }
}

enum WalletErrorKind {
  unknown,
  duplicate,
  import_fail,
}

extension KindToMessage on WalletErrorKind {
  String toPrettyString() {
    switch (this) {
      case WalletErrorKind.duplicate:
        return S.current.duplicate;
      case WalletErrorKind.import_fail:
        return S.current.import_fail;
      case WalletErrorKind.unknown:
        return S.current.something_went_wrong;
      default:
        return S.current.something_went_wrong;
    }
  }
}

extension IntException on int {
  WalletCoreException? toWalletException() {
    switch (this) {
      case 200:
        return null;
      case 400:
        return WalletCoreException(
          kind: WalletErrorKind.unknown,
        );
      case 401:
        return WalletCoreException(
          kind: WalletErrorKind.duplicate,
        );
      case 402:
        return WalletCoreException(
          kind: WalletErrorKind.import_fail,
        );
      default:
        return null;
    }
  }
}
