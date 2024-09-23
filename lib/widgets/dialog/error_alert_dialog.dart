import 'package:flutter/material.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';

import '../../generated/l10n.dart';
import 'common_dialog.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    super.key,
     this.title,
    required this.content,
  });
  final String? title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return CommonAlertDialog(
      title: Text(
        title ?? S.current.error,
        textAlign: TextAlign.center,
        style: AppTextStyle.regularText.copyWith(),
      ),
      content: Column(
        children: [
          Text(
            content,
            textAlign: TextAlign.center,
            style: AppTextStyle.lightText.copyWith(
              color: AppTheme.getInstance().textSecondary,
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            S.current.cancel,
            style: AppTextStyle.lightText.copyWith(
              fontSize: 18,
              color: AppTheme.getInstance().statusFail,
            ),
          ),
        ),
      ],
    );
  }
}
