class Token {
  final int id;
  final String network;
  final String name;
  final String symbol;
  final String exchangeRateUsd;
  final String exchangeRateKrw;
  final String addressContract;
  final String icon;
  final int status;
  final double balance;
  final String createdAt;
  final String updatedAt;
  bool enable;

  Token({
    this.id = 0,
    this.network = '',
    this.name = '',
    this.symbol = '',
    this.exchangeRateUsd = '',
    this.exchangeRateKrw = '',
    this.addressContract = '',
    this.icon = '',
    this.status = 0,
    this.balance = 0.0,
    this.createdAt = '',
    this.updatedAt = '',
    this.enable = false,
  });
}
