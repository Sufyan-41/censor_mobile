// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/core/theme/app_colors.dart';
import '../app/core/theme/app_typography.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final Function? validator;
  final void Function(String?)? saved;
  final void Function(String)? submitted;
  final void Function(String)? onChanged;
  final Function()? onTap;
  final TextEditingController inputController;
  final TextInputType? type;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool secure;
  final IconData? suffixIconData;
  final Widget? suffix;
  final bool readOnly;
  final Function? suffixPress;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Color? bgColor;
  final Color? bdColor;
  final double? bdRadius;
  final Color? suffixColor;
  final Color? prefixColor;
  final Color? hintColor;
  final Color? textColor;
  final IconData? prefixIconData;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? errorStyle;
  final int? maxErrorLines;
  final bool autoValidate;
  final EdgeInsets? contentPadding;
  final Function()? onEditingComplete;

  final String? title;
  final bool titleHasTopPadding;
  final double? titleFontSize;
  final double? titleTopPadding;
  final double? titleBottomPadding;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final TextStyle? titleTextStyle;
  final String? optionalTitle;
  final double? optionalTitleFontSize;
  final Color? optionalTitleColor;
  final FontWeight? optionalTitleFontWeight;
  final TextStyle? optionalTitleTextStyle;
  final bool autoFocus;

  const InputField({
    super.key,
    required this.hintText,
    this.validator,
    required this.inputController,
    this.onEditingComplete,
    this.contentPadding,
    this.inputFormatters,
    this.autoFocus = false,
    this.onTap,
    this.type,
    this.focusNode,
    this.submitted,
    this.saved,
    this.suffixIconData,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxErrorLines = 10,
    this.maxLength,
    this.suffixPress,
    this.onChanged,
    this.bgColor,
    this.bdColor,
    this.bdRadius,
    this.suffixColor,
    this.prefixColor,
    this.hintColor,
    this.textColor,
    this.prefixIconData,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.textInputAction,
    this.errorStyle,
    this.readOnly = false,
    this.autoValidate = true,
    this.titleHasTopPadding = true,
    this.secure = false,
    this.title,
    this.titleFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.titleTextStyle,
    this.optionalTitle,
    this.optionalTitleFontSize,
    this.optionalTitleColor,
    this.optionalTitleFontWeight,
    this.optionalTitleTextStyle,
    this.titleTopPadding,
    this.titleBottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null)
          FieldTitle(
            titleHasTopPadding: titleHasTopPadding,
            title: title,
            titleFontSize: titleFontSize,
            titleColor: titleColor,
            titleFontWeight: titleFontWeight,
            titleTextStyle: titleTextStyle,
            optionalTitle: optionalTitle,
            optionalTitleFontSize: optionalTitleFontSize,
            optionalTitleColor: optionalTitleColor,
            optionalTitleFontWeight: optionalTitleFontWeight,
            optionalTitleTextStyle: optionalTitleTextStyle,
            topPadding: titleTopPadding,
            bottomPadding: titleBottomPadding,
          ),
        TextFormField(
          onTap: onTap,
          canRequestFocus: readOnly ? false : true,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: submitted,
          autofocus: autoFocus,
          onSaved: saved,
          focusNode: focusNode,
          textInputAction: textInputAction ?? TextInputAction.done,
          obscureText: secure,
          readOnly: readOnly,
          keyboardType: type,
          controller: inputController,
          autovalidateMode: autoValidate
              ? AutovalidateMode.onUserInteraction
              : null,
          inputFormatters: [...(inputFormatters ?? [])],
          validator: (value) => validator == null ? null : validator!(value),
          textAlign: TextAlign.start,
          style: AppTypography.bodyMedium.copyWith(
            color: textColor ?? AppColors.onSurface,
            fontWeight: FontWeight.w400,
          ),
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            counterText: '',
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            suffixIcon:
                suffixIcon ??
                (suffixIconData != null
                    ? GestureDetector(
                        onTap: suffixPress as Function()?,
                        child: Icon(
                          suffixIconData,
                          color: suffixColor,
                          size: 16.h,
                        ),
                      )
                    : null),
            prefixIcon:
                prefixIcon ??
                (prefixIconData != null
                    ? Icon(prefixIconData, color: prefixColor, size: 24.h)
                    : null),
            prefix: prefix,
            suffix: suffix,
            fillColor: bgColor ?? AppColors.surfaceVariant,
            filled: true,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: hintColor ?? AppColors.onSurfaceVariant,
            ),
            hintText: hintText.tr,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((bdRadius ?? 8).r),
              borderSide: BorderSide(
                color: bdColor ?? AppColors.outline,
                width: 1.0.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((bdRadius ?? 8).r),
              borderSide: BorderSide(color: AppColors.error, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((bdRadius ?? 8).r),
              borderSide: BorderSide(
                color: bdColor ?? AppColors.primary,
                width: 2.0.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular((bdRadius ?? 8).r),
              borderSide: BorderSide(color: AppColors.error, width: 2.w),
            ),
            errorStyle:
                errorStyle ??
                AppTypography.bodySmall.copyWith(color: AppColors.error),
            errorMaxLines: maxErrorLines,
          ),
        ),
      ],
    );
  }
}

class FieldTitle extends StatelessWidget {
  final bool titleHasTopPadding;
  final String? title;
  final double? titleFontSize;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final TextStyle? titleTextStyle;
  final String? optionalTitle;
  final double? optionalTitleFontSize;
  final Color? optionalTitleColor;
  final FontWeight? optionalTitleFontWeight;
  final TextStyle? optionalTitleTextStyle;
  final double? topPadding;
  final double? bottomPadding;

  const FieldTitle({
    super.key,
    this.titleHasTopPadding = true,
    this.title,
    this.titleFontSize,
    this.titleColor,
    this.titleFontWeight,
    this.titleTextStyle,
    this.optionalTitle,
    this.optionalTitleFontSize,
    this.optionalTitleColor,
    this.optionalTitleFontWeight,
    this.optionalTitleTextStyle,
    this.topPadding,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: titleHasTopPadding ? (topPadding ?? 0) : 0,
        bottom: bottomPadding ?? 8.h,
      ),
      child: Row(
        children: [
          if (title != null)
            Expanded(
              child: Text(
                title!,
                style:
                    titleTextStyle ??
                    AppTypography.labelLarge.copyWith(
                      fontSize: titleFontSize?.sp,
                      color: titleColor ?? AppColors.onSurface,
                      fontWeight: titleFontWeight ?? FontWeight.w500,
                    ),
              ),
            ),
          if (optionalTitle != null)
            Text(
              optionalTitle!,
              style:
                  optionalTitleTextStyle ??
                  AppTypography.labelMedium.copyWith(
                    fontSize: optionalTitleFontSize?.sp,
                    color: optionalTitleColor ?? AppColors.onSurfaceVariant,
                    fontWeight: optionalTitleFontWeight ?? FontWeight.w400,
                  ),
            ),
        ],
      ),
    );
  }
}
