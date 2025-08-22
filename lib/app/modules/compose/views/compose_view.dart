import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../../widgets/input_feild.dart';
import '../controllers/compose_controller.dart';

class ComposeView extends GetView<ComposeController> {
  const ComposeView({super.key});

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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      // title: Text('Compose', style: AppTypography.titleLarge),
      leading: IconButton(
        onPressed: controller.handleBackPress,
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        // Attachment button
        IconButton(
          onPressed: controller.addAttachment,
          icon: const Icon(Icons.attachment),
        ),

        // Schedule button
        IconButton(
          onPressed: controller.sendEmail,
          icon: const Icon(Icons.send_outlined),
        ),

        // Send button
        Obx(
          () => Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: controller.isSending.value
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  )
                : IconButton(
                    onPressed: controller.sendEmail,
                    icon: const Icon(Icons.more_vert),
                    // style: IconButton.styleFrom(
                    //   backgroundColor: AppColors.primary,
                    //   foregroundColor: AppColors.onPrimary,
                    // ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          // Email fields section
          Container(
            color: AppColors.surface,
            child: Column(
              children: [
                // From field
                _buildFromField(),

                Divider(height: 1, color: AppColors.outline),

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
      ),
    );
  }

  Widget _buildFromField() {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              'From',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              controller.fromController.text,
              style: AppTypography.bodyMedium,
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

  Widget _buildToField() {
    return Container(
      height: 48.h,
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
      height: 48.h,
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
          Obx(
            () => AnimatedOpacity(
              opacity:
                  controller.isBodyFocused.value ||
                      controller.bodyController.text.isNotEmpty
                  ? 0.0
                  : 1.0,
              duration: const Duration(milliseconds: 300),
              child:
                  controller.isBodyFocused.value ||
                      controller.bodyController.text.isNotEmpty
                  ? SizedBox(height: 0)
                  : Text(
                      'Compose email',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
          Obx(
            () => SizedBox(
              height:
                  controller.isBodyFocused.value ||
                      controller.bodyController.text.isNotEmpty
                  ? 0.h
                  : 16.h,
            ),
          ),
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
}
