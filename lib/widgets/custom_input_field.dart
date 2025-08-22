import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app/core/theme/app_colors.dart';
import '../app/core/theme/app_typography.dart';

class CustomInputField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? trailingWidget;
  final bool showLabel;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final TextAlignVertical? textAlignVertical;
  final double? labelWidth;
  final bool isComposeField;

  const CustomInputField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.validator,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.prefixIcon,
    this.suffixIcon,
    this.trailingWidget,
    this.showLabel = true,
    this.isDense = false,
    this.contentPadding,
    this.border,
    this.fillColor,
    this.filled = true,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.textAlignVertical,
    this.labelWidth,
    this.isComposeField = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isComposeField) {
      return _buildComposeField();
    }

    return _buildStandardField();
  }

  Widget _buildStandardField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && label != null) ...[
          Text(label!, style: labelStyle ?? AppTypography.labelLarge),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          validator: validator,
          onTap: onTap,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          focusNode: focusNode,
          textAlignVertical: textAlignVertical,
          style: textStyle ?? AppTypography.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                hintStyle ??
                AppTypography.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: filled,
            fillColor: fillColor ?? AppColors.surfaceVariant,
            contentPadding:
                contentPadding ??
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            border:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.outline,
                    width: 1,
                  ),
                ),
            enabledBorder:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.outline,
                    width: 1,
                  ),
                ),
            focusedBorder:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
            errorBorder:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 1,
                  ),
                ),
            focusedErrorBorder:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(
                    color: AppColors.error,
                    width: 2,
                  ),
                ),
            isDense: isDense,
          ),
        ),
      ],
    );
  }

  Widget _buildComposeField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          if (label != null)
            SizedBox(
              width: labelWidth ?? 60.w,
              child: Text(
                label!,
                style:
                    labelStyle ??
                    AppTypography.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
              ),
            ),
          Expanded(
            child: readOnly
                ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller?.text ?? '',
                          style: textStyle ?? AppTypography.bodyMedium,
                        ),
                      ),
                      if (trailingWidget != null) trailingWidget!,
                    ],
                  )
                : TextFormField(
                    controller: controller,
                    validator: validator,
                    onTap: onTap,
                    onChanged: onChanged,
                    onEditingComplete: onEditingComplete,
                    onFieldSubmitted: onFieldSubmitted,
                    keyboardType: keyboardType,
                    textInputAction: textInputAction,
                    obscureText: obscureText,
                    readOnly: readOnly,
                    enabled: enabled,
                    maxLines: maxLines,
                    minLines: minLines,
                    expands: expands,
                    focusNode: focusNode,
                    textAlignVertical: textAlignVertical,
                    style: textStyle ?? AppTypography.bodyMedium,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle:
                          hintStyle ??
                          AppTypography.bodyMedium.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      prefixIcon: prefixIcon,
                      suffixIcon: suffixIcon,
                    ),
                  ),
          ),
          if (!readOnly && trailingWidget != null) trailingWidget!,
        ],
      ),
    );
  }
}

// Specialized widgets for common use cases
class EmailInputField extends CustomInputField {
  const EmailInputField({
    super.key,
    required super.controller,
    super.validator,
    super.onChanged,
    super.onFieldSubmitted,
    super.label = 'Email',
    super.hintText = 'Enter your email address',
    super.keyboardType = TextInputType.emailAddress,
    super.textInputAction = TextInputAction.next,
    Widget? prefixIcon,
  }) : super(
         prefixIcon:
             prefixIcon ??
             const Icon(
               Icons.email_outlined,
               color: AppColors.onSurfaceVariant,
             ),
       );
}

class PasswordInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final String? label;
  final String? hintText;
  final TextInputAction? textInputAction;

  const PasswordInputField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.label = 'Password',
    this.hintText = 'Enter your password',
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      label: widget.label,
      hintText: widget.hintText,
      textInputAction: widget.textInputAction,
      obscureText: !_isPasswordVisible,
      prefixIcon: const Icon(
        Icons.lock_outline,
        color: AppColors.onSurfaceVariant,
      ),
      suffixIcon: IconButton(
        onPressed: _togglePasswordVisibility,
        icon: Icon(
          _isPasswordVisible
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class ComposeInputField extends CustomInputField {
  const ComposeInputField({
    super.key,
    required super.label,
    super.controller,
    super.validator,
    super.onChanged,
    super.onFieldSubmitted,
    super.hintText,
    super.keyboardType,
    super.textInputAction,
    super.readOnly = false,
    super.trailingWidget,
    super.labelWidth,
    super.maxLines = 1,
    super.expands = false,
    super.textAlignVertical,
  }) : super(isComposeField: true, showLabel: false);
}
