import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:sdk_wallet_flutter/config/base/common/common_bloc.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/data/helper/dispose_bag.dart';

import '../../../data/exception/exception_wrapper.dart';
import '../bloc/base_bloc.dart';
import '../common/common_state.dart';

abstract class BasePageState<T extends StatefulWidget, B extends BaseBloc>
    extends BasePageStateDelegate<T, B> {}

abstract class BasePageStateDelegate<T extends StatefulWidget,
    B extends BaseBloc> extends State<T> {
  CommonBloc get commonBloc => Get.find();
  B get bloc => Get.find();
  late final DisposeBag disposeBag;
  @override
  void initState() {
    disposeBag = DisposeBag();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => commonBloc),
        BlocProvider(create: (_) => bloc),
      ],
      child: BlocListener<CommonBloc, CommonState>(
        listenWhen: (previous, current) =>
            previous.wrapper?.exception != current.wrapper?.exception &&
            current.wrapper?.exception != null,
        listener: (context, state) {
          handleException(state.wrapper!);
        },
        child: buildPageListeners(
          child: Stack(
            children: [
              buildPage(context),
              BlocBuilder<CommonBloc, CommonState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading,
                builder: (context, state) => Visibility(
                  visible: state.isLoading,
                  child: buildPageLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageListeners({required Widget child}) => child;

  Widget buildPageLoading() => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2,
          sigmaY: 2,
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.getInstance().statusFail,
          ),
        ),
      );

  Widget buildPage(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    disposeBag.dispose();
  }

  void handleException(ExceptionWrapper wrapper) {
    bloc.exceptionHandler.handleException(wrapper);
  }
}
