import 'package:intl/intl.dart';
import 'package:sdk_wallet_flutter/utils/constants/regex_constants.dart';
import 'package:sdk_wallet_flutter/utils/extensions/number_format.dart';

extension NumberExt on num {
  String formatToCurrency({NumberFormat? format}) {
    try {
      final formatter = format ?? NumberFormattedCurrency.decimal(5);
      return formatter
          .format(this)
          .replaceAll(RegExp(RegexConstants.DECIMAL_REGEX), '');
    } catch (e) {
      return '0';
    }
  }

  String numberLikeFormat() {
    if (this < 1000) {
      return toString();
    }
    if (this >= 1000 && this < 1000000) {
      final front = this ~/ 1000;
      final end = (this % 1000) ~/ 100;
      return '$front${end > 0 ? ',$end' : ''}';
    } else {
      final front = this ~/ 1000000;
      final end = (this % 1000000) ~/ 100000;
      return '$front${end > 0 ? ',$end' : ''}';
    }
  }
}
