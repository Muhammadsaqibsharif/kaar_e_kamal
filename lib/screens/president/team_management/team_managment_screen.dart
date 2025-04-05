import 'package:flutter/material.dart';

class TeamManagmentScreen extends StatefulWidget {
  @override
  _TeamManagmentScreenState createState() => _TeamManagmentScreenState();
}

class _TeamManagmentScreenState extends State<TeamManagmentScreen> {
  // Example list of users with associated teams
  List<Map<String, dynamic>> users = [
    {"id": 1, "name": "Ali", "role": "Team Member", "team": null},
    {"id": 2, "name": "Saqib", "role": "Team Member", "team": null},
    {"id": 3, "name": "Usama", "role": "Team Member", "team": null},
    {"id": 4, "name": "Mashood", "role": "Team Leader", "team": "Media Team"},
  ];

  // Filtered list of users based on search and filter
  List<Map<String, dynamic>> filteredUsers = [];

  final TextEditingController searchController = TextEditingController();

  final List<String> teams = [
    "Media Team",
    "Induction team",
    "Graphics team",
    "Blood Donation Team",
    "Operational Team",
    "Finance Team",
    "Content team",
    "Sponsorship Team",
    "Event Team ",
    "Survey Team",
    "Verification team",
    "Database Team",
    "PR Team",
    "Documentation Team",
    "Response Groups Team",
  ];

  String? selectedTeam;
  bool showLeadersOnly = false; // Filter flag for showing only leaders

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(users);
    searchController.addListener(_filterUsers);
  }

  void _filterUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = users
          .where((user) =>
              // Apply filtering based on search query, role, and team
              (user["role"] == "Team Leader" && showLeadersOnly) ||
              (user["name"].toLowerCase().contains(query) ||
                  user["role"].toLowerCase().contains(query) ||
                  user["id"].toString().contains(query) ||
                  (user["team"] != null &&
                      user["team"]!.toLowerCase().contains(query))))
          .toList();
    });
  }

  void _assignLeaderDialog(BuildContext context, Map<String, dynamic> user) {
    selectedTeam = user['team']; // Pre-select the current team (if any)

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Assign Leader for ${user['name']} (ID: ${user['id']})",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedTeam,
                      decoration: const InputDecoration(
                        labelText: "Select Team",
                        border: OutlineInputBorder(),
                      ),
                      items: teams.map((team) {
                        return DropdownMenuItem(value: team, child: Text(team));
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedTeam = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (selectedTeam != null) {
                              setState(() {
                                // Here you would update the user's role/team as needed
                                int userIndex = users
                                    .indexWhere((u) => u["id"] == user["id"]);
                                if (userIndex != -1) {
                                  users[userIndex]["role"] = "Team Leader";
                                  users[userIndex]["team"] = selectedTeam;
                                }

                                // Also update filteredUsers to reflect the changes immediately
                                filteredUsers = List.from(users);
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Assign Leader"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _removeLeaderDialog(BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove Leader Role from ${user['name']}"),
          content: Text(
              "Are you sure you want to remove ${user['name']}'s leader role?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Remove the leader role by updating the user's role
                  int userIndex =
                      users.indexWhere((u) => u["id"] == user["id"]);
                  if (userIndex != -1) {
                    users[userIndex]["role"] = "Team Member";
                    users[userIndex]["team"] = null; // Clear the team
                  }

                  // Also update filteredUsers to reflect the changes immediately
                  filteredUsers = List.from(users);
                });
                Navigator.pop(context);
              },
              child: const Text("Remove Leader"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create and Manage Leaders")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search User (By Name, Role, or Team)",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(showLeadersOnly
                      ? Icons.filter_alt_off
                      : Icons.filter_alt),
                  onPressed: () {
                    setState(() {
                      showLeadersOnly = !showLeadersOnly;
                    });
                    _filterUsers(); // Reapply filter when toggling
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      "${filteredUsers[index]["name"]} (ID: ${filteredUsers[index]['id']})"),
                  subtitle: Text(
                    "Role: ${filteredUsers[index]['role']} ${filteredUsers[index]['team'] != null ? '- Team: ${filteredUsers[index]['team']}' : ''}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _assignLeaderDialog(context, filteredUsers[index]),
                      ),
                      if (filteredUsers[index]['role'] == 'Team Leader')
                        IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => _removeLeaderDialog(
                              context, filteredUsers[index]),
                        ),
                    ],
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
