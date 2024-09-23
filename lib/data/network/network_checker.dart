// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:sdk_wallet_flutter/generated/l10n.dart';

import '../exception/remote_exception.dart';

class CheckerNetwork {
  static const String GOOGLE_URL = 'https://www.google.com/';
  static const int STATUS_CODE_SUCCESS = 200;

  static Future<bool> checkNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future<bool> checkNetworkByGoogle() async {
    try {
      final http.Response response = await http
          .get(Uri.parse(GOOGLE_URL))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == STATUS_CODE_SUCCESS) {
        return true;
      } else {
        return false;
      }
    } on TimeoutException catch (error) {
      throw RemoteException(
        kind: RemoteExceptionKind.connectionTimeout,
        overrideMessage: error.message,
      );
    } on SocketException {
      throw RemoteException(
        kind: RemoteExceptionKind.noInternet,
        overrideMessage: S.current.net_work,
      );
    }
  }
}
