import 'package:censor_mobile/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:open_mail_launcher/open_mail_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ComposeController extends GetxController {
  // Text editing controllers
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isSending = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasUnsavedChanges = false.obs;

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Focus node for body field
  final FocusNode bodyFocusNode = FocusNode();
  final RxBool isBodyFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Set default from email (in real app, get from user session)
    final user = FirebaseAuth.instance.currentUser;
    fromController.text = user?.email ?? '';
    // FirebaseAuth.instance.signOut();
    // toController.text = 'flutter@rapidev.tech';
    // subjectController.text = "Test Subject";
    // bodyController.text = "Test Body lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sit amet odio auctor, porta tellus volutpat, lobortis est. Proin in nunc sollicitudin, varius urna eu, fermentum lectus. Aenean tellus nulla, scelerisque vel euismod sit amet, pretium sed mi. Duis sed imperdiet nisl. Donec quis sem auctor ex rhoncus finibus ac condimentum massa. Cras aliquet erat neque, in lobortis ligula elementum a. Aliquam tempus lectus nec placerat placerat. Mauris porttitor elementum euismod. Suspendisse semper sapien odio. Integer sollicitudin sagittis magna, id bibendum felis molestie id. Integer fermentum nec ligula vitae auctor. Phasellus posuere magna eu dolor iaculis, non finibus elit rhoncus. Sed malesuada, ante sit amet mattis tempus, mi mi malesuada metus, non dapibus ex arcu in lorem.";
    // Listen for changes to track unsaved content
    toController.addListener(_onContentChanged);
    subjectController.addListener(_onContentChanged);
    bodyController.addListener(_onContentChanged);

    // Listen for body field focus changes
    bodyFocusNode.addListener(_onBodyFocusChanged);
  }

  @override
  void onClose() {
    fromController.dispose();
    toController.dispose();
    subjectController.dispose();
    bodyController.dispose();
    bodyFocusNode.dispose();
    super.onClose();
  }

  void _onContentChanged() {
    hasUnsavedChanges.value =
        toController.text.isNotEmpty ||
        subjectController.text.isNotEmpty ||
        bodyController.text.isNotEmpty;
  }

  void _onBodyFocusChanged() {
    isBodyFocused.value = bodyFocusNode.hasFocus;
  }

  Future<bool> launchGmailApp() async {
    final String to = toController.text.trim();
    final String subject = subjectController.text.trim();
    final String body = bodyController.text.trim();

    final emailContent = EmailContent(
      to: [to],
      subject: subject,
      body: body,
      isHtml: false,
    );

    List<MailApp> apps = await OpenMailLauncher.getMailApps();

    MailApp? gmail = apps.firstWhereOrNull((app) => app.name.toLowerCase().contains('gmail'));

    if (gmail != null) {
      bool success = await OpenMailLauncher.openSpecificMailApp(
        mailApp: gmail,
        emailContent: emailContent,
      );
      if(!success) {
        Get.snackbar(
          'Error',
          'Could not launch Gmail app',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.error.withValues(alpha: 0.1),
          colorText: AppColors.error,
          borderRadius: 8,
          margin: const EdgeInsets.all(16),
          icon: const Icon(Icons.error_outline, color: AppColors.error),
          shouldIconPulse: false,
          duration: const Duration(seconds: 3),
        );
        return false;
      } else {
        return true;
      }
    } else {
      Get.snackbar(
        'Error',
        'Gmail app not available on your device',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error.withValues(alpha: 0.1),
        colorText: AppColors.error,
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.error_outline, color: AppColors.error),
        shouldIconPulse: false,
        duration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  // Send email function
  Future<void> sendEmail() async {
    // Check for recipient email
    if (toController.text.trim().isEmpty) {
      _showRecipientRequiredDialog();
      return;
    }

    // Check for valid email format
    if (!GetUtils.isEmail(toController.text.trim())) {
      _showInvalidEmailDialog();
      return;
    }

    try {
      isSending.value = true;
      errorMessage.value = '';

      // TODO: Implement actual email sending logic
      final result = await launchGmailApp(); // Simulate API call

      if(result) {
        // Show success message
        Get.snackbar(
          'Success',
          'Email sent successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColors.success.withValues(alpha: 0.1),
          colorText: AppColors.success,
          borderRadius: 8,
          margin: const EdgeInsets.all(16),
          icon: const Icon(Icons.check_circle_outline, color: AppColors.success),
          shouldIconPulse: false,
          duration: const Duration(seconds: 3),
        );

        // Clear form after successful send
        _clearForm();
      }


      // Navigate back or to inbox
      // Get.back();
    } catch (e) {
      errorMessage.value = 'Failed to send email. Please try again.';
      Get.snackbar(
        'Error',
        'Failed to send email. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error.withValues(alpha: 0.1),
        colorText: AppColors.error,
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.error_outline, color: AppColors.error),
        shouldIconPulse: false,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isSending.value = false;
    }
  }

  void _showRecipientRequiredDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Add Recipient', style: AppTypography.titleLarge),
        content: Text(
          'Add at least one recipient.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'OK',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showInvalidEmailDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Invalid Email', style: AppTypography.titleLarge),
        content: Text(
          'Please enter a valid email address.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'OK',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Save as draft
  Future<void> saveDraft() async {
    try {
      isLoading.value = true;

      // TODO: Implement actual draft saving logic
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      Get.snackbar(
        'Saved',
        'Email saved as draft',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primaryContainer,
        colorText: AppColors.primary,
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.save_outlined, color: AppColors.primary),
        shouldIconPulse: false,
        duration: const Duration(seconds: 2),
      );

      hasUnsavedChanges.value = false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save draft',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.error.withValues(alpha: 0.1),
        colorText: AppColors.error,
        borderRadius: 8,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.error_outline, color: AppColors.error),
        shouldIconPulse: false,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate back with unsaved changes check
  void handleBackPress() {
    if (hasUnsavedChanges.value) {
      _showUnsavedChangesDialog();
    } else {
      Get.back();
    }
  }

  void _showUnsavedChangesDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Unsaved Changes'),
        content: const Text(
          'You have unsaved changes. What would you like to do?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              _clearForm();
              Get.back(); // Go back to previous screen
            },
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              saveDraft();
            },
            child: const Text('Save Draft'),
          ),
          TextButton(
            onPressed: () => Get.back(), // Just close dialog
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _clearForm() {
    toController.clear();
    subjectController.clear();
    bodyController.clear();
    hasUnsavedChanges.value = false;
    errorMessage.value = '';
  }

  // Add attachment (placeholder)
  void addAttachment() {
    Get.snackbar(
      'Info',
      'Attachment feature coming soon!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryContainer,
      colorText: AppColors.primary,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.attach_file_outlined, color: AppColors.primary),
      shouldIconPulse: false,
      duration: const Duration(seconds: 2),
    );
  }

  // Schedule email (placeholder)
  void scheduleEmail() {
    Get.snackbar(
      'Info',
      'Schedule feature coming soon!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryContainer,
      colorText: AppColors.primary,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      icon: const Icon(Icons.schedule_outlined, color: AppColors.primary),
      shouldIconPulse: false,
      duration: const Duration(seconds: 2),
    );
  }

  // Validation functions
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter recipient email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email subject';
    }
    return null;
  }

  String? validateBody(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email content';
    }
    return null;
  }

  // Clear error message
  void clearError() {
    errorMessage.value = '';
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.signOut();
    Get.offAndToNamed(Routes.SPLASH);
  }
}
