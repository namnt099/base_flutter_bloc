import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';

import 'token.dart';

class Datum {
  String? id;
  String? walletName;
  List<TokenResponse>? tokens;

  Datum({this.id, this.walletName, this.tokens});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as String?,
        walletName: json['walletName'] as String?,
        tokens: (json['tokens'] as List<dynamic>?)
            ?.map((e) => TokenResponse.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'walletName': walletName,
        'tokens': tokens?.map((e) => e.toJson()).toList(),
      };
  Wallet toDomain() => Wallet(
        id: id ?? '',
        walletName: walletName ?? '',
        tokens: tokens?.map((e) => e.toDomain()).toList() ?? [],
      );
}
