import 'package:dio/dio.dart';

import 'base_interceptors.dart';

class HeaderInterceptors extends BaseInterceptors {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = '*/*';
    super.onRequest(options, handler); 
  }
}
