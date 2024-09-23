import 'package:dio/dio.dart';
import 'package:sdk_wallet_flutter/domain/locals/prefs_service.dart';

import 'base_interceptors.dart';

class AuthInterceptor extends BaseInterceptors {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = PrefsService.getToken();
    if (accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options, handler);
  }
}
