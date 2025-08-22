import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable variables
  final RxBool isPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize any required data
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Email/Password login
  Future<void> loginWithEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // TODO: Implement actual email login logic
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to home on success
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = 'Login failed. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  // Google login
  Future<void> loginWithGoogle() async {
    // try {
    //   isLoading.value = true;
    //   errorMessage.value = '';

    //   // TODO: Implement Google Sign-In
    //   await Future.delayed(const Duration(seconds: 2)); // Simulate API call

    //   // Navigate to compose screen for Google login
    //   Get.offAllNamed('/compose');
    // } catch (e) {
    //   errorMessage.value = 'Google login failed. Please try again.';
    // } finally {
    //   isLoading.value = false;
    // }
  }

  // Microsoft login
  Future<void> loginWithMicrosoft() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // TODO: Implement Microsoft Sign-In
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to Outlook compose screen for Microsoft login
      Get.offAllNamed('/outlook-compose');
    } catch (e) {
      errorMessage.value = 'Microsoft login failed. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to forgot password
  void goToForgotPassword() {
    // TODO: Navigate to forgot password page
    Get.snackbar(
      'Info',
      'Forgot password feature coming soon!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryContainer,
      colorText: AppColors.primary,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.info_outline, color: AppColors.primary),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
    );
  }

  // Navigate to sign up
  void goToSignUp() {
    // TODO: Navigate to sign up page
    Get.snackbar(
      'Info',
      'Sign up feature coming soon!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryContainer,
      colorText: AppColors.primary,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.person_add_outlined, color: AppColors.primary),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
    );
  }

  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
