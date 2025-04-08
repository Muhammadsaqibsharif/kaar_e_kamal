import 'package:flutter/material.dart';

class ContentTeamLeaderMemberAvailabilityScreen extends StatefulWidget {
  const ContentTeamLeaderMemberAvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<ContentTeamLeaderMemberAvailabilityScreen> createState() =>
      _ContentTeamLeaderMemberAvailabilityScreenState();
}

class _ContentTeamLeaderMemberAvailabilityScreenState
    extends State<ContentTeamLeaderMemberAvailabilityScreen> {
  bool showOnlyAvailable = false;

  // Dummy data model
  final List<Member> members = [
    Member(name: "Ali Raza", assignedTasks: 2),
    Member(name: "Sara Khan", assignedTasks: 0),
    Member(name: "Usman Tariq", assignedTasks: 4),
    Member(name: "Ayesha Noor", assignedTasks: 0),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMembers = showOnlyAvailable
        ? members.where((member) => member.assignedTasks == 0).toList()
        : members;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Team Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showOnlyAvailable = !showOnlyAvailable;
                    });
                  },
                  child: Text(showOnlyAvailable ? "Show All" : "Show Available Only"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMembers.length,
                itemBuilder: (context, index) {
                  final member = filteredMembers[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).cardColor,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(member.name[0]),
                      ),
                      title: Text(member.name),
                      subtitle: Text(
                        member.assignedTasks > 0
                            ? "Assigned ${member.assignedTasks} task(s)"
                            : "Available",
                        style: TextStyle(
                          color: member.assignedTasks > 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Member {
  final String name;
  final int assignedTasks;

  Member({required this.name, required this.assignedTasks});
}
