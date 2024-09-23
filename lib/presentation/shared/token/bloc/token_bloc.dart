import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';
import 'package:sdk_wallet_flutter/presentation/shared/token/bloc/token_event.dart';
import 'package:sdk_wallet_flutter/presentation/shared/token/bloc/token_state.dart';

class TokenBloc extends BaseBloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenState());
}
