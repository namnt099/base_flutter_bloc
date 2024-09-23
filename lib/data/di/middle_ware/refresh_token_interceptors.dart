import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import 'base_interceptors.dart';

class RefreshTokenInterceptors extends BaseInterceptors {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final options = err.response!.requestOptions;
      _onExpiredToken(options, handler);
    } else {
      handler.next(err);
    }
  }

  void _onExpiredToken(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) {
    //TODO
  }
}
