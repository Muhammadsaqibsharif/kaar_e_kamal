import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';

class ContentTeamLeaderCommunicationScreen extends StatefulWidget {
  @override
  _ContentTeamLeaderCommunicationScreenState createState() =>
      _ContentTeamLeaderCommunicationScreenState();
}

class _ContentTeamLeaderCommunicationScreenState
    extends State<ContentTeamLeaderCommunicationScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // Content Leader’s chapter
  String leaderChapter = "Lahore";

  // Sample list of users (include President and relevant volunteers)
  List<Map<String, String>> users = [
    {
      "id": "001",
      "name": "Ali",
      "position": "President",
      "team": "",
      "chapter": "Lahore"
    },
    {
      "id": "002",
      "name": "Usama",
      "position": "Volunteer",
      "team": "Content Team",
      "chapter": "Lahore"
    },
    {
      "id": "003",
      "name": "Mashood",
      "position": "Team Member",
      "team": "Content Team",
      "chapter": "Lahore"
    },
    {
      "id": "004",
      "name": "Ahmed",
      "position": "Volunteer",
      "team": "Graphics Team",
      "chapter": "Lahore"
    },
    {
      "id": "005",
      "name": "Sara",
      "position": "Volunteer",
      "team": "Content Team",
      "chapter": "Karachi"
    },
  ];

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    messageController.dispose();
    super.dispose();
  }

  // Filter only President or same chapter Content Team volunteers
  List<Map<String, String>> get filteredUsers {
    return users.where((user) {
      final sameChapter = user["chapter"] == leaderChapter;
      final isPresident = user["position"]?.toLowerCase() == "president";
      final isContentTeam =
          user["team"]?.toLowerCase() == "content team" &&
              (user["position"]?.toLowerCase() == "volunteer" ||
               user["position"]?.toLowerCase() == "team member");

      final matchesSearch = user["name"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user["id"]!.contains(searchQuery) ||
          user["position"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (user.containsKey("team") &&
              user["team"]!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()));

      return sameChapter && (isPresident || isContentTeam) && matchesSearch;
    }).toList();
  }

  void openChatPopup(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 350,
            height: 400,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text("Chat with $userName",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color)),
                Divider(color: Theme.of(context).primaryColor),
                Expanded(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("Hello! How can I help you?",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xFF31511E),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text("Hi! I have a question.",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          controller: messageController,
                          label: 'Type a message...',
                          hint: 'Your message here...',
                          onSaved: (value) {},
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Color(0xFF31511E)),
                        onPressed: () {
                          // TODO: Handle send message
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Content Team Leader Communication"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomInputField(
                    controller: searchController,
                    label: 'Search by Name, ID, or Position',
                    hint: 'Search...',
                    onSaved: (value) {},
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
                  onPressed: () => setState(() {
                    searchQuery = searchController.text;
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                var user = filteredUsers[index];
                return Card(
                  child: ListTile(
                    title: Text("${user["name"]} - ${user["position"]}",
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color)),
                    subtitle: Text(
                        "ID: ${user["id"]}" +
                            (user.containsKey("team") && user["team"]!.isNotEmpty
                                ? "\nTeam: ${user["team"]}"
                                : ""),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color)),
                    trailing: IconButton(
                      icon: Icon(Icons.message, color: Theme.of(context).primaryColor),
                      onPressed: () => openChatPopup(context, user["name"]!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
