import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sdk_wallet_flutter/config/resources/dimens.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/domain/model/wallet/token.dart';
import 'package:sdk_wallet_flutter/generated/l10n.dart';
import 'package:sdk_wallet_flutter/presentation/shared/wallet/ui/wallet_screen.dart';
import 'package:sdk_wallet_flutter/utils/constants/image_asset.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';
import 'package:sdk_wallet_flutter/widgets/dialog/custom_alert_dialog.dart';
import 'package:sdk_wallet_flutter/widgets/toolbar/toolbar_common.dart';

import '../../../../../utils/extensions/null_ext.dart';
import '../../../../../utils/style_utils.dart';
import '../../../../../widgets/button/out_line_button.dart';
import '../../../../../widgets/button/primary_button.dart';

class ReceiveToken extends StatefulWidget {
  const ReceiveToken({super.key, required this.token});
  final Token token;

  @override
  State<ReceiveToken> createState() => _ReceiveTokenState();
}

class _ReceiveTokenState extends State<ReceiveToken> {
  late final GlobalKey _globalKey;
  @override
  void initState() {
    _globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: toolbarCommon(title: S.current.receive_token, context: context),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RepaintBoundary(
                    key: _globalKey,
                    child: ColoredBox(
                      color: Colors.white,
                      child: QrImageView(
                        eyeStyle: QrEyeStyle(
                          color: AppTheme.getInstance().primaryColor,
                          eyeShape: QrEyeShape.square,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          color: AppTheme.getInstance().primaryColor,
                          dataModuleShape: QrDataModuleShape.square,
                        ),
                        data: widget.token.addressContract,
                        size: Dimens.d262.responsive(),
                        gapless: false,
                        backgroundColor: AppTheme.getInstance().secondaryColor,
                      ),
                    ),
                  ),
                  spaceH24,
                  //TODO
                  ImageAssets.images.logoBtc.image(
                    height: Dimens.d44.responsive(),
                    width: Dimens.d44.responsive(),
                    fit: BoxFit.cover,
                  ),
                  spaceH15,
                  Text(
                    '${widget.token.name}(${widget.token.symbol})',
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    //todo[hoang] network to chain name
                    widget.token.network,
                    style: AppTextStyle.regularText.copyWith(
                      fontSize: 14,
                      color: AppTheme.getInstance().textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimens.d20.responsive()),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.current.my_add,
                        style: AppTextStyle.regularText.copyWith(
                          color: AppTheme.getInstance().textSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                            ClipboardData(text: widget.token.addressContract),
                          );
                        },
                        child: ImageAssets.images.icCopyAdd.svg(),
                      )
                    ],
                  ),
                  spaceH8,
                  Text(
                    widget.token.addressContract,
                    style: AppTextStyle.mediumText.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  spaceH34,
                  bottomButton(context)
                ],
              ),
            ),
            spaceH20,
          ],
        ),
      ),
    );
  }

  Row bottomButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            onTap: saveImage,
            title: S.current.share_as_image,
            horizontalPadding: Dimens.d12.responsive(),
          ),
        ),
        spaceW8,
        Expanded(
          child: OutlineButton(
            onPress: () {
              Get.to(() => const WalletScreen());
            },
            title: S.current.go_to_wallet,
            buttonSize: ButtonSize.normal,
          ),
        ),
      ],
    );
  }

  Future<void> saveImage() async {
    final storagePer = await Permission.storage.request();
    final photoPer = await Permission.photos.request();
    if (storagePer.isGranted || photoPer.isGranted) {
      await saveImage();
    } else {
      await Get.dialog(
        CustomAlertDialog(
          title: S.current.save,
          content: S.current.storage_permission,
          onConfirm: () {
            openAppSettings();
          },
        ),
        barrierColor: AppTheme.getInstance().barrierColor,
      );
    }
  }

  Future<void> saveToGalery() async {
    final boundary = ScanNull.getInstance<RenderRepaintBoundary>(
      _globalKey.currentContext?.findRenderObject(),
    );

    final image = await boundary.toImage(
      pixelRatio: 2.0,
    );
    final ByteData? byteData = await image.toByteData(
      format: ImageByteFormat.png,
    );
    if (byteData != null) {
      await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
      );
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            S.current.saved,
            style: AppTextStyle.regularText,
          ),
        ),
      );
    }
  }
}
