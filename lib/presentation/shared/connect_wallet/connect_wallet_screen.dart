import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../config/base/page/base_page_state.dart';
import '../../../config/resources/dimens.dart';
import '../../../config/resources/styles.dart';
import '../../../config/themes/app_theme.dart';
import '../../../generated/l10n.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/regex_constants.dart';
import '../../../utils/extensions/string_ext.dart';
import '../../../utils/style_utils.dart';
import '../../../widgets/button/primary_button.dart';
import '../../../widgets/dropdown/outline_drop_down.dart';
import '../../../widgets/text_field/common_text_field.dart';
import '../../../widgets/toolbar/toolbar_common.dart';
import 'bloc/connect_wallet_bloc.dart';
import 'bloc/connect_wallet_event.dart';
import 'bloc/connect_wallet_state.dart';

enum WalletAction { create, import }

class ConnectWalletScreen extends StatefulWidget {
  //todo[hoang] thêm 1 list wallet để check trùng tên hoăc cần 1 api để check trùng tên
  const ConnectWalletScreen({super.key, required this.action});
  final WalletAction action;
  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState
    extends BasePageState<ConnectWalletScreen, ConnectWalletBloc> {
  final _key = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    bloc.add(InitiatedEvent(widget.action));
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().secondaryColor,
      appBar: toolbarCommon(
        title: widget.action == WalletAction.create
            ? S.current.create_wallet
            : S.current.import_wallet,
        context: context,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: _key,
                  child: Column(
                    children: [
                      spaceH24,
                      ..._buildInstructText(),
                      spaceH36,
                      CommonTextField(
                        name: S.current.wallet_name,
                        hintText: S.current.enter_name,
                        onChanged: (value) =>
                            bloc.add(WalletNameOnChanged(value)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${S.current.wallet_name} ${S.current.is_require}';
                          }
                          return null;
                        },
                      ),
                      if (widget.action == WalletAction.import) ...[
                        spaceH16,
                        OutlineDropDown(
                          dropdownItems: AppConstants.chainKind,
                          onChanged: (ChainKind value) =>
                              bloc.add(ChainOnChanged(value)),
                          placeHolder: S.current.net_work,
                        ),
                        spaceH16,
                        OutlineDropDown(
                          dropdownItems: AppConstants.secretKeysKind,
                          onChanged: (SecretKeyKind value) =>
                              bloc.add(SecretKeyKindOnChanged(value)),
                          placeHolder: S.current.private_key,
                        ),
                        spaceH16,
                        BlocBuilder<ConnectWalletBloc, ConnectWalletState>(
                          buildWhen: (previous, current) =>
                          previous.secretKeyType != current.secretKeyType,
                          bloc: bloc,
                          builder: (context, state) {
                            return CommonTextField(
                              name: S.current.secret_key,
                              hintText: state.secretKeyType.isEmpty
                                  ? S.current.private_key
                                  : state.secretKeyType,
                              onChanged: (value) =>
                                  bloc.add(SecretKeyOnChanged(value)),
                              validator: (value) {
                                return validatorSecretKey(
                                  value,
                                  state.secretKeyType,
                                );
                              },
                            );
                          },
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<ConnectWalletBloc, ConnectWalletState>(
              buildWhen: (previous, current) =>
                  previous.enabledButton != current.enabledButton,
              bloc: bloc,
              builder: (context, state) {
                return Opacity(
                  opacity: state.enabledButton ? 1 : 0.6,
                  child: PrimaryButton(
                    onTap: state.enabledButton
                        ? () {
                            if (_key.currentState?.validate() ?? false) {
                              bloc.add(ButtonOnPressed());
                            }
                          }
                        : () {},
                    title: widget.action == WalletAction.import
                        ? S.current.import
                        : S.current.create,
                  ),
                );
              },
            ),
            spaceH40,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInstructText() {
    return [
      Row(
        children: [
          dot,
          spaceW8,
          Text(
            S.current.please_set_up,
            style: AppTextStyle.lightText.copyWith(
              color: AppTheme.getInstance().textSecondary,
            ),
          )
        ],
      ),
      if (widget.action == WalletAction.import) ...[
        spaceH16,
        Row(
          children: [
            dot,
            spaceW8,
            Expanded(
              child: Text(
                S.current.imported_account,
                style: AppTextStyle.lightText.copyWith(
                  color: AppTheme.getInstance().textSecondary,
                ),
              ),
            )
          ],
        )
      ]
    ];
  }

  String? validatorSecretKey(String? value, String secretKeyType) {
    String? error;
    final text = value?.trim();
    if (value.isNullOrEmpty) {
      return '$secretKeyType ${S.current.is_require}';
    }
    if (secretKeyType == SecretKeyKind.private.key) {
      return error ??
          text?.isNormalCharacter(
            errorMessage: S.current.invalid_private_key,
          );
    } else {
      return error ??
          (value?.trim().split(RegexConstants.SPACE_CHARACTER).length != 12
              ? S.current.invalid_seedphrase
              : null);
    }
  }

  Widget get dot => Container(
        height: Dimens.d4.responsive(),
        width: Dimens.d4.responsive(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.getInstance().textSecondary,
        ),
      );
}
