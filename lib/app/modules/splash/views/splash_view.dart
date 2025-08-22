import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.surfaceVariant,
              AppColors.background,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated logo/icon
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: ScaleTransition(
                      scale: controller.scaleAnimation,
                      child: Container(
                        width: 120.w,
                        height: 120.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 20.r,
                              spreadRadius: 5.r,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.email_outlined,
                          size: 60.sp,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 40.h),

              // Animated app name
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return SlideTransition(
                    position: controller.slideAnimation,
                    child: FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Censor Mobile',
                            style: AppTypography.displayMedium.copyWith(
                              letterSpacing: 2.0,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Smart Email Management',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.secondary,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 60.h),

              // Animated loading indicator
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: controller.fadeAnimation,
                    child: SizedBox(
                      width: 50.w,
                      height: 50.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
