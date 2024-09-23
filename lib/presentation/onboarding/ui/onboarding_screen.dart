import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk_wallet_flutter/config/base/page/base_page_state.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/domain/model/onboarding.dart';
import 'package:sdk_wallet_flutter/domain/use_case/wallet_core/import_wallet_use_case.dart';
import 'package:sdk_wallet_flutter/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:sdk_wallet_flutter/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:sdk_wallet_flutter/presentation/onboarding/ui/component/page_child.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../config/themes/app_theme.dart';
import '../../shared/connect_wallet/connect_wallet_screen.dart';
import '../bloc/onboarding_bloc.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState
    extends BasePageState<OnboardingScreen, OnboardingBloc> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    disposeBag.addDisposable(_pageController);
  }

  @override
  void didChangeDependencies() {
    AppDimen.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        bloc: bloc,
        listenWhen: (previous, current) => previous.page != current.page,
        buildWhen: (previous, current) => previous.page != current.page,
        listener: (context, state) {
          _pageController.animateToPage(
            state.page,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.page == 0) ...[
                GestureDetector(
                  onTap: () {
                    //TODO(NAMNT back)
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                      left: Dimens.d20.responsive(),
                    ),
                    height: kToolbarHeight,
                    child: Container(
                      height: Dimens.d36.responsive(),
                      width: Dimens.d36.responsive(),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().formColor,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scale: 0.5,
                        child: ImageAssets.images.icBack.svg(),
                      ),
                    ),
                  ),
                )
              ],
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (value) {
                    // if (state.page < value) {
                    //   bloc.add(EmmittedPageAction(action: PageAction.next));
                    // } else {
                    //   bloc.add(EmmittedPageAction(action: PageAction.pre));
                    // }
                  },
                  controller: _pageController,
                  itemCount: OnboardingModel.getListModel.length,
                  itemBuilder: (context, index) {
                    final model = OnboardingModel.getListModel[index];
                    return PageChild(
                      model: model,
                      callback: model.ordered == Ordered.fourth
                          ? () {
                              final importUc = ImportWalletUseCase();
                              importUc.buildUseCase(
                                ImportWalletInput(
                                  type: 'SEED_PHRASE',
                                  content:
                                      'alpha derive category enact use dinner over sister snap reform pulp enough',
                                  walletName: 'walletName',
                                  chainType: 'BITCOIN',
                                ),
                              );
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => const ConnectWalletScreen(
                              //       action: WalletAction.create,
                              //     ),
                              //   ),
                              // );
                            }
                          : () {
                              bloc.add(
                                EmmittedPageAction(action: PageAction.next),
                              );
                            },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    disposeBag.dispose();
    super.dispose();
  }
}
