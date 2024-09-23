import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/base/page/base_page_state.dart';
import 'package:sdk_wallet_flutter/presentation/shared/setting/bloc/setting_bloc.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../config/resources/dimens.dart';
import '../../../config/resources/styles.dart';
import '../../../generated/l10n.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/switch/custom_switch.dart';
import '../../../widgets/toolbar/toolbar_common.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends BasePageState<SettingScreen, SettingBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(title: S.current.wallet_settings, context: context),
      body: Column(
        children: [
          spaceH16,
          rowItem(
            callback: () {},
            rightChild: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  //TODO
                  Text(
                    'USD',
                    style: AppTextStyle.regularText.copyWith(fontSize: 16),
                  ),
                  spaceW4,
                  ImageAssets.images.icBasicDown.svg(),
                ],
              ),
            ),
            text: S.current.currency,
            image: ImageAssets.images.icWallet,
          ),
          rowItem(
            callback: () {},
            rightChild: CustomSwitch(
              onChanged: (value) {},
            ),
            text: S.current.push_notification,
            image: ImageAssets.images.icNoti,
          ),
          rowItem(
            callback: () {},
            text: S.current.customer_support,
            image: ImageAssets.images.icSupport,
          ),
        ],
      ),
    );
  }

  Widget rowItem({
    required String text,
    required SvgGenImage image,
    Widget? rightChild,
    required VoidCallback callback,
    Widget? belowWidget,
  }) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Dimens.d12.responsive(),
          horizontal: Dimens.d20.responsive(),
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xffF0F0F0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      image.svg(),
                      spaceW16,
                      Text(
                        text,
                        style: AppTextStyle.regularText,
                      ),
                    ],
                  ),
                  if (belowWidget != null) ...[
                    spaceH8,
                    belowWidget,
                  ]
                ],
              ),
            ),
            rightChild ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
