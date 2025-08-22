import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void onInit() {
    super.onInit();

    // Initialize animation controller
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Fade animation
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Scale animation
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Slide animation
    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOutBack),
          ),
        );

    // Start animations
    startAnimations();
  }

  void startAnimations() async {
    await animationController.forward();

    // Navigate to home after animation completes
    final user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      debugPrint("Logged in user");
      for (final userInfo in user.providerData) {
        debugPrint("Provider ID: ${userInfo.providerId}");
      }

      // Example: check the first provider
      final providerId = user.providerData.isNotEmpty ? user.providerData.first.providerId : null;

      switch (providerId) {
        case 'google.com':
          debugPrint("User logged in with Google");
          Get.offAllNamed('/compose');
          break;
        case 'microsoft.com':
          Get.offAllNamed('/outlook-compose');
          debugPrint("User logged in with Microsoft");
          break;
        case 'apple.com':
          debugPrint("User logged in with Apple");
          break;
        case 'password':
          debugPrint("User logged in with Email/Password");
          break;
        default:
          debugPrint("Other login provider: $providerId");
      }
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
