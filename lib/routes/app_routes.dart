import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/core/theme/theme_settings_screen.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/user/blood_donation/blood_appeal_screen.dart';
import 'package:kaar_e_kamal/screens/user/blood_donation/blood_donation_history.dart';
import 'package:kaar_e_kamal/screens/user/blood_donation/blood_donation_registration_screen.dart';
import 'package:kaar_e_kamal/screens/user/chatbot/chatbot_interaction_screen.dart';
import 'package:kaar_e_kamal/screens/user/donation/donation_history_screen.dart';
import 'package:kaar_e_kamal/screens/user/donation/donation_management_screen.dart';
import 'package:kaar_e_kamal/screens/user/family_submission/needy_family_submission_screen.dart';
import 'package:kaar_e_kamal/screens/user/home_screen.dart';
import 'package:kaar_e_kamal/screens/user_home2.dart';
import '../screens/home_screen.dart';

class AppRoutes {
  /// Method to get application routes
  static Map<String, WidgetBuilder> getRoutes({
    required ValueChanged<bool> toggleTheme,
    required bool isDarkMode,
  }) {
    return {
      RouteNames.home: (context) => HomeScreen(
            toggleTheme: toggleTheme,
            isDarkMode: isDarkMode,
          ),
      RouteNames.themeSettings: (context) => ThemeSettingsScreen(
            onThemeChange: toggleTheme,
            initialDarkMode: isDarkMode,
          ),
      RouteNames.userHome: (context) =>
          const UserHomeScreen(), // New route for UserHome
      RouteNames.userHome2: (context) =>
          const UserHome2(), // New route for UserHome2
      RouteNames.DonationManagementScreen: (context) =>
          const DonationManagementScreen(), 
      RouteNames.DonationHistoryScreen: (context) =>
          DonationHistoryScreen(), 
      RouteNames.FamilySubmissionForm: (context) =>
          FamilySubmissionForm(), 
      RouteNames.ChatbotInteractionScreen: (context) =>
          ChatbotInteractionScreen(), 
      RouteNames.BloodRequestScreen: (context) =>
          BloodRequestScreen(), 
      RouteNames.BloodDonationRegistrationScreen: (context) =>
          BloodDonationRegistrationScreen(), 
      RouteNames.BloodDonationHistoryScreen: (context) =>
          BloodDonationHistoryScreen(), 
    };
  }
}
