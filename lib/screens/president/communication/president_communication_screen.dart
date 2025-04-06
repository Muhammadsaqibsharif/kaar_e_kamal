import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';

class PresidentCommunicationScreen extends StatefulWidget {
  @override
  _PresidentCommunicationScreenState createState() =>
      _PresidentCommunicationScreenState();
}

class _PresidentCommunicationScreenState
    extends State<PresidentCommunicationScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // Sample list of users in the President's chapter (filtered data)
  List<Map<String, String>> users = [
    {
      "id": "001",
      "name": "Ali",
      "position": "Team Leader",
      "team": "Media Team",
      "chapter": "Lahore"
    },
    {
      "id": "002",
      "name": "Usama",
      "position": "Volunteer",
      "team": "Graphics Team",
      "chapter": "Lahore"
    },
    {
      "id": "003",
      "name": "Mashood",
      "position": "Team Member",
      "team": "Blood Donation Team",
      "chapter": "Lahore"
    },
    {
      "id": "004",
      "name": "Ahmed",
      "position": "Team Member",
      "team": "Media Team",
      "chapter": "Lahore"
    },
    // Add more users as needed
  ];

  // President's chapter (this should be dynamic based on login info)
  String presidentChapter = "Lahore";

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

  // Filter users based on the President's chapter
  List<Map<String, String>> get filteredUsers {
    return users.where((user) {
      return user["chapter"] == presidentChapter &&
          (user["name"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              user["id"]!.contains(searchQuery) ||
              user["position"]!
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
              (user.containsKey("team") &&
                  user["team"]!
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())));
    }).toList();
  }

  void openChatPopup(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 350,
            height: 400,
            padding: EdgeInsets.all(10),
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
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Hello! How can I help you?",
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text("Hi! I have a question.",
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
                        icon: Icon(
                          Icons.send,
                          color: Color(0xFF31511E), // Dark Green send icon
                        ),
                        onPressed: () {
                          // Send message logic here
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
        title: const Text("Communication with Chapter Members"),
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
                    label: 'Search by Name, ID, Position, or Team',
                    hint: 'Enter search text...',
                    onSaved: (value) {},
                  ),
                ),
                IconButton(
                  icon:
                      Icon(Icons.search, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    setState(() {
                      searchQuery = searchController.text;
                    });
                  },
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
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: ListTile(
                    title: Text("${user["name"]} - ${user["position"]}",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color)),
                    subtitle: Text(
                        "ID: ${user["id"]}" +
                            (user.containsKey("team")
                                ? "\nTeam: ${user["team"]}"
                                : ""),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color)),
                    trailing: IconButton(
                      icon: Icon(Icons.message,
                          color: Theme.of(context).primaryColor),
                      onPressed: () {
                        openChatPopup(context, user["name"]!);
                      },
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
