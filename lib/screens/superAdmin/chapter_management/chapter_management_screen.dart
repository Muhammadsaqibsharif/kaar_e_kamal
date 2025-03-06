import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class ChapterManagementScreen extends StatelessWidget {
  const ChapterManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of grid items with labels & routes
    final List<Map<String, dynamic>> chapterOptions = [
      {
        "label": "Create Chapter",
        "route": RouteNames.createChapter,
        "icon": Icons.add
      },
      {
        "label": "Chapter List",
        "route": RouteNames.chapterList,
        "icon": Icons.list
      },
      {
        "label": "Assign Postion",
        "route": RouteNames.AssignPositionScreen,
        "icon": Icons.person_add
      },
      // {
      //   "label": "Chapter Reports",
      //   "route": RouteNames.chapterReports,
      //   "icon": Icons.insert_chart
      // },
      // {
      //   "label": "View Members",
      //   "route": RouteNames.viewMembers,
      //   "icon": Icons.groups
      // },
      // {
      //   "label": "Manage Roles",
      //   "route": RouteNames.manageRoles,
      //   "icon": Icons.admin_panel_settings
      // },
      // {
      //   "label": "Chapter Finances",
      //   "route": RouteNames.chapterFinances,
      //   "icon": Icons.account_balance
      // },
      // {
      //   "label": "Event Management",
      //   "route": RouteNames.eventManagement,
      //   "icon": Icons.event
      // },
      // {
      //   "label": "Chapter Resources",
      //   "route": RouteNames.chapterResources,
      //   "icon": Icons.book
      // },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter Management'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: chapterOptions.length,
          itemBuilder: (context, index) {
            final option = chapterOptions[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, option["route"]);
              },
              child: Card(
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(option["icon"], color: Colors.white, size: 30),
                    const SizedBox(height: 8),
                    Text(
                      option["label"],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
