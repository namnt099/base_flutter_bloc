import 'package:sdk_wallet_flutter/config/base/bloc/base_bloc.dart';
import 'package:sdk_wallet_flutter/presentation/shared/setting/bloc/setting_event.dart';
import 'package:sdk_wallet_flutter/presentation/shared/setting/bloc/setting_state.dart';

class SettingBloc extends BaseBloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState());
}
