import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../../../config/resources/dimens.dart';
import '../../../../config/resources/styles.dart';
import '../../../../config/themes/app_theme.dart';
import '../../../../domain/model/onboarding.dart';
import '../../../../utils/style_utils.dart';

class PageChild extends StatelessWidget {
  const PageChild({super.key, required this.model, required this.callback});
  final OnboardingModel model;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return model.ordered == Ordered.fourth
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(model.image.path),
                fit: BoxFit.fitWidth,
                alignment: const Alignment(0, 2.5),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.getInstance().formColor,
                  Colors.white,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: S.current.now_you_are,
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 24,
                          color: AppTheme.getInstance().textPrimary,
                        ),
                        children: [
                          TextSpan(
                            text: S.current.hola_pay,
                            style: AppTextStyle.boldText.copyWith(
                              fontSize: 24,
                              color: AppTheme.getInstance().primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: S.current.first_time,
                            style: AppTextStyle.boldText.copyWith(
                              fontSize: 24,
                              color: AppTheme.getInstance().textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH16,
                    RichText(
                      text: TextSpan(
                        text: S.current.get_wallet_right_now,
                        style: AppTextStyle.boldText.copyWith(
                          fontSize: 24,
                          color: AppTheme.getInstance().textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                model.ordered
                    .bottomButton(context: context, callback: callback),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: model.ordered == Ordered.first
                    ? const Alignment(0, -0.2)
                    : Alignment.center,
                image: AssetImage(model.image.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: model.ordered.crossAxisAlignment,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  model.title,
                  textAlign: model.ordered.textAlign,
                  style: AppTextStyle.boldText,
                ),
                spaceH8,
                SizedBox(
                  height: Dimens.d100,
                  child: Text(
                    model.content,
                    textAlign: model.ordered.textAlign,
                    style: AppTextStyle.lightText.copyWith(
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                ),
                model.ordered
                    .bottomButton(context: context, callback: callback),
                spaceH40,
              ],
            ),
          );
  }
}
