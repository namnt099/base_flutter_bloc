import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/handle_wallet.dart';
import 'package:sdk_wallet_flutter/init_app.dart';

Future<void> main() async {
  await initWallet();
  runApp(const HandleWallet());
}
