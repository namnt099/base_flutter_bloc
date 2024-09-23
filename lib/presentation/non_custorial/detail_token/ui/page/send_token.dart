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
import 'package:sdk_wallet_flutter/widgets/text_field/common_text_field.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

class SendToken extends StatefulWidget {
  const SendToken({super.key, required this.token});
  final Token token;

  @override
  State<SendToken> createState() => _SendTokenState();
}

class _SendTokenState extends State<SendToken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(title: S.current.send_token, context: context),
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
                        //todo[hoang] network to chain name
                        '${widget.token.network} ${S.current.chain.toLowerCase()}',
                    onChanged: (value) {},
                  ),
                  spaceH24,
                  stackTextField(),
                  spaceH8,
                  addAddressToBook(),
                  spaceH16,
                  CommonTextField(
                    name: S.current.insert_amount,
                    hintText:
                        '${S.current.insert_amount} ${widget.token.symbol}',
                    sufficIcon: Text(
                      'Max',
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
            PrimaryButton(onTap: () {}, title: S.current.next),
            spaceH40,
          ],
        ),
      ),
    );
  }

  List<Widget> _gasFee() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Gas fee',
            style: AppTextStyle.regularText.copyWith(
              fontSize: 14,
              color: AppTheme.getInstance().textSecondary,
            ),
          ),
          Text(
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
            'Total amount',
            style: AppTextStyle.regularText.copyWith(
              fontSize: 14,
              color: AppTheme.getInstance().textSecondary,
            ),
          ),
          Text(
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

  Widget stackTextField() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          right: Dimens.d16.responsive(),
          top: Dimens.d12.responsive(),
          child: Row(
            children: [
              ImageAssets.images.icAddressBook.svg(),
              spaceW12,
              ImageAssets.images.icScan.svg(),
            ],
          ),
        ),
        CommonTextField(
          name: 'addressBook',
          hintText: S.current.insert_wallet_address,
          onChanged: (value) {},
          cusorColor: AppTheme.getInstance().primaryColor,
          textStyle: AppTextStyle.lightText.copyWith(
            color: AppTheme.getInstance().primaryColor,
          ),
          contentPadding: EdgeInsets.only(
            top: Dimens.d16.responsive(),
            left: Dimens.d12.responsive(),
            bottom: Dimens.d16.responsive(),
            right: Dimens.d72.responsive(),
          ),
        ),
      ],
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
                    'Balance ${widget.token.balance}',
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

  Widget addAddressToBook() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Dimens.d8.responsive(),
        horizontal: Dimens.d16.responsive(),
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().formColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.d8.responsive())),
      ),
      child: Row(
        children: [
          ImageAssets.images.icAddSmall.svg(),
          spaceW8,
          Text(
            S.current.add_to_address_book,
            style: AppTextStyle.regularText.copyWith(
              fontSize: 14,
              color: AppTheme.getInstance().primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
