import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'notification_detail_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserNotifications();
  }

  Future<void> fetchUserNotifications() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_notifications')
          .orderBy('timestamp', descending: true)
          .get();

      final fetched = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'id': doc.id,
          'title': '📢 Notification',
          'subtitle': data['message'] ?? 'No message',
          'isRead': data['isRead'] ?? false,
        };
      }).toList();

      setState(() {
        notifications = fetched;
        isLoading = false;
      });
    } catch (e) {
      print('⚠️ Error fetching notifications: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> markAsRead(int index) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docId = notifications[index]['id'];
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_notifications')
          .doc(docId)
          .update({'isRead': true});
    } catch (e) {
      print('❌ Failed to update read status: $e');
    }
  }

  Future<void> deleteNotification(int index) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docId = notifications[index]['id'];
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('user_notifications')
          .doc(docId)
          .delete();

      setState(() {
        notifications.removeAt(index);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notification deleted.")),
      );
    } catch (e) {
      print('❌ Failed to delete notification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete notification: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
              ? const Center(child: Text("No notifications yet."))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: ListView.separated(
                    itemCount: notifications.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final notification = notifications[index];

                      return Dismissible(
                        key: Key(notification['id']),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) => deleteNotification(index),
                        child: Container(
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
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
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
                                color: notification['isRead']
                                    ? Colors.grey
                                    : Colors.green,
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
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                notification['subtitle'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                ),
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
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
                                  color: notification['isRead']
                                      ? Colors.grey
                                      : Colors.green,
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
                              if (!notification['isRead']) {
                                await markAsRead(index);
                                setState(() {
                                  notifications[index]['isRead'] = true;
                                });
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
