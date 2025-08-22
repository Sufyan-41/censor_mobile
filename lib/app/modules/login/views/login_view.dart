import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../../widgets/input_feild.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),

                // Header Section
                _buildHeader(),

                SizedBox(height: 48.h),

                // Email Field
                _buildEmailField(),

                SizedBox(height: 16.h),

                // Password Field
                _buildPasswordField(),

                SizedBox(height: 12.h),

                // Remember Me & Forgot Password
                _buildRememberMeRow(),

                SizedBox(height: 32.h),

                // Login Button
                _buildLoginButton(),

                SizedBox(height: 24.h),

                // Error Message
                _buildErrorMessage(),

                SizedBox(height: 32.h),

                // Divider with "OR"
                _buildDivider(),

                SizedBox(height: 32.h),

                // Social Login Buttons
                _buildSocialLoginButtons(),

                SizedBox(height: 48.h),

                // Sign Up Link
                _buildSignUpLink(),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Logo
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Icon(
            Icons.email_outlined,
            size: 32.sp,
            color: AppColors.onPrimary,
          ),
        ),

        SizedBox(height: 24.h),

        // Welcome Text
        Text('Welcome back', style: AppTypography.displaySmall),

        SizedBox(height: 8.h),

        Text(
          'Sign in to access your email account and stay connected',
          style: AppTypography.bodyLarge.copyWith(color: AppColors.secondary),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return InputField(
      title: 'Email',
      hintText: 'Enter your email address',
      inputController: controller.emailController,
      type: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: controller.validateEmail,
      onChanged: (_) => controller.clearError(),
      prefixIconData: Icons.email_outlined,
      prefixColor: AppColors.onSurfaceVariant,
    );
  }

  Widget _buildPasswordField() {
    return Obx(
      () => InputField(
        title: 'Password',
        hintText: 'Enter your password',
        inputController: controller.passwordController,
        textInputAction: TextInputAction.done,
        validator: controller.validatePassword,
        onChanged: (_) => controller.clearError(),
        submitted: (_) => controller.loginWithEmail(),
        secure: !controller.isPasswordVisible.value,
        prefixIconData: Icons.lock_outline,
        prefixColor: AppColors.onSurfaceVariant,
        suffixIconData: controller.isPasswordVisible.value
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        suffixColor: AppColors.onSurfaceVariant,
        suffixPress: controller.togglePasswordVisibility,
      ),
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.rememberMe.value,
            onChanged: controller.toggleRememberMe,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Text('Remember me', style: AppTypography.bodyMedium),
        const Spacer(),
        TextButton(
          onPressed: controller.goToForgotPassword,
          child: Text(
            'Forgot password?',
            style: AppTypography.labelMedium.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.loginWithEmail,
          child: controller.isLoading.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.onPrimary,
                    ),
                  ),
                )
              : Text('Sign In'),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Obx(
      () => controller.errorMessage.value.isNotEmpty
          ? Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 16.sp,
                    color: AppColors.error,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      controller.errorMessage.value,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.outline)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'OR',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.outline)),
      ],
    );
  }

  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        // Google Login Button
        _buildSocialButton(
          label: 'Continue with Google',
          icon:
              Icons.g_mobiledata, // You might want to use a custom Google icon
          onPressed: controller.loginWithGoogle,
          backgroundColor: AppColors.surface,
          textColor: AppColors.onSurface,
          borderColor: AppColors.outline,
        ),

        SizedBox(height: 16.h),

        // Microsoft Login Button
        _buildSocialButton(
          label: 'Continue with Microsoft',
          icon: Icons.business, // You might want to use a custom Microsoft icon
          onPressed: controller.loginWithMicrosoft,
          backgroundColor: const Color(0xFF0078D4), // Microsoft blue
          textColor: Colors.white,
          borderColor: const Color(0xFF0078D4),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 48.h,
        child: OutlinedButton(
          onPressed: controller.isLoading.value ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            side: BorderSide(color: borderColor, width: 1),
          ),
          child: controller.isLoading.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20.sp, color: textColor),
                    SizedBox(width: 12.w),
                    Text(
                      label,
                      style: AppTypography.labelLarge.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: controller.goToSignUp,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Sign up',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
