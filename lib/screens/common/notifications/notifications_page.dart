import 'package:flutter/material.dart';
import 'notification_detail_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Event: Blood Donation Camp',
      'subtitle': 'Join us tomorrow at UET Lahore Auditorium.',
      'isRead': false,
    },
    {
      'title': 'Task Update',
      'subtitle': 'Your recent task has been approved.',
      'isRead': true,
    },
    {
      'title': 'Important Announcement',
      'subtitle': 'Meeting scheduled on Monday at 5 PM.',
      'isRead': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView.separated(
          itemCount: notifications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: notification['isRead']
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification['isRead']
                        ? Icons.notifications_none_rounded
                        : Icons.notifications_active_rounded,
                    color: notification['isRead'] ? Colors.grey : Colors.green,
                    size: 28,
                  ),
                ),
                title: Text(
                  notification['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: notification['isRead']
                        ? FontWeight.w500
                        : FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    notification['subtitle'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: notification['isRead']
                        ? Colors.grey.withOpacity(0.15)
                        : Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    notification['isRead'] ? 'Read' : 'Unread',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          notification['isRead'] ? Colors.grey : Colors.green,
                    ),
                  ),
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationDetailPage(
                        title: notification['title'],
                        subtitle: notification['subtitle'],
                      ),
                    ),
                  );
                  // mark it as read and refresh UI
                  setState(() {
                    notifications[index]['isRead'] = true;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
