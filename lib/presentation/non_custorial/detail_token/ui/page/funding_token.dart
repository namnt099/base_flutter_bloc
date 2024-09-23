import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/token.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/utils/style_utils.dart';
import 'package:sdk_wallet_flutter/widgets/button/out_line_button.dart';
import 'package:sdk_wallet_flutter/widgets/button/primary_button.dart';
import 'package:sdk_wallet_flutter/widgets/dropdown/outline_drop_down.dart';
import 'package:sdk_wallet_flutter/widgets/text_field/common_text_field.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

class FundingToken extends StatefulWidget {
  const FundingToken({super.key, required this.token});
  final Token token;

  @override
  State<FundingToken> createState() => _FundingTokenState();
}

class _FundingTokenState extends State<FundingToken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(title: S.current.funding, context: context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceH16,
                  _itemToken(),
                  spaceH24,
                  CommonTextField(
                    name: S.current.chain,
                    hintText:
                        //todo handle widget.token.network to chain name
                        '${widget.token.network} ${S.current.chain.toLowerCase()}',
                    onChanged: (value) {},
                  ),
                  spaceH24,
                  OutlineDropDown(
                    //todo hard code Wallet name
                    placeHolder: 'Wallet 1',
                    dropdownItems: const ['Wallet 1', 'Wallet 2', 'Wallet 3'],
                    onChanged: (value) {},
                  ),
                  spaceH16,
                  CommonTextField(
                    name: 'amount',
                    hintText:
                        '${S.current.insert_amount} ${widget.token.symbol}',
                    sufficIcon: Text(
                      S.current.max,
                      style: AppTextStyle.regularText.copyWith(
                        fontSize: 14,
                        color: AppTheme.getInstance().primaryColor,
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                  spaceH8,
                  Text(
                    //TODO
                    '${S.current.conver_value} = 100.000 USD',
                    style: AppTextStyle.regularText.copyWith(
                      fontSize: 14,
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                  spaceH8,
                  Wrap(
                    spacing: Dimens.d10.responsive(),
                    children: ['25%', '50%', '75%']
                        .map(
                          (e) => SizedBox(
                            width: (MediaQuery.of(context).size.width -
                                    Dimens.d60.responsive()) /
                                3,
                            child: OutlineButton(
                              title: e,
                              buttonSize: ButtonSize.small,
                              onPress: () {},
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
            ..._gasFee(),
            PrimaryButton(
              onTap: () {},
              title: S.current.next,
            ),
            spaceH40,
          ],
        ),
      ),
    );
  }

  Widget _itemToken() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimens.d10.responsive(),
        horizontal: Dimens.d8.responsive(),
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().secondaryColor,
        boxShadow: ShadowUtil.shadowB15,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.d8.responsive())),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ImageAssets.images.logoBtc.image(),
              spaceW10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.token.name,
                    style: AppTextStyle.mediumText.copyWith(fontSize: 16),
                  ),
                  Text(
                    '${S.current.balance} ${widget.token.balance}',
                    style: AppTextStyle.lightText.copyWith(
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(
                S.current.refresh,
                style: AppTextStyle.regularText.copyWith(
                  fontSize: 14,
                  color: AppTheme.getInstance().primaryColor,
                ),
              ),
              spaceW4,
              ImageAssets.images.icReload.svg()
            ],
          )
        ],
      ),
    );
  }
}

List<Widget> _gasFee() {
  return [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.current.gas_fee,
          style: AppTextStyle.regularText.copyWith(
            fontSize: 14,
            color: AppTheme.getInstance().textSecondary,
          ),
        ),
        Text(
          //TODO
          '0.01 BTC',
          style: AppTextStyle.boldText.copyWith(
            fontSize: 20,
            color: AppTheme.getInstance().textSecondary,
          ),
        )
      ],
    ),
    spaceH8,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.current.total_amount,
          style: AppTextStyle.regularText.copyWith(
            fontSize: 14,
            color: AppTheme.getInstance().textSecondary,
          ),
        ),
        Text(
          //TODO
          '24.00 BTC',
          style: AppTextStyle.boldText.copyWith(
            fontSize: 20,
            color: AppTheme.getInstance().textSecondary,
          ),
        )
      ],
    ),
    spaceH16,
  ];
}
