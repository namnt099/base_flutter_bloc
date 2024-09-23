import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk_wallet_flutter/config/base/page/base_page_state.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/presentation/shared/setting/setting_screen.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/ui/detail_wallet_page.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/button/common_back_button.dart';
import 'package:sdk_wallet_flutter/widgets/button/primary_button.dart';
import 'package:sdk_wallet_flutter/widgets/button/rounded_button.dart';

import '../../../../domain/model/wallet/wallet.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/style_utils.dart';
import '../../../../widgets/toolbar/toolbar_arc.dart';
import '../../connect_wallet/connect_wallet_screen.dart';
import '../bloc/wallet_bloc.dart';
import '../bloc/wallet_event.dart';
import '../bloc/wallet_state.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends BasePageState<WalletScreen, WalletBloc> {
  @override
  void initState() {
    initEvent();
    super.initState();
  }

  void initEvent() {
    bloc.add(GetListSystemWallet());
    bloc.add(GetListCoreWallet());
  }

  @override
  void didChangeDependencies() {
    AppDimen.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WalletBloc, WalletState>(
        bloc: bloc,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.coreWallet.isEmpty && state.custorialWallets.isEmpty
              ? emptyListWallet(context)
              : mainBody(context, state);
        },
      ),
    );
  }

  Column mainBody(BuildContext context, WalletState state) {
    return Column(
      children: [
        _buildToolbar(context),
        spaceH18,
        _buildListWallet(state),
        spaceH12,
        bottomButton(context),
        spaceH16,
      ],
    );
  }

  Expanded _buildListWallet(WalletState state) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          bloc.add(WalletRefreshed());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimens.d20.responsive(),
            ),
            child: Column(
              children: [
                ...state.custorialWallets.map((e) => _itemWalletBuilder(e)),
                ...state.coreWallet.map((e) => _itemWalletBuilder(e))
              ],
            ),
          ),
        ),
      ),
    );
  }

  ToolbarArc _buildToolbar(BuildContext context) {
    return ToolbarArc(
      title: Text(
        S.current.crypto_wallet,
        style: AppTextStyle.boldText.copyWith(
          color: AppTheme.getInstance().secondaryColor,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      leading: const CommonButtonBack(),
      actions: [
        CommonIconButton(
          image: ImageAssets.images.icSetting,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SettingScreen(),
              ),
            );
          },
        ),
      ],
      bottomWidget: Text(
        //TODO
        '\$ 2,030,760.62s',
        style: AppTextStyle.boldText.copyWith(
          color: Colors.white,
          fontSize: 32,
        ),
      ),
    );
  }

  Row bottomButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ConnectWalletScreen(
                  action: WalletAction.import,
                ),
              ),
            );
          },
          title: S.current.import_wallet,
          buttonType: ButtonType.secondary,
        ),
        spaceW8,
        PrimaryButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ConnectWalletScreen(
                  action: WalletAction.create,
                ),
              ),
            );
          },
          title: S.current.create_wallet,
        ),
      ],
    );
  }

  Column emptyListWallet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PrimaryButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ConnectWalletScreen(
                      action: WalletAction.import,
                    ),
                  ),
                );
              },
              title: S.current.import_wallet,
              buttonType: ButtonType.secondary,
            ),
            spaceW8,
            PrimaryButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ConnectWalletScreen(
                      action: WalletAction.create,
                    ),
                  ),
                );
              },
              title: S.current.create_wallet,
            ),
          ],
        )
      ],
    );
  }

  Widget _itemWalletBuilder(Wallet wallet) {
    return GestureDetector(
      onTap: () {
        bloc.add(IndexedWallet(wallet.walletName));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailWalletPage(model: wallet)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimens.d6.responsive()),
        padding: EdgeInsets.symmetric(
          vertical: Dimens.d18.responsive(),
          horizontal: Dimens.d16.responsive(),
        ),
        decoration: BoxDecoration(
          color: wallet.kind == WalletKind.custorial
              ? AppTheme.getInstance().primaryColor
              : AppTheme.getInstance().formColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimens.d8.responsive(),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  wallet.walletName,
                  style: AppTextStyle.regularText.copyWith(
                    fontSize: 16,
                    color: wallet.kind == WalletKind.custorial
                        ? AppTheme.getInstance().formColor
                        : AppTheme.getInstance().textSecondary,
                  ),
                ),
                spaceW16,
                wallet.systemWidget()
              ],
            ),
            spaceH8,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  //TODO
                  '\$ 1000',
                  style: AppTextStyle.boldText.copyWith(
                    color: wallet.kind == WalletKind.custorial
                        ? AppTheme.getInstance().formColor
                        : AppTheme.getInstance().textPrimary,
                  ),
                ),
                if (wallet.kind == WalletKind.custorial)
                  Row(
                    children: [
                      Text(
                        //TODO
                        S.current.default_text,
                        style: AppTextStyle.lightText.copyWith(
                          fontSize: 12,
                          color: AppTheme.getInstance().secondaryColor,
                        ),
                      ),
                      spaceW8,
                      ImageAssets.images.icTick.svg(),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
