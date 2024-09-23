import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sdk_wallet_flutter/data/response/data_wallet_response/data_wallet_response.dart';

import '../../utils/constants/api_constants.dart';

part 'wallet_service.g.dart';

@RestApi()
abstract class WalletService {
  @factoryMethod
  factory WalletService(Dio dio, {String baseUrl}) = _WalletService;

  @POST(ApiConstants.GET_LIST_CUSTODIAL_WALLETS)
  //todo[hoang] check lại response DataWalletResponse
  Future<DataWalletResponse> getListCustorialWallets();
}
