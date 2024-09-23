import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../config/resources/dimens.dart';
import '../../config/resources/styles.dart';
import '../../config/themes/app_theme.dart';
import '../../generated/l10n.dart';
import '../../presentation/shared/wallet/ui/wallet_screen.dart';
import '../../utils/constants/image_asset.dart';
import '../../utils/style_utils.dart';
import '../../widgets/button/primary_button.dart';

class OnboardingModel {
  final AssetGenImage image;
  final String title;
  final String content;
  final String buttonTitle;
  final Ordered ordered;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.content,
    required this.buttonTitle,
    required this.ordered,
  });
  static List<OnboardingModel> get getListModel => [
        OnboardingModel(
          image: ImageAssets.images.firstOnboarding,
          ordered: Ordered.first,
          title: S.current.onboard_first_title,
          content: S.current.onboard_first_content,
          buttonTitle: S.current.swipe_left,
        ),
        OnboardingModel(
          image: ImageAssets.images.secondOnboarding,
          ordered: Ordered.second,
          title: S.current.onboard_second_title,
          content: S.current.onboard_second_content,
          buttonTitle: S.current.next,
        ),
        OnboardingModel(
          image: ImageAssets.images.thirdOnboarding,
          ordered: Ordered.third,
          title: S.current.onboard_third_title,
          content: S.current.onboard_third_content,
          buttonTitle: S.current.let,
        ),
        OnboardingModel(
          image: ImageAssets.images.fourthOnboarding,
          ordered: Ordered.fourth,
          title: S.current.onboard_third_title,
          content: S.current.onboard_third_content,
          buttonTitle: S.current.creat_a_wallet,
        ),
      ];
}

enum Ordered { first, second, third, fourth }

extension WidgetOrdered on Ordered {
  CrossAxisAlignment get crossAxisAlignment {
    switch (this) {
      case Ordered.first:
        return CrossAxisAlignment.start;
      case Ordered.second:
        return CrossAxisAlignment.center;
      case Ordered.third:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.center;
    }
  }

  TextAlign get textAlign {
    switch (this) {
      case Ordered.first:
        return TextAlign.start;
      case Ordered.second:
        return TextAlign.center;
      case Ordered.third:
        return TextAlign.end;
      case Ordered.fourth:
        return TextAlign.start;
      default:
        return TextAlign.center;
    }
  }

  Widget bottomButton({BuildContext? context, required VoidCallback callback}) {
    switch (this) {
      case Ordered.first:
        return Row(
          children: [
            InkWell(
              onTap: () {
                if (context == null) {
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const WalletScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.d24.responsive(),
                  vertical: Dimens.d12.responsive(),
                ),
                child: Text(
                  S.current.skip,
                  style: AppTextStyle.regularText.copyWith(
                    color: AppTheme.getInstance().textSecondary,
                  ),
                ),
              ),
            ),
            spaceW8,
            Expanded(
              child: PrimaryButton(
                onTap: callback,
                title: S.current.swipe_left,
                kind: ButtonKind.left,
                image: ImageAssets.images.icArrowLeft,
              ),
            ),
          ],
        );
      case Ordered.second:
        return PrimaryButton(
          onTap: callback,
          title: S.current.let,
          kind: ButtonKind.right,
          image: ImageAssets.images.icRight,
        );
      case Ordered.third:
        return PrimaryButton(
          onTap: callback,
          title: S.current.next,
          kind: ButtonKind.right,
          image: ImageAssets.images.icRight,
        );
      case Ordered.fourth:
        return PrimaryButton(
          width: double.infinity,
          onTap: callback,
          title: S.current.creat_a_wallet,
          image: ImageAssets.images.icArrowLeft,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
