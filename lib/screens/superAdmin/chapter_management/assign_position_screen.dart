import 'package:flutter/material.dart';

class AssignPositionScreen extends StatefulWidget {
  const AssignPositionScreen({Key? key}) : super(key: key);

  @override
  _AssignPositionScreenState createState() => _AssignPositionScreenState();
}

class _AssignPositionScreenState extends State<AssignPositionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  final List<Map<String, dynamic>> users = [
    {"id": "001", "name": "Ali Raza", "chapter": "None", "role": "None"},
    {"id": "002", "name": "Fatima Khan", "chapter": "None", "role": "None"},
    {"id": "003", "name": "Hassan Ahmed", "chapter": "None", "role": "None"},
    {"id": "004", "name": "Ayesha Siddiq", "chapter": "None", "role": "None"},
    {"id": "005", "name": "Usman Tariq", "chapter": "None", "role": "None"},
  ];

  final List<String> chapters = [
    "Lahore",
    "Gujranwala",
    "Karachi",
    "Islamabad",
    "Peshawar",
    "Quetta"
  ];
  final List<String> roles = [
    "President",
    "Team Leader - Media",
    "Team Leader - Induction",
    "Team Leader - Graphics",
    "Team Leader - Blood Donation",
    "Team Leader - Operations",
    "Team Leader - Finance",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Assign Position'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Enter Name or ID",
                labelStyle: TextStyle(color: theme.primaryColor),
                prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                border: const OutlineInputBorder(),
              ),
              onChanged: (query) {
                setState(() => searchQuery = query.toLowerCase());
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: users.where((user) {
                  return user["name"].toLowerCase().contains(searchQuery) ||
                      user["id"].contains(searchQuery);
                }).map((user) {
                  return Card(
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.primaryColor.withOpacity(0.2),
                        child: Text(user["name"][0],
                            style: TextStyle(color: theme.primaryColor)),
                      ),
                      title: Text(user["name"]),
                      subtitle: Text(
                          "ID: ${user["id"]}\nRole: ${user["role"]} | Chapter: ${user["chapter"]}"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          size: 16, color: theme.primaryColor),
                      onTap: () => _showAssignDialog(context, user),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAssignDialog(BuildContext context, Map<String, dynamic> user) {
    String? selectedChapter =
        user["chapter"] == "None" ? null : user["chapter"];
    String? selectedRole = user["role"] == "None" ? null : user["role"];
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Assign Position to ${user["name"]}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedChapter,
                      decoration: const InputDecoration(
                        labelText: "Select Chapter",
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      ),
                      items: chapters
                          .map((chapter) => DropdownMenuItem(
                              value: chapter, child: Text(chapter)))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedChapter = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        labelText: "Select Role",
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      ),
                      items: roles
                          .map((role) =>
                              DropdownMenuItem(value: role, child: Text(role)))
                          .toList(),
                      onChanged: (value) {
                        setDialogState(() {
                          selectedRole = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: theme.primaryColor,
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (selectedChapter != null &&
                                selectedRole != null) {
                              setState(() {
                                user["chapter"] = selectedChapter!;
                                user["role"] = selectedRole!;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${user["name"]} assigned as $selectedRole in $selectedChapter"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          child: const Text("Assign Position"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
