import 'package:flutter/cupertino.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';
import 'package:sdk_wallet_flutter/widgets/dialog/common_dialog.dart';
import 'package:sdk_wallet_flutter/widgets/text_field/common_text_field.dart';

import '../../generated/l10n.dart';
import '../../utils/style_utils.dart';

class CustomEnterDialog extends StatelessWidget {
  const CustomEnterDialog({
    super.key,
    required this.title,
    this.content,
    required this.hintext,
    this.cancelText,
    this.confirmText,
    required this.onConfirm,
  });
  final String title;
  final String? content;
  final String hintext;
  final String? cancelText;
  final String? confirmText;
  final Function(String) onConfirm;

  @override
  Widget build(BuildContext context) {
    String text = '';
    return CommonAlertDialog(
      title: Text(
        title,
        style: AppTextStyle.regularText,
      ),
      content: Column(
        children: [
          if (content != null) ...[
            Text(
              content!,
              style: AppTextStyle.regularText.copyWith(
                fontSize: 14,
              ),
            ),
            spaceH8,
          ],
          spaceH8,
          CommonTextField(
            hintText: hintext,
            name: '',
            onChanged: (value) {
              text = value;
            },
          ),
        ],
      ),
      actions: [
        GestureDetector(
          child: Text(
            cancelText ?? S.current.cancel,
            style: AppTextStyle.lightText.copyWith(
              fontSize: 18,
              color: AppTheme.getInstance().textSecondary,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onConfirm.call(text);
          },
          child: Text(
            confirmText ?? S.current.confirm,
            style: AppTextStyle.lightText.copyWith(
              fontSize: 18,
              color: AppTheme.getInstance().statusComplete,
            ),
          ),
        ),
      ],
    );
  }
}
