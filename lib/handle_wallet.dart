import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sdk_wallet_flutter/domain/locals/prefs_service.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/presentation/onboarding/ui/onboarding_screen.dart';

import 'package:sdk_wallet_flutter/utils/constants/app_constants.dart';
import 'package:sdk_wallet_flutter/utils/constants/device_constants.dart';

import 'config/themes/app_theme.dart';
import 'presentation/shared/wallet/ui/wallet_screen.dart';

class HandleWallet extends StatefulWidget {
  @override
  HandleWalletState createState() => HandleWalletState();

  const HandleWallet({
    super.key,
  });
}

class HandleWalletState extends State<HandleWallet> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: ScreenUtilInit(
        designSize: const Size(
          DeviceConstants.designDeviceWidth,
          DeviceConstants.designDeviceHeight,
        ),
        builder: (context, child) => GetMaterialApp(
          // navigatorKey: navigatorKey,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          home: _view(context),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            dialogBackgroundColor: AppTheme.getInstance().secondaryColor,
          ),
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale('en'),
        ),
      ),
    );
  }

  Widget _view(BuildContext context) {
    //todo[hoang] OnboardingScreen
    return const OnboardingScreen();
    final firstOpenWallet = PrefsService.getFirstLaunch;
    if (firstOpenWallet) {
      PrefsService.saveFirstLaunch(false);
      return const OnboardingScreen();
    } else {
      return const WalletScreen();
    }
  }
}
