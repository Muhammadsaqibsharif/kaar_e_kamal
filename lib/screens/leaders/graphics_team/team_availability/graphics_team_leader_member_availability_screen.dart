import 'package:flutter/material.dart';

class GraphicsTeamLeaderMemberAvailabilityScreen extends StatefulWidget {
  const GraphicsTeamLeaderMemberAvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<GraphicsTeamLeaderMemberAvailabilityScreen> createState() =>
      _GraphicsTeamLeaderMemberAvailabilityScreenState();
}

class _GraphicsTeamLeaderMemberAvailabilityScreenState
    extends State<GraphicsTeamLeaderMemberAvailabilityScreen> {
  bool showOnlyAvailable = false;

  // Dummy data model for Graphics team
  final List<Member> members = [
    Member(name: "Hamza Shahbaz", assignedTasks: 1),
    Member(name: "Iqra Iftikhar", assignedTasks: 0),
    Member(name: "Zain Malik", assignedTasks: 3),
    Member(name: "Fatima Sohail", assignedTasks: 0),
  ];

  @override
  Widget build(BuildContext context) {
    final filteredMembers = showOnlyAvailable
        ? members.where((member) => member.assignedTasks == 0).toList()
        : members;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphics Team Availability'),
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
