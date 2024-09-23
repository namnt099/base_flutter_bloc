import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sdk_wallet_flutter/config/resources/styles.dart';
import 'package:sdk_wallet_flutter/utils/extensions/app_dimen.dart';

import '../../config/resources/dimens.dart';
import '../../config/themes/app_theme.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.name,
    required this.hintText,
    this.sufficIcon,
    this.obscureText = false,
    required this.onChanged,
    this.validator,
    this.textStyle,
    this.contentPadding,
    this.cusorColor,
  });
  final String name;
  final String hintText;
  final Widget? sufficIcon;
  final bool obscureText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? cusorColor;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      cursorColor: cusorColor ?? AppTheme.getInstance().textPrimary,
      name: name,
      style: textStyle ??
          AppTextStyle.regularText.copyWith(
            color: AppTheme.getInstance().textPrimary,
            fontSize: 14,
          ),
      onChanged: (value) {
        onChanged(value ?? '');
      },
      validator: validator,
      obscureText: obscureText,
      maxLines: null,
      decoration: InputDecoration(
        suffix: sufficIcon,
        contentPadding:
            contentPadding ?? EdgeInsets.all(Dimens.d16.responsive()),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.getInstance().primaryColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.d8.responsive()),
          ),
        ),
        hintStyle: AppTextStyle.regularText.copyWith(
          color: AppTheme.getInstance().textSecondary,
          fontSize: 14,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.getInstance().textPrimary,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.d8.responsive()),
          ),
        ),
      ),
    );
  }
}
