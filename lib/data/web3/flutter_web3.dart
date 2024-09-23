import 'dart:async';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:sdk_wallet_flutter/data/web3/erc20.g.dart';
import 'package:sdk_wallet_flutter/data/web3/web3_utils.dart';
import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';


Future<int> getApprove({
  required num amount,
  required int nonce,
  required String chainType,
  required String tokenAddress,
  required String walletAddress,
  required String walletAddressNonce,
  required String privateKey,
  bool isBinance = false,
}) async {
  try {
    final List<int> listInt = hex.decode(
      privateKey,
    );
    final token = Erc20(
      address: EthereumAddress.fromHex(tokenAddress),
      client: getRpcConnect(
        chainType: chainType,
      ),
    );
    await token.approve(
      EthereumAddress.fromHex(walletAddress),
      BigInt.from(amount * BIG_INT),
      credentials: EthPrivateKey(
        Uint8List.fromList(listInt),
      ),
    );
    final client = getRpcConnect(chainType: chainType);
    return getTransactionCount(
      client: client,
      address: walletAddressNonce,
      isBinance: isBinance,
    );
  } catch (error) {
    return 0;
  }
}

Future<Map<String, dynamic>> callCoral({
  required num amount,
  required String transaction,
  required String privateKey,
}) async {
  try {
    // final List<int> listInt = hex.decode(
    //   privateKey,
    // );
    //todo
    // final result = await coralContract.deposit(
    //   //todo
    //   "PrefsService.getUserProfile().id",
    //   BigInt.from(amount * BIG_INT),
    //   credentials: EthPrivateKey(
    //     Uint8List.fromList(listInt),
    //   ),
    // );
    return {
      'isSuccess': true,
      // 'txHash': result,
    };
  } catch (e) {
    return {
      'isSuccess': false,
      'error': e,
    };
  }
}

Future<Map<String, dynamic>> withdraw({
  required String privateKey,
  required num amount,
  required num date,
  required String singed,
  required String walletAddressReceive,
}) async {
  try {
    // final List<int> hexTransaction = hex.decode(singed);
    // final Uint8List signedTransaction = Uint8List.fromList(hexTransaction);

    // final List<int> listInt = hex.decode(
    //   privateKey,
    // );
    //todo
    // final result = await coralContract.withdraw(
    //   //todo
    //   "PrefsService.getUserProfile().id",
    //   signedTransaction,
    //   BigInt.from(amount * BIG_INT),
    //   BigInt.from(date),
    //   EthereumAddress.fromHex(walletAddressReceive),
    //   credentials: EthPrivateKey(
    //     Uint8List.fromList(listInt),
    //   ),
    // );
    return {
      'isSuccess': true,
      // 'txHash': result,
    };
  } catch (e) {
    return {
      'isSuccess': false,
      'message': e.toString().split(':').last,
    };
  }
}
