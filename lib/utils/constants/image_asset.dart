// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/resources/images.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  SvgGenImage get icSetting => SvgGenImage('$baseIcon/ic_settings.svg');
  SvgGenImage get icWallet => SvgGenImage('$baseIcon/ic_wallet.svg');
  SvgGenImage get icNoti => SvgGenImage('$baseIcon/ic_notice.svg');
  SvgGenImage get icSupport => SvgGenImage('$baseIcon/ic_support.svg');
  SvgGenImage get icWarning => SvgGenImage('$baseIcon/ic_warning.svg');
  SvgGenImage get icCopy => SvgGenImage('$baseIcon/ic_copy.svg');
  SvgGenImage get icCopyAdd => SvgGenImage('$baseIcon/ic_copy_add.svg');
  SvgGenImage get icAddSmall => SvgGenImage('$baseIcon/ic_add_small.svg');

  //icon Direct
  SvgGenImage get icArrowLeft => SvgGenImage('$baseIcon/ic_arrow_left.svg');
  SvgGenImage get icBack => SvgGenImage('$baseIcon/ic_back.svg');
  SvgGenImage get icBasicBack => SvgGenImage('$baseIcon/ic_basic_back.svg');
  SvgGenImage get icRight => SvgGenImage('$baseIcon/ic_right.svg');
  SvgGenImage get icBasicDown => SvgGenImage('$baseIcon/ic_basic_down.svg');
  SvgGenImage get icMoreHozirontal =>
      SvgGenImage('$baseIcon/ic_more_horizontal.svg');
  SvgGenImage get icTick =>
      SvgGenImage('$baseIcon/ic_tick.svg');

  //icon detail wallet
  SvgGenImage get icEdit => SvgGenImage('$baseIcon/ic_edit.svg');
  SvgGenImage get icExport => SvgGenImage('$baseIcon/ic_export.svg');
  SvgGenImage get icRemove => SvgGenImage('$baseIcon/ic_remove.svg');
  // icon token
  SvgGenImage get icBTC => SvgGenImage('$baseIcon/ic_btc.svg');
  SvgGenImage get icSend => SvgGenImage('$baseIcon/ic_send.svg');
  SvgGenImage get icFunding => SvgGenImage('$baseIcon/ic_funding.svg');
  SvgGenImage get icReceive => SvgGenImage('$baseIcon/ic_receive.svg');
  SvgGenImage get icSmallSend => SvgGenImage('$baseIcon/ic_small_send.svg');
  SvgGenImage get icSmallReceive =>
      SvgGenImage('$baseIcon/ic_small_receive.svg');
  SvgGenImage get icChevronDown => SvgGenImage('$baseIcon/ic_chevron_down.svg');
  SvgGenImage get icClose => SvgGenImage('$baseIcon/ic_close.svg');
  SvgGenImage get icReload => SvgGenImage('$baseIcon/ic_reload.svg');
  SvgGenImage get icAddressBook => SvgGenImage('$baseIcon/ic_address_book.svg');
  SvgGenImage get icScan => SvgGenImage('$baseIcon/ic_scan.svg');

  ///png Onboarding
  AssetGenImage get firstOnboarding =>
      AssetGenImage('$baseImg/onboarding_first.png');
  AssetGenImage get secondOnboarding =>
      AssetGenImage('$baseImg/onboarding_second.png');
  AssetGenImage get thirdOnboarding =>
      AssetGenImage('$baseImg/onboarding_third.png');
  AssetGenImage get fourthOnboarding =>
      AssetGenImage('$baseImg/onboarding_fourth.png');
  //REMOVE AFTER
  AssetGenImage get logoBtc => AssetGenImage('$baseImg/logo_btc.png');
}

class ImageAssets {
  ImageAssets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class ImageGen {
  const ImageGen(this._assetName);

  final String _assetName;
  String get path => _assetName;
}

class AssetGenImage extends ImageGen {
  AssetGenImage(super.assetName);

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }
}

class SvgGenImage extends ImageGen {
  SvgGenImage(super.assetName);

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme ?? const SvgTheme(),
    );
  }
}
