import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';
import 'package:sdk_wallet_flutter/presentation/non_custorial/detail_token/bloc/detail_token_event.dart';

import 'detail_token_state.dart';

class DetailTokenBloc extends BaseBloc<DetailTokenEvent, DetailTokenState> {
  DetailTokenBloc() : super(DetailTokenState());
}
