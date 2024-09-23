import 'package:sdk_wallet_flutter/config/app_config.dart';
import 'package:sdk_wallet_flutter/config/resources/color.dart';
import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';

class AppTheme {
  static AppColor? _instance;

  static AppColor getInstance() {
    _instance ??= AppMode.LIGHT == APP_THEME ? LightApp() : DarkApp();
    return _instance!;
  }
}
