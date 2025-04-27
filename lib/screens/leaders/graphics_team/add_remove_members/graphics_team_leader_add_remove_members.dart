import 'package:flutter/material.dart';

class GraphicsTeamLeaderAddRemoveMembersScreen extends StatefulWidget {
  const GraphicsTeamLeaderAddRemoveMembersScreen({Key? key}) : super(key: key);

  @override
  State<GraphicsTeamLeaderAddRemoveMembersScreen> createState() =>
      _GraphicsTeamLeaderAddRemoveMembersScreenState();
}

class _GraphicsTeamLeaderAddRemoveMembersScreenState
    extends State<GraphicsTeamLeaderAddRemoveMembersScreen> {
  // List of requests from potential members with their respective profile picture
  List<MemberRequest> memberRequests = [
    MemberRequest(
      name: "Ali Khan",
      email: "alikhan@example.com",
      description:
          "I have a passion for graphic design and would love to contribute creative posts and event graphics.",
      dpImage: 'assets/pics/DP.jpg',
    ),
    MemberRequest(
      name: "Sara Ahmed",
      email: "saraahmed@example.com",
      description:
          "As an experienced graphic designer, I enjoy making visually engaging content for social media campaigns.",
      dpImage: 'assets/Images/1.jpg',
    ),
    MemberRequest(
      name: "Ahmed Raza",
      email: "ahmedraza@example.com",
      description:
          "With a strong background in digital illustrations and posters, I'm eager to assist the graphics team.",
      dpImage: 'assets/Images/2.jpg',
    ),
    MemberRequest(
      name: "Fatima Noor",
      email: "fatimanoor@example.com",
      description:
          "I'm passionate about visual storytelling through designs and want to help make impactful graphic posts.",
      dpImage: 'assets/Images/3.jpg',
    ),
  ];

  // Approve a member request
  void _approveMember(int index) {
    setState(() {
      memberRequests.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Member approved and added to the team!')),
    );
  }

  // Reject a member request
  void _rejectMember(int index) {
    setState(() {
      memberRequests.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Member request rejected!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphics Team — Add/Remove Members"),
      ),
      body: ListView.builder(
        itemCount: memberRequests.length,
        itemBuilder: (context, index) {
          final member = memberRequests[index];

          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                  member.dpImage.isNotEmpty
                      ? member.dpImage
                      : 'assets/pics/default.jpg',
                ),
              ),
              title: Text(
                member.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email: ${member.email}"),
                  const SizedBox(height: 8),
                  Text("Why Join: ${member.description}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => _approveMember(index),
                    tooltip: 'Approve',
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => _rejectMember(index),
                    tooltip: 'Reject',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MemberRequest {
  final String name;
  final String email;
  final String description;
  final String dpImage;

  MemberRequest({
    required this.name,
    required this.email,
    required this.description,
    required this.dpImage,
  });
}
