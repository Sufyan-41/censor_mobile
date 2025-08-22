import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  // Base font families
  static const String headingFontFamily = 'Inter'; // Modern, clean for headings
  static const String bodyFontFamily =
      'System'; // System font for better readability

  // Heading Text Styles - Modern and Bold
  static TextStyle get displayLarge => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w800,
    height: 1.2,
    color: AppColors.onBackground,
    letterSpacing: -0.5,
  );

  static TextStyle get displayMedium => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.onBackground,
    letterSpacing: -0.3,
  );

  static TextStyle get displaySmall => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.onBackground,
    letterSpacing: -0.2,
  );

  static TextStyle get headlineLarge => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 22.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onSurface,
    letterSpacing: 0,
  );

  static TextStyle get headlineMedium => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onSurface,
    letterSpacing: 0,
  );

  static TextStyle get headlineSmall => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onSurface,
    letterSpacing: 0,
  );

  // Title Text Styles
  static TextStyle get titleLarge => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.onSurface,
    letterSpacing: 0.1,
  );

  static TextStyle get titleMedium => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.onSurface,
    letterSpacing: 0.1,
  );

  static TextStyle get titleSmall => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.2,
  );

  // Body Text Styles - Readable and Clean
  static TextStyle get bodyLarge => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurface,
    letterSpacing: 0.1,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.onSurface,
    letterSpacing: 0.1,
  );

  static TextStyle get bodySmall => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.2,
  );

  // Label Text Styles
  static TextStyle get labelLarge => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.onSurface,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.2,
  );

  static TextStyle get labelSmall => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.3,
  );

  // Email specific text styles
  static TextStyle get emailSubject => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.onSurface,
    letterSpacing: 0,
  );

  static TextStyle get emailSender => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.onSurface,
    letterSpacing: 0.1,
  );

  static TextStyle get emailPreview => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.onSurfaceVariant,
    letterSpacing: 0.1,
  );

  static TextStyle get emailTime => TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.secondary,
    letterSpacing: 0.2,
  );

  static TextStyle get buttonText => TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.onPrimary,
    letterSpacing: 0.2,
  );
}
