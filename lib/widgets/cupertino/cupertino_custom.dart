import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';

class CupertinoPopupSurfaceCustom extends StatelessWidget {
  /// Creates an iOS-style rounded rectangle popup surface.
  const CupertinoPopupSurfaceCustom({
    super.key,
    this.isSurfacePainted = true,
    this.child,
    this.cornerRadius,
    this.blurAmount,
    this.dialogColor,
  });

  final bool isSurfacePainted;
  final double? cornerRadius;
  final double? blurAmount;
  final Color? dialogColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 14)),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount ?? 14,
          sigmaY: blurAmount ?? 14,
        ),
        child: Container(
          color: isSurfacePainted
              ? CupertinoDynamicColor.resolve(
                  dialogColor ?? AppTheme.getInstance().secondaryColor,
                  context,
                )
              : null,
          child: child,
        ),
      ),
    );
  }
}
