import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sdk_wallet_flutter/config/themes/app_theme.dart';

class AppTextStyle {
  AppTextStyle._();

  /// Regular
  static final boldText = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppTheme.getInstance().textPrimary,
  );
  static final regularText = GoogleFonts.poppins(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppTheme.getInstance().textPrimary,
  );
  static final mediumText = GoogleFonts.poppins(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppTheme.getInstance().textPrimary,
  );
  static final lightText = GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppTheme.getInstance().textPrimary,
  );
}
