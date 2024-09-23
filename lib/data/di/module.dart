import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/data/di/middle_ware/auth_interceptors.dart';
import 'package:sdk_wallet_flutter/data/di/middle_ware/connect_interceptors.dart';
import 'package:sdk_wallet_flutter/data/di/middle_ware/header_interceptors.dart';
import 'package:sdk_wallet_flutter/data/di/middle_ware/refresh_token_interceptors.dart';

import 'package:sdk_wallet_flutter/presentation/shared/token/bloc/token_bloc.dart';

import '../../config/base/common/common_bloc.dart';
import '../../domain/repository/wallet_repository.dart';
import '../../presentation/onboarding/bloc/onboarding_bloc.dart';

import '../../presentation/shared/connect_wallet/bloc/connect_wallet_bloc.dart';
import '../../presentation/shared/wallet/bloc/wallet_bloc.dart';
import '../../utils/constants/app_constants.dart';
import '../repository_impl/wallet_repository_impl.dart';
import '../services/wallet_service.dart';
import 'middle_ware/logger_interceptors.dart';

void configureDependencies() {
  Get.put(AppConstants());
  Get.put(CommonBloc());
  Get.put(WalletService(provideDio()));
  Get.put<WalletRepository>(WalletRepositoryImpl(Get.find()));

  Get.put(ConnectWalletBloc());
  Get.put(WalletBloc());
  Get.put(TokenBloc());
  Get.put(OnboardingBloc());
}

Dio provideDio({TypeRepo type = TypeRepo.DEFAULT}) {
  final appConstants = Get.find<AppConstants>();

  final options = BaseOptions(
    baseUrl: type.getBaseUrl(appConstants),
    receiveTimeout: const Duration(seconds: 60),
    connectTimeout: const Duration(seconds: 60),
    followRedirects: false,
  );
  final dio = Dio(options);

  dio.transformer = BackgroundTransformer();
  dio.interceptors.addAll([
    ConnectivityInterceptor(),
    HeaderInterceptors(),
    AuthInterceptor(),
    RefreshTokenInterceptors(),
    if (Foundation.kDebugMode) CustomLogger()
  ]);

  return dio;
}

enum TypeRepo {
  DEFAULT,
  NEAR,
}

extension TypeRepoExt on TypeRepo {
  String getBaseUrl(AppConstants appConstants) {
    switch (this) {
      case TypeRepo.DEFAULT:
        return AppConstants.baseUrl;
      case TypeRepo.NEAR:
        return AppConstants.nearRpc;
      default:
        return AppConstants.baseUrl;
    }
  }
}
