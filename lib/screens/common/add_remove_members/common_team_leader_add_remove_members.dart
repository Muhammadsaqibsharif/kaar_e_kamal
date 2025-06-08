import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamLeaderAddRemoveMembersScreen extends StatefulWidget {
  final String teamName;

  const TeamLeaderAddRemoveMembersScreen({Key? key, required this.teamName})
      : super(key: key);

  @override
  State<TeamLeaderAddRemoveMembersScreen> createState() =>
      _TeamLeaderAddRemoveMembersScreenState();
}

class _TeamLeaderAddRemoveMembersScreenState
    extends State<TeamLeaderAddRemoveMembersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _approveMember(String docId, String uid) async {
    try {
      // Update request status to 'approved'
      await _firestore.collection('volunteer_requests').doc(docId).update({
        'status': 'approved',
      });

      // Update user role in 'users' collection
      await _firestore.collection('users').doc(uid).update({
        'Role': '${widget.teamName} Volunteer', // Concatenate with teamName
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Member approved and role updated!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to approve: $e')),
      );
    }
  }

  void _rejectMember(String docId) async {
    await _firestore
        .collection('volunteer_requests')
        .doc(docId)
        .update({'status': 'rejected'});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Member request rejected!')),
    );
  }

  Future<Map<String, dynamic>?> _getUserData(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists ? doc.data() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Remove - ${widget.teamName}"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('volunteer_requests')
            .where('team', isEqualTo: widget.teamName)
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final requests = snapshot.data!.docs;

          if (requests.isEmpty) {
            return const Center(child: Text('No pending requests.'));
          }

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final uid = request['submitted_by_uid'];
              final reason = request['reason'];
              final docId = request.id;

              return FutureBuilder<Map<String, dynamic>?>(
                future: _getUserData(uid),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(title: Text("Loading..."));
                  }

                  final userData = userSnapshot.data;

                  if (userData == null) {
                    return ListTile(
                      title: const Text("User data not found"),
                      subtitle: Text("UID: $uid"),
                    );
                  }

                  return Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: userData['profileImageString'] !=
                                    null &&
                                userData['profileImageString'].isNotEmpty
                            ? MemoryImage(
                                base64Decode(userData['profileImageString']))
                            : null,
                        child: userData['profileImageString'] == null ||
                                userData['profileImageString'].isEmpty
                            ? const Icon(Icons.person, size: 30)
                            : null,
                      ),
                      title: Text(
                        "${userData['firstName']} ${userData['lastName']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email: ${userData['email']}"),
                          const SizedBox(height: 8),
                          Text("Why Join: $reason"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () => _approveMember(docId, uid),
                            tooltip: 'Approve',
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _rejectMember(docId),
                            tooltip: 'Reject',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
