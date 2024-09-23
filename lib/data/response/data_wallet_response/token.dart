import 'package:sdk_wallet_flutter/domain/model/wallet/token.dart';

class TokenResponse {
  int? id;
  String? network;
  String? name;
  String? symbol;
  String? exchangeRateUsd;
  String? exchangeRateKrw;
  String? addressContract;
  String? icon;
  int? status;
  String? createdAt;
  String? updatedAt;

  TokenResponse({
    this.id,
    this.network,
    this.name,
    this.symbol,
    this.exchangeRateUsd,
    this.exchangeRateKrw,
    this.addressContract,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => TokenResponse(
        id: json['id'] as int?,
        network: json['network'] as String?,
        name: json['name'] as String?,
        symbol: json['symbol'] as String?,
        exchangeRateUsd: json['exchangeRateUsd'] as String?,
        exchangeRateKrw: json['exchangeRateKrw'] as String?,
        addressContract: json['addressContract'] as String?,
        icon: json['icon'] as String?,
        status: json['status'] as int?,
        createdAt: json['createdAt'] as String?,
        updatedAt: json['updatedAt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'network': network,
        'name': name,
        'symbol': symbol,
        'exchangeRateUsd': exchangeRateUsd,
        'exchangeRateKrw': exchangeRateKrw,
        'addressContract': addressContract,
        'icon': icon,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Token toDomain() => Token(
        id: id ?? 0,
        network: network ?? '',
        name: name ?? '',
        symbol: symbol ?? '',
        exchangeRateUsd: exchangeRateUsd ?? '',
        exchangeRateKrw: exchangeRateKrw ?? '',
        addressContract: addressContract ?? '',
        icon: icon ?? '',
        status: status ?? 0,
        createdAt: createdAt ?? '',
        updatedAt: updatedAt ?? '',
      );
}
