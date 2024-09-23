import 'package:intl/intl.dart';

class NumberFormattedCurrency {
  NumberFormattedCurrency._();

  static NumberFormat USD = NumberFormat('\$###,###,###,###,###.###', 'en_US');

  static NumberFormat decimal(int number) {
    final format = StringBuffer('#,##0.');
    for (var i = 0; i < number; i++) {
      format.write('0');
    }

    return NumberFormat(format.toString(), 'en_US');
  }

  String currency(dynamic amount, String symbol) {
    dynamic price;
    if (amount is String) {
      price = double.tryParse(amount) ?? 0;
    } else {
      price = amount;
    }
    final formatter = NumberFormat('###,###.##');
    final String mAmount = formatter.format(price);
    return mAmount + symbol;
  }
}
