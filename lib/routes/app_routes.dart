import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/core/theme/theme_settings_screen.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/SendToContantLeader/ContentVolunteerToLeaderRequestScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/communication/ContentVolunteerCommunicationScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/content_team_volunteer_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/content_team_volunteer_task_screen/ContentTeamVolunteerTaskScreen.dart';
import 'package:kaar_e_kamal/screens/common/auth/login.dart';
import 'package:kaar_e_kamal/screens/common/auth/signup.dart';
import 'package:kaar_e_kamal/screens/common/profile/user_profile_screen.dart';
import 'package:kaar_e_kamal/screens/drawer/mainDrawer.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/add_remove_members/content_team_leader_add_remove_members.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/communication/president_communication_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/send_to_president/content_team_leader_approval_request_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/content_team_leader_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/content_tools/content_team_leader_content_editor_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/task_assignment/content_team_leader_assign_task_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/task_dashboard/content_team_leader_task_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/team_availability/content_team_leader_member_availability_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/GraphicsTeamLeaderDashboardScreen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/task_assignment/GraphicsTeamLeaderAssignTaskScreen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/task_dashboard/graphics_team_leader_task_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/president/communication/president_communication_screen.dart';
import 'package:kaar_e_kamal/screens/president/documentation_compliance/compliance_screen.dart';
import 'package:kaar_e_kamal/screens/president/documentation_compliance/maintain_documentation_screen.dart';
import 'package:kaar_e_kamal/screens/president/events_activity/president_event_managment_screen.dart';
import 'package:kaar_e_kamal/screens/president/member_engagement/encourage_volunteers_screen.dart';
import 'package:kaar_e_kamal/screens/president/president_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/president/progress_monitoring/feedback_screen.dart';
import 'package:kaar_e_kamal/screens/president/progress_monitoring/team_progress_screen.dart';
import 'package:kaar_e_kamal/screens/president/reports/activity_level_report_screen.dart';
import 'package:kaar_e_kamal/screens/president/reports/chapter_performance_report_screen.dart';
import 'package:kaar_e_kamal/screens/president/reports/donation_report_screen.dart';
import 'package:kaar_e_kamal/screens/president/reports/volunteer_engagement_report_screen.dart';
import 'package:kaar_e_kamal/screens/president/resource_management/manage_resources_screen.dart';
import 'package:kaar_e_kamal/screens/president/super_admin_collaboration/super_admin_president_chat_screen.dart';
import 'package:kaar_e_kamal/screens/president/task_management/task_details_screen.dart';
import 'package:kaar_e_kamal/screens/president/task_management/task_management_screen.dart';
import 'package:kaar_e_kamal/screens/president/team_management/team_managment_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/access_control/access_control.dart';
import 'package:kaar_e_kamal/screens/superAdmin/chapter_management/assign_position_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/chapter_management/chapter_list_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/chapter_management/chapter_management_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/chapter_management/create_chapter_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/communication/announcements_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/communication/communication_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/emergency_management/emergency_protocols_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/events_campaigns/create_event_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/financial_oversight/financial_reports_screen.dart';
import 'package:kaar_e_kamal/screens/superAdmin/reporting_analytics/reports_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/user/blood_donation/blood_appeal_screen.dart';
import 'package:kaar_e_kamal/screens/user/blood_donation/blood_donation_history.dart';
import 'package:kaar_e_kamal/screens/user/blood_donation/blood_donation_registration_screen.dart';
import 'package:kaar_e_kamal/screens/user/chatbot/chatbot_interaction_screen.dart';
import 'package:kaar_e_kamal/screens/user/donation/donation_history_screen.dart';
import 'package:kaar_e_kamal/screens/user/donation/donation_management_screen.dart';
import 'package:kaar_e_kamal/screens/user/family_submission/needy_family_submission_screen.dart';
import 'package:kaar_e_kamal/screens/user/gamification/gamification_screen.dart';
import 'package:kaar_e_kamal/screens/user/home_screen.dart';
import 'package:kaar_e_kamal/screens/user/home_screen2.dart';
import 'package:kaar_e_kamal/screens/user/social_engagement/post_sharing_screen.dart';
import 'package:kaar_e_kamal/screens/user/transparency/transparency_screen.dart';
import 'package:kaar_e_kamal/widgets/president/dashboard/president_dashboard_widget.dart';
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
    //auth 
        RouteNames.LoginScreen: (context) => const LoginScreen(),
        RouteNames.SignUpScreen: (context) => const SignUpScreen(),
   
    //user
      RouteNames.userHome: (context) =>
          const UserHomeScreen(), // New route for UserHome
      RouteNames.UserHomeScreen2: (context) =>
          const UserHomeScreen2(), // New route for UserHome
      RouteNames.DonationManagementScreen: (context) =>
          const DonationManagementScreen(),
      RouteNames.DonationHistoryScreen: (context) => DonationHistoryScreen(),
      RouteNames.FamilySubmissionForm: (context) => FamilySubmissionForm(),
      RouteNames.ChatbotInteractionScreen: (context) =>
          ChatbotInteractionScreen(),
      RouteNames.BloodRequestScreen: (context) => BloodRequestScreen(),
      RouteNames.BloodDonationRegistrationScreen: (context) =>
          BloodDonationRegistrationScreen(),
      RouteNames.BloodDonationHistoryScreen: (context) =>
          BloodDonationHistoryScreen(),
      RouteNames.GamificationScreen: (context) => GamificationScreen(),
      RouteNames.TransparencyScreen: (context) => TransparencyScreen(),
      RouteNames.PostSharingScreen: (context) => PostSharingScreen(),
      //profile
      RouteNames.UserProfileScreen: (context) => UserProfileScreen(
            imgPath:
                'assets/pics/DP.jpg', // Replace with actual value or variable
            userId: 'DEV910', // Replace with actual value or variable
            userName: 'M Saqib', // Replace with actual value or variable
            userEmail:
                'Msaqibsharif430.com', // Replace with actual value or variable
            userPhone: '030-84075-256', // Replace with actual value or variable
            userType: 'Leader', // Replace with actual value or variable
          ),

      //Super Admin Routes
      //Dashboard
      RouteNames.dashboard: (context) => const DashboardScreen(),
      // Chapter Management
      RouteNames.createChapter: (context) => CreateChapterScreen(),
      RouteNames.AssignPositionScreen: (context) => AssignPositionScreen(),
      RouteNames.chapterList: (context) => ChapterListScreen(),
      RouteNames.ChapterManagementScreen: (context) =>
          ChapterManagementScreen(),
      RouteNames.AccessControlScreen: (context) => AccessControlScreen(),
      RouteNames.CommunicationScreen: (context) => CommunicationScreen(),
      RouteNames.AnnouncementsScreen: (context) => AnnouncementsScreen(),
      RouteNames.FinancialReportsScreen: (context) => FinancialReportsScreen(),
      RouteNames.ReportsDashboardScreen: (context) => ReportsDashboardScreen(),
      RouteNames.CreateEventScreen: (context) => CreateEventScreen(),
      RouteNames.EmergencyProtocolsScreen: (context) =>
          EmergencyProtocolsScreen(),

      //president routes
      RouteNames.PresidentDashboardScreen: (context) =>
          PresidentDashboardScreen(),
      RouteNames.TeamManagmentScreen: (context) => TeamManagmentScreen(),
      RouteNames.ChapterPerformanceReportScreen: (context) =>
          ChapterPerformanceReportScreen(),
      RouteNames.DonationReportScreen: (context) => DonationReportScreen(),
      RouteNames.ActivityLevelReportScreen: (context) =>
          ActivityLevelReportScreen(),
      RouteNames.VolunteerEngagementReportScreen: (context) =>
          VolunteerEngagementReportScreen(),
      RouteNames.TaskManagementScreen: (context) => TaskManagementScreen(),
      RouteNames.TaskDetailsScreen: (context) => TaskDetailsScreen(),
      RouteNames.TeamProgressScreen: (context) => TeamProgressScreen(),
      RouteNames.PresidentCommunicationScreen: (context) =>
          PresidentCommunicationScreen(),
      RouteNames.PresidentEventManagementScreen: (context) =>
          PresidentEventManagementScreen(),
      RouteNames.EncourageVolunteersScreen: (context) =>
          EncourageVolunteersScreen(),
      RouteNames.ManageResourcesScreen: (context) => ManageResourcesScreen(),
      RouteNames.SuperAdminPresidentChatScreen: (context) => SuperAdminPresidentChatScreen(),
      RouteNames.MaintainDocumentationScreen: (context) => MaintainDocumentationScreen(),
      RouteNames.ComplianceScreen: (context) => ComplianceScreen(),


      //Content Team Leader Routes
      RouteNames.ContentTeamLeaderDashboardScreen: (context) =>
          const ContentTeamLeaderDashboardScreen(),
      RouteNames.ContentTeamLeaderTaskDashboardScreen: (context) => ContentTeamLeaderTaskDashboardScreen(),
      RouteNames.ContentTeamLeaderAssignTaskScreen: (context) => ContentTeamLeaderAssignTaskScreen(),
      RouteNames.ContentTeamLeaderMemberAvailabilityScreen: (context) => ContentTeamLeaderMemberAvailabilityScreen(),
      RouteNames.ContentTeamLeaderContentEditorScreen: (context) => ContentTeamLeaderContentEditorScreen(),
      RouteNames.ContentToPresidentRequestScreen: (context) => ContentToPresidentRequestScreen(),
      RouteNames.ContentTeamLeaderAddRemoveMembersScreen: (context) => ContentTeamLeaderAddRemoveMembersScreen(),
      RouteNames.ContentTeamLeaderCommunicationScreen: (context) => ContentTeamLeaderCommunicationScreen(),

      //Content Team Volunteer Routes
      RouteNames.ContentTeamVolunteerDashboardScreen: (context) => ContentTeamVolunteerDashboardScreen(),
      RouteNames.ContentTeamVolunteerTaskScreen: (context) => ContentTeamVolunteerTaskScreen(),
      RouteNames.ContentVolunteerToLeaderRequestScreen: (context) => ContentVolunteerToLeaderRequestScreen(),
      RouteNames.ContentVolunteerCommunicationScreen: (context) => ContentVolunteerCommunicationScreen(),

      //Graphics Team Leader Routes
      RouteNames.GraphicsTeamLeaderDashboardScreen: (context) => const GraphicsTeamLeaderDashboardScreen(),
      RouteNames.GraphicsTeamLeaderTaskDashboardScreen: (context) => const GraphicsTeamLeaderTaskDashboardScreen(),
      RouteNames.GraphicsTeamLeaderAssignTaskScreen: (context) => const GraphicsTeamLeaderAssignTaskScreen(),
    };
  }
}

