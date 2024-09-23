import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/token_transaction.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/style_utils.dart';
import '../../../../../widgets/dropdown/text_drop_down.dart';
import '../component/item_transtion.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
    super.key,
    required this.trans,
  });
  final List<TokenTransactionModel> trans;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          toolbarCommon(title: S.current.transaction_history, context: context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH16,
          Container(
            margin: EdgeInsets.only(left: Dimens.d20.responsive()),
            width: Dimens.d90.responsive(),
            child: TextDropDown(
              initData: S.current.all_type,
              dropdownItems: [
                S.current.all_type,
                S.current.success,
                S.current.fail
              ],
              onChanged: (value) {},
            ),
          ),
          spaceH8,
          Expanded(
            child: ListView.builder(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
              itemCount: trans.length,
              itemBuilder: (context, index) => itemTransaction(
                trans[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
