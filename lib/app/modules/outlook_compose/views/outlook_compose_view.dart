import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../../widgets/input_feild.dart';
import '../controllers/outlook_compose_controller.dart';

class OutlookComposeView extends GetView<OutlookComposeController> {
  const OutlookComposeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          controller.handleBackPress();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: _buildAppBar(),
        body: _buildBody(),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0078D4), // Microsoft blue
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: controller.handleBackPress,
        icon: const Icon(Icons.close, color: Colors.white),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New message',
            style: AppTypography.titleMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            controller.fromController.text,
            style: AppTypography.bodySmall.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
      actions: [
        Obx(
          () => controller.isSending.value
              ? Padding(
                  padding: EdgeInsets.all(12.w),
                  child: SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: controller.logout,
                  icon: Icon(Icons.remove, color: Colors.white, size: 24.sp),
                ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        // Email fields section
        Container(
          color: AppColors.surface,
          child: Column(
            children: [
              // To field
              _buildToField(),

              Divider(height: 1, color: AppColors.outline),

              // Subject field
              _buildSubjectField(),
              Divider(height: 1, color: AppColors.outline),
            ],
          ),
        ),

        // Compose body section
        Expanded(child: _buildComposeBody()),
      ],
    );
  }

  Widget _buildToField() {
    return Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              'To',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: InputField(
              hintText: '',
              inputController: controller.toController,
              type: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onChanged: (_) => controller.clearError(),
              bgColor: Colors.transparent,
              bdColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              autoValidate: false,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 20.sp,
            color: AppColors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectField() {
    return Container(
      height: 54.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              'Subject',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: InputField(
              hintText: '',
              inputController: controller.subjectController,
              textInputAction: TextInputAction.next,
              onChanged: (_) => controller.clearError(),
              bgColor: Colors.transparent,
              bdColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              autoValidate: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComposeBody() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Outlook for Android link
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'Get ',
          //         style: AppTypography.bodyMedium.copyWith(
          //           color: AppColors.onSurface,
          //         ),
          //       ),
          //       TextSpan(
          //         text: 'Outlook for Android',
          //         style: AppTypography.bodyMedium.copyWith(
          //           color: const Color(0xFF0078D4),
          //           decoration: TextDecoration.underline,
          //           decorationColor: const Color(0xFF0078D4),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 24.h),

          // Compose text area
          Expanded(
            child: InputField(
              hintText: '',
              inputController: controller.bodyController,
              focusNode: controller.bodyFocusNode,
              maxLines: null,
              onChanged: (_) => controller.clearError(),
              bgColor: Colors.transparent,
              bdColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              autoValidate: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 60.h,
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.outline, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomBarIcon(
            icon: Icons.add_circle,
            color: const Color(0xFF0078D4),
            onTap: () {},
          ),
          _buildBottomBarIcon(
            icon: Icons.attach_file,
            color: AppColors.onSurfaceVariant,
            onTap: controller.addAttachment,
          ),
          _buildBottomBarIcon(
            icon: Icons.photo_camera_outlined,
            color: AppColors.onSurfaceVariant,
            onTap: () {},
          ),
          _buildBottomBarIcon(
            icon: Icons.gesture,
            color: AppColors.onSurfaceVariant,
            onTap: () {},
          ),
          _buildBottomBarIcon(
            icon: Icons.table_chart_outlined,
            color: AppColors.onSurfaceVariant,
            onTap: () {},
          ),
          _buildBottomBarIcon(
            icon: Icons.text_fields,
            color: AppColors.onSurfaceVariant,
            onTap: () {},
          ),
          _buildBottomBarIcon(
            icon: Icons.more_horiz,
            color: AppColors.onSurfaceVariant,
            onTap: () {},
          ),
          _buildBottomBarIcon(
            icon: Icons.send,
            color: AppColors.onSurfaceVariant,
            onTap: controller.sendEmail,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        child: Icon(icon, size: 24.sp, color: color),
      ),
    );
  }
}
