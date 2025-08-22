import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/theme/app_colors.dart';

final navigatorKey = GlobalKey<NavigatorState>();


// ====== CONFIGURE THESE ======
const String kTenant = '3ad8e0e2-c0eb-476a-a491-5f2dcc629a46'; // or 'YOUR_TENANT_ID' or 'yourtenant.onmicrosoft.com'
const String kClientId = 'c5e2ca32-fd07-4ecc-b994-3ca27dfefd83';
const String kRedirectUri = 'https://login.microsoftonline.com/common/oauth2/nativeclient';
const String kScopes = 'openid profile offline_access User.Read';
// =============================

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
    if(isLoading() || isMicrosoftLoading() || isGoogleLoading()) return;
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Navigate to home on success
      // Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = 'Login failed. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final isGoogleLoading = false.obs;
  // Google login
  Future<void> loginWithGoogle() async {
    if(isLoading() || isMicrosoftLoading() || isGoogleLoading()) return;
    try {
      isGoogleLoading.value = true;
      errorMessage.value = '';

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();
      await googleSignIn.signOut();

      final signInAccount = await googleSignIn.authenticate();

      final authResult = await signInAccount.authorizationClient.authorizeScopes(scopes);

      final String? idToken = signInAccount.authentication.idToken;
      final String accessToken = authResult.accessToken;


      if (idToken == null) {
        throw Exception("Tokens missing from Google sign-in.");
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if(user != null) {
        Get.offAllNamed('/compose');
      } else {
        errorMessage.value = 'Google login failed. Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'Google login failed. Please try again.';
    } finally {
      isGoogleLoading.value = false;
    }
  }

  final isMicrosoftLoading = false.obs;

  // Microsoft login
  Future<void> loginWithMicrosoft() async {
    if(isLoading() || isMicrosoftLoading() || isGoogleLoading()) return;
    try {
      isMicrosoftLoading.value = true;
      errorMessage.value = '';

      await FirebaseAuth.instance.signOut();

      final microsoftProvider = OAuthProvider("microsoft.com");

      // Optional: request additional scopes
      microsoftProvider.addScope('User.Read');
      microsoftProvider.setCustomParameters({
        'tenant': kTenant,
        'prompt': 'login',
      });

      // Sign in interactively
      final userCredential = await FirebaseAuth.instance.signInWithProvider(microsoftProvider);

      // 👇 For mobile you may need signInWithRedirect
      // await FirebaseAuth.instance.signInWithRedirect(microsoftProvider);
      User? user = userCredential.user;
      if(user != null) {
        Get.offAllNamed('/outlook-compose');
      } else {
        errorMessage.value = 'Microsoft login failed. Please try again.';
      }
      // Navigate to Outlook compose screen for Microsoft login
    } catch (e) {
      errorMessage.value = 'Microsoft login failed. Please try again.';
    } finally {
      isMicrosoftLoading.value = false;
    }
  }

  // Navigate to forgot password
  void goToForgotPassword() {
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
