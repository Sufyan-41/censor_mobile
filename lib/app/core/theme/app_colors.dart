import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Professional email app palette
  static const Color primary = Color(0xFF2563EB); // Modern blue
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryContainer = Color(0xFFEFF6FF);

  // Secondary Colors
  static const Color secondary = Color(0xFF6B7280);
  static const Color secondaryLight = Color(0xFF9CA3AF);
  static const Color secondaryDark = Color(0xFF4B5563);

  // Background Colors - Light theme
  static const Color background = Color(0xFFFCFCFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  static const Color surfaceContainer = Color(0xFFF1F5F9);

  // Text Colors
  static const Color onBackground = Color(0xFF0F172A);
  static const Color onSurface = Color(0xFF1E293B);
  static const Color onSurfaceVariant = Color(0xFF475569);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Status Colors - Minimal and professional
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors
  static const Color outline = Color(0xFFE2E8F0);
  static const Color outlineVariant = Color(0xFFF1F5F9);
  static const Color shadow = Color(0x1A000000);
  static const Color scrim = Color(0x80000000);

  // Email specific colors
  static const Color unreadEmail = Color(0xFFEFF6FF);
  static const Color readEmail = Colors.transparent;
  static const Color emailBorder = Color(0xFFE2E8F0);
  static const Color attachmentIcon = Color(0xFF6B7280);
}
