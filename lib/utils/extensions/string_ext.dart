import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/utils/constants/regex_constants.dart';

import '../constants/datetime_constants.dart';

extension FormatAddressFire on String {
  String formatAddressActivityFire() {
    try {
      final String result = '${substring(0, 5)}...${substring(
        length - 5,
        length,
      )}';
      return result;
    } catch (e) {
      return '';
    }
  }

  String convertNameFile() {
    final document = this;

    final parts = document.split('/');

    final lastName = parts.last;

    final partsNameFile = lastName.split('.');

    if (partsNameFile[0].length > 30) {
      partsNameFile[0] = '${partsNameFile[0].substring(0, 10)}... ';
    }
    final fileName = '${partsNameFile[0]}.${partsNameFile[1]}';

    return fileName;
  }

  DateTime convertStringToDate({
    String formatPattern = DateTimeFormat.dob,
  }) {
    try {
      return DateFormat(formatPattern).parse(this);
    } catch (_) {
      return DateTime.now();
    }
  }

  String changeDatetimePattern({
    String oldPattern = DateTimeFormat.beDate,
    String newPattern = DateTimeFormat.date,
    bool toLocal = true,
  }) {
    try {
      return toLocal
          ? DateFormat(newPattern)
              .format(DateFormat(oldPattern).parse(this, true).toLocal())
          : DateFormat(newPattern).format(DateFormat(oldPattern).parse(this));
    } catch (_) {
      return '';
    }
  }

  DateTime? getDateTime({
    String pattern = DateTimeFormat.beDate,
  }) {
    try {
      return DateFormat(pattern).parse(this, true).toLocal();
    } catch (_) {
      return null;
    }
  }
}

extension StringValidate on String {
  String? checkRequired({required String fieldName}) {
    if (isNullOrEmpty) {
      return '$fieldName ${S.current.is_require}';
    }
    return null;
  }

  String? isNormalCharacter({required String errorMessage}) {
    if (!matches(RegExp(RegexConstants.CHARACTER_REGEX))) {
      return errorMessage;
    }
    return null;
  }

  String? validatePassword() {
    if (!matches(RegExp(RegexConstants.PASSWORD_REGEX_2))) {
      return S.current.invalid_passcode;
    }
    return null;
  }

  String? validatePasswordConfirm({required String password}) {
    if (this != password) {
      return S.current.confirm_passcode_did_not_match;
    }
    return null;
  }

  static final RegExp _basicAddress =
      RegExp(r'^0x[a-fA-F0-9]{40}$', caseSensitive: false);

  static final RegExp _basicAccountId =
      RegExp(r'^(([a-z\d]+[-_])*[a-z\d]+\.)*([a-z\d]+[-_])*[a-z\d]+$');

  String? validateWalletAddress({
    String? wrongFormatMessage,
  }) {
    if (!_basicAddress.hasMatch(this) || length != 42) {
      return wrongFormatMessage ?? S.current.invalid_wallet_format;
    }
    return null;
  }

  String? validateNearWalletAddress({
    String? wrongFormatMessage,
  }) {
    if ((!_basicAccountId.hasMatch(this) && contains('.')) ||
        (!contains('.') && length != 64)) {
      return wrongFormatMessage ?? S.current.invalid_wallet_format;
    }
    return null;
  }
}

extension DateTimeExt on String {
  String changeToNewPatternDate({
    String oldPattern = DateTimeFormat.beDate,
    required String newPattern,
    bool toLocal = true,
  }) {
    try {
      if (toLocal) {
        return DateFormat(newPattern, 'en').format(
          DateFormat(oldPattern).parse(this, true).toLocal(),
        );
      } else {
        return DateFormat(
          newPattern,
        ).format(
          DateFormat(oldPattern).parse(this),
        );
      }
    } catch (_) {
      return '';
    }
  }
}
