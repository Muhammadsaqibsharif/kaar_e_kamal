import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/core/theme/theme_settings_screen.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/SendToContantLeader/ContentVolunteerToLeaderRequestScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/communication/ContentVolunteerCommunicationScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/content_team_leaderboard/content_team_leaderboard.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/content_team_volunteer_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/content_team_%20Volunteer/content_team_volunteer_task_screen/ContentTeamVolunteerTaskScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/graphics_team_%20Volunteer/SendToGraphicsLeader/GraphicsVolunteerToLeaderRequestScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/graphics_team_%20Volunteer/communication/GraphicsVolunteerCommunicationScreen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/graphics_team_%20Volunteer/graphics_team_leaderboard/content_team_leaderboard.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/graphics_team_%20Volunteer/graphics_team_volunteer_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/Teams_%20volunteers/graphics_team_%20Volunteer/graphics_team_volunteer_task_screen/GraphicsTeamVolunteerTaskScreen.dart';
import 'package:kaar_e_kamal/screens/common/auth/login.dart';
import 'package:kaar_e_kamal/screens/common/auth/signup.dart';
import 'package:kaar_e_kamal/screens/common/notifications/notifications_page.dart';
import 'package:kaar_e_kamal/screens/common/profile/user_profile_screen.dart';
import 'package:kaar_e_kamal/screens/drawer/mainDrawer.dart';
import 'package:kaar_e_kamal/screens/common/add_remove_members/common_team_leader_add_remove_members.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/communication/content_leader_communication_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/send_to_president/content_team_leader_approval_request_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/content_team_leader_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/content_tools/content_team_leader_content_editor_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/task_assignment/content_team_leader_assign_task_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/task_dashboard/content_team_leader_task_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/team_availability/content_team_leader_member_availability_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/content_team/team_performance/content_team_performance.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/GraphicsTeamLeaderDashboardScreen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/add_remove_members/graphics_team_leader_add_remove_members.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/communication/graphics_leader_communication_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/graphics_editor/GraphicsTeamLeaderEditorScreen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/send_to_president/graphics_team_leader_approval_request_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/task_assignment/GraphicsTeamLeaderAssignTaskScreen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/task_dashboard/graphics_team_leader_task_dashboard_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/team_availability/graphics_team_leader_member_availability_screen.dart';
import 'package:kaar_e_kamal/screens/leaders/graphics_team/team_performance/graphics_team_performance.dart';
import 'package:kaar_e_kamal/screens/president/communication/president_communication_screen.dart';
import 'package:kaar_e_kamal/screens/president/documentation_compliance/compliance_screen.dart';
import 'package:kaar_e_kamal/screens/president/documentation_compliance/maintain_documentation_screen.dart';
import 'package:kaar_e_kamal/screens/president/events_activity/president_event_managment_screen.dart';
import 'package:kaar_e_kamal/screens/president/member_engagement/encourage_volunteers_screen.dart';
import 'package:kaar_e_kamal/screens/president/post_page/PresidentPostPage.dart';
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
import 'package:kaar_e_kamal/screens/user/become_volunteer/become_volunteer.dart';
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
import 'package:kaar_e_kamal/screens/user/live_cases/case_donation_screen.dart';
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

      // NotificationsPage
      RouteNames.NotificationsPageRoute: (context) => const NotificationsPage(),


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
      RouteNames.UserLeaderboard: (context) => UserLeaderboard(),
      RouteNames.TransparencyScreen: (context) => TransparencyScreen(),
      RouteNames.PostSharingScreen: (context) => PostSharingScreen(),
      RouteNames.CaseDonationScreen: (context) => CaseDonationScreen(),
      //profile
      RouteNames.UserProfileScreen: (context) => UserProfileScreen(),
      RouteNames.BecomeVolunteerScreen: (context) => BecomeVolunteerScreen(),

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
      RouteNames.TeamManagmentScreen: (context) => TeamManagementScreen(),
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
      RouteNames.SuperAdminPresidentChatScreen: (context) =>
          SuperAdminPresidentChatScreen(),
      RouteNames.MaintainDocumentationScreen: (context) =>
          MaintainDocumentationScreen(),
      RouteNames.ComplianceScreen: (context) => ComplianceScreen(),
      RouteNames.PresidentPostPageRoute: (context) => PresidentPostPage(),

      //Content Team Leader Routes
      RouteNames.ContentTeamLeaderDashboardScreen: (context) =>
          const ContentTeamLeaderDashboardScreen(),
      RouteNames.ContentTeamLeaderTaskDashboardScreen: (context) =>
          ContentTeamLeaderTaskDashboardScreen(),
      RouteNames.ContentTeamLeaderAssignTaskScreen: (context) =>
          ContentTeamLeaderAssignTaskScreen(),
      RouteNames.ContentTeamLeaderMemberAvailabilityScreen: (context) =>
          ContentTeamLeaderMemberAvailabilityScreen(),
      RouteNames.ContentTeamLeaderContentEditorScreen: (context) =>
          ContentTeamLeaderContentEditorScreen(),
      RouteNames.ContentToPresidentRequestScreen: (context) =>
          ContentToPresidentRequestScreen(),
      // RouteNames.ContentTeamLeaderAddRemoveMembersScreen: (context) =>
      //     ContentTeamLeaderAddRemoveMembersScreen(),
      RouteNames.ContentTeamLeaderCommunicationScreen: (context) =>
          ContentTeamLeaderCommunicationScreen(),
      RouteNames.ContentTeamLeaderPerformanceScreen: (context) =>
          ContentTeamLeaderPerformanceScreen(),

      //Content Team Volunteer Routes
      RouteNames.ContentTeamVolunteerDashboardScreen: (context) =>
          ContentTeamVolunteerDashboardScreen(),
      RouteNames.ContentTeamVolunteerTaskScreen: (context) =>
          ContentTeamVolunteerTaskScreen(),
      RouteNames.ContentVolunteerToLeaderRequestScreen: (context) =>
          ContentVolunteerToLeaderRequestScreen(),
      RouteNames.ContentVolunteerCommunicationScreen: (context) =>
          ContentVolunteerCommunicationScreen(),
      RouteNames.ContentVolunteerLeaderboardScreen: (context) =>
          ContentVolunteerLeaderboardScreen(),

      //Graphics Team Leader Routes
      RouteNames.GraphicsTeamLeaderDashboardScreen: (context) =>
          const GraphicsTeamLeaderDashboardScreen(),
      RouteNames.GraphicsTeamLeaderTaskDashboardScreen: (context) =>
          const GraphicsTeamLeaderTaskDashboardScreen(),
      RouteNames.GraphicsTeamLeaderAssignTaskScreen: (context) =>
          const GraphicsTeamLeaderAssignTaskScreen(),
      RouteNames.GraphicsTeamLeaderMemberAvailabilityScreen: (context) =>
          const GraphicsTeamLeaderMemberAvailabilityScreen(),
      RouteNames.GraphicsTeamLeaderEditorScreen: (context) =>
          const GraphicsTeamLeaderEditorScreen(),
      RouteNames.GraphicsToPresidentRequestScreen: (context) =>
          const GraphicsToPresidentRequestScreen(),
      RouteNames.GraphicsTeamLeaderAddRemoveMembersScreen: (context) =>
          const GraphicsTeamLeaderAddRemoveMembersScreen(),
      RouteNames.GraphicsTeamLeaderCommunicationScreen: (context) =>
          GraphicsTeamLeaderCommunicationScreen(),
      RouteNames.GraphicsTeamLeaderPerformanceScreen: (context) =>
          GraphicsTeamLeaderPerformanceScreen(),

      //Graphics Team Volunteer Routes
      RouteNames.GraphicsTeamVolunteerDashboardScreen: (context) =>
          const GraphicsTeamVolunteerDashboardScreen(),
      RouteNames.GraphicsVolunteerCommunicationScreen: (context) =>
          const GraphicsVolunteerCommunicationScreen(),
      RouteNames.GraphicsVolunteerToLeaderRequestScreen: (context) =>
          const GraphicsVolunteerToLeaderRequestScreen(),
      RouteNames.GraphicsVolunteerLeaderboardScreen: (context) =>
          const GraphicsVolunteerLeaderboardScreen(),
      RouteNames.GraphicsTeamVolunteerTaskScreen: (context) =>
          const GraphicsTeamVolunteerTaskScreen(),
    };
  }
}
