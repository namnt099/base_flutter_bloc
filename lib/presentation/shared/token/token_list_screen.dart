import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/base/page/base_page_state.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/wallet.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/presentation/shared/token/bloc/token_bloc.dart';


import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/button/primary_button.dart';
import 'package:sdk_wallet_flutter/widgets/switch/custom_switch.dart';
import 'package:sdk_wallet_flutter/widgets/text_field/common_text_field.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

import '../../../config/resources/dimens.dart';
import '../../../config/resources/styles.dart';
import '../../../config/themes/app_theme.dart';
import '../../../domain/model/wallet/token.dart';
import '../../../utils/style_utils.dart';
import '../wallet/ui/wallet_screen.dart';

class TokenListScreen extends StatefulWidget {
  const TokenListScreen({super.key, required this.title});
  final String title;

  @override
  State<TokenListScreen> createState() => _TokenListScreenState();
}

class _TokenListScreenState extends BasePageState<TokenListScreen, TokenBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(title: widget.title, context: context),
      body: Stack(
     children: [
       Container(
         width: double.infinity,
         height: Dimens.d160.responsive(),
         decoration: BoxDecoration(
           color: AppTheme.getInstance().secondaryColor,
           image: DecorationImage(
             image: AssetImage(ImageAssets.images.fourthOnboarding.path),
             fit: BoxFit.cover,
           ),
         ),
       ),
       Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             child: Padding(
               padding: EdgeInsets.symmetric(
                 horizontal: Dimens.d20.responsive(),
               ),
               child: Column(
                 children: [
                   spaceH16,
                   //todo[hoang] color background CommonTextField white
                   CommonTextField(
                     name: '',
                     hintText: 'Search for the token you need',
                     onChanged: (value) {},
                   ),
                   spaceH12,
                   Expanded(
                     child: ListView.builder(
                       itemCount: 3,
                       itemBuilder: (context, index) => _itemTokenBuilder(
                         Wallet.wallets.first.tokens[index],
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
           Padding(
             padding:
             EdgeInsets.symmetric(horizontal: Dimens.d12.responsive()),
             child: Column(
               children: [
                 PrimaryButton(
                   onTap: () {
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (_) => const WalletScreen(),
                       ),
                     );
                   },
                   title: S.current.submit,
                 ),
               ],
             ),
           ),
           spaceH32,
         ],
       ),
     ],
      ),
    );
  }

  Widget _itemTokenBuilder(Token model) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimens.d16.responsive(),
        horizontal: Dimens.d12.responsive(),
      ),
      margin: EdgeInsets.symmetric(vertical: Dimens.d3.responsive()),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimens.d10.responsive())),
        color: AppTheme.getInstance().secondaryColor,
        boxShadow: ShadowUtil.shadowB15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //TODO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ImageAssets.images.logoBtc.image(
                height: Dimens.d32.responsive(),
                width: Dimens.d32.responsive(),
              ),
              spaceW6,
              RichText(
                text: TextSpan(
                  text: model.name,
                  style: AppTextStyle.boldText.copyWith(
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: '  ${model.symbol}',
                      style: AppTextStyle.lightText.copyWith(
                        color: AppTheme.getInstance().textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomSwitch(initialValue: model.enable, onChanged: (value) {})
        ],
      ),
    );
  }
}
