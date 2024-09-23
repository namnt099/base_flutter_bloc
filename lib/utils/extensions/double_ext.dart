import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';

extension TruncateDoubles on double {
  double truncateToDecimalPlaces(int fractionalDigits) =>
      (this *
              pow(
                10,
                fractionalDigits,
              ))
          .truncate() /
      pow(10, fractionalDigits);

  String depositNear() {
    String valueReturn = '';
    String valueNear = NEAR_DEPOSIT;
    List<String> subString = valueNear.split('');
    subString.first = toString();
    valueNear = subString.join();
    subString.clear();
    subString = valueNear.split('');
    final List<String> check = toString().split('.');
    if (int.parse(check.first) > 0) {
      subString.remove('.');
      int index = 0;
      while (index < check.last.characters.length) {
        subString.removeLast();
        index++;
      }
      valueReturn = subString.join();
    } else {
      int index = 0;
      while (index < check.last.characters.length + 1) {
        subString.removeAt(0);
        index++;
      }
      index = 0;
      while (index < check.last.characters.length) {
        subString.removeLast();
        index++;
      }
      valueReturn = subString.join();
    }
    return valueReturn;
  }
}
