import 'dart:async';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';
import 'package:flutter/services.dart' show rootBundle;

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:sdk_wallet_flutter/data/web3/erc20.g.dart';
import 'package:sdk_wallet_flutter/data/web3/token.g.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet_spending/token_web3.dart';
import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';
import 'package:web3dart/web3dart.dart';

import '../../utils/constants/chain_constants.dart';

Web3Client getRpcConnect({required String chainType}) {
  switch (chainType) {
    case Chains.BSC:
      return Web3Client(AppConstants.bscRpc, http.Client());
    case Chains.POLYGON:
      return Web3Client(AppConstants.polygonRpc, http.Client());
    case Chains.NEAR:
      return Web3Client(AppConstants.nearRpc, http.Client());
    default:
      return Web3Client(AppConstants.bscRpc, http.Client());
  }
}

Future<String> getGasPrice(Web3Client client) async {
  final amount = await client.getGasPrice();
  return '${amount.getInWei}';
}

Future<String> getEstimateGas({
  required Web3Client client,
  required String symbol,
  required String tokenContract,
  required String from,
  required String to,
  required double amount,
}) async {
  if (symbol.toLowerCase() == Chains.BNB.toLowerCase() ||
      symbol.toLowerCase().contains(Chains.MATIC.toLowerCase())) {
    final gasLimit = await client.estimateGas(
      sender: EthereumAddress.fromHex(from),
      to: EthereumAddress.fromHex(to),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        BigInt.from(amount * BIG_INT),
      ),
    );
    final valueHundredMore = BigInt.from(5000) + gasLimit;
    return '$valueHundredMore';
  } else {
    try {
      final deployContract = await _deployedERC20Contract(tokenContract);
      final transferFunction = deployContract.function('transfer');
      final sendAmount = BigInt.from(amount * BIG_INT);
      final transferTransaction = Transaction.callContract(
        contract: deployContract,
        function: transferFunction,
        parameters: [
          EthereumAddress.fromHex(to),
          sendAmount,
        ],
      );
      final gasLimit = await client.estimateGas(
        sender: EthereumAddress.fromHex(from),
        to: EthereumAddress.fromHex(tokenContract),
        data: transferTransaction.data,
      );
      final valueHundredMore = BigInt.from(20000) + gasLimit;
      return '$valueHundredMore';
    } catch (e) {
      return '';
    }
  }
}

Future<TokenInfoModel?> getTokenInfo({
  required String contractAddress,
  String? walletAddress,
  required Web3Client client,
}) async {
  Token token;
  try {
    token = Token(
      address: EthereumAddress.fromHex(contractAddress),
      client: client,
    );
  } catch (e) {
    return null;
  }
  double value = 0.0;
  String name;
  String symbol;
  BigInt decimal;
  try {
    name = await token.name();
  } catch (e) {
    return null;
  }
  try {
    decimal = await token.decimals();
  } catch (e) {
    return null;
  }
  try {
    symbol = await token.symbol();
  } catch (e) {
    return null;
  }
  if (walletAddress != null) {
    final balance =
        await token.balanceOf(EthereumAddress.fromHex(walletAddress));
    value = balance / BigInt.from(10).pow(18);
  }
  return TokenInfoModel(
    name: name,
    decimal: decimal,
    tokenSymbol: symbol,
    value: value,
  );
}

Future<Map<String, dynamic>> sendRawTransaction({
  required Web3Client client,
  required String transaction,
}) async {
  final List<int> listInt = hex.decode(transaction);
  final Uint8List signedTransaction = Uint8List.fromList(listInt);
  TransactionReceipt? receipt;
  try {
    final txh = await client.sendRawTransaction(signedTransaction);
    do {
      receipt = await client.getTransactionReceipt(txh);
    } while (receipt == null);
    await client.dispose();
    return {
      'isSuccess': receipt.status ?? false,
      'txHash': txh,
    };
  } catch (error) {
    await client.dispose();
    return {
      'isSuccess': false,
      'txHash': '',
    };
  }
}

Future<int> getTransactionCount({
  required Web3Client client,
  required String address,
  bool isBinance = false,
}) async {
  try {
    final count = await client.getTransactionCount(
      EthereumAddress.fromHex(address),
      atBlock: isBinance ? const BlockNum.pending() : null,
    );
    return count;
  } catch (error) {
    return 0;
  }
}

Future<double> getBalance({
  required Web3Client client,
  required String walletAddress,
  required String tokenAddress,
  bool isNativeCoin = false,
}) async {
  final address = EthereumAddress.fromHex(walletAddress);
  if (isNativeCoin) {
    try {
      final balance = await client.getBalance(address);
      return balance.getInWei / BigInt.from(10).pow(18);
    } catch (err) {
      return 0.0;
    }
  } else {
    try {
      final token = Erc20(
        address: EthereumAddress.fromHex(tokenAddress),
        client: client,
      );
      final balance = await token.balanceOf(address);
      return balance / BigInt.from(10).pow(18);
    } catch (error) {
      return 0.0;
    }
  }
}

Future<DeployedContract> _deployedERC20Contract(
  String contract,
) async {
  final abiCode = await rootBundle.loadString('assets/abi/erc20_abi.json');
  final deployContract = DeployedContract(
    ContractAbi.fromJson(abiCode, 'erc20'),
    EthereumAddress.fromHex(contract),
  );
  return deployContract;
}
