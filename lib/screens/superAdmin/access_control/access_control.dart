import 'package:flutter/material.dart';

class AccessControlScreen extends StatefulWidget {
  @override
  _AccessControlScreenState createState() => _AccessControlScreenState();
}

class _AccessControlScreenState extends State<AccessControlScreen> {
  List<Map<String, dynamic>> users = [
    {"id": 1, "name": "Ali", "role": "Super Admin"},
    {"id": 2, "name": "Saqib", "role": "Team Leader"},
    {"id": 3, "name": "Usama", "role": "Team Leader"},
    {"id": 4, "name": "Mashood", "role": "President"},
  ];

  List<Map<String, dynamic>> filteredUsers = [];
  final TextEditingController searchController = TextEditingController();

  final List<String> roles = [
    "Super Admin",
    "President",
    "Team Leader",
    "Team Member"
  ];
  final List<String> cities = ["Lahore", "Karachi", "Islamabad"];
  final List<String> teams = ["Media", "Finance", "Operations"];

  String? selectedRole;
  String? selectedCity;
  String? selectedTeam;

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
              user["name"].toLowerCase().contains(query) ||
              user["role"].toLowerCase().contains(query) ||
              user["id"].toString().contains(query))
          .toList();
    });
  }

  void _showRoleDialog(BuildContext context, Map<String, dynamic> user) {
    selectedRole = user["role"];
    selectedCity = null;
    selectedTeam = null;

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
                      "Manage Role for ${user['name']} (ID: ${user['id']})",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      decoration: const InputDecoration(
                        labelText: "Select Role",
                        border: OutlineInputBorder(),
                      ),
                      items: roles.map((role) {
                        return DropdownMenuItem(value: role, child: Text(role));
                      }).toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedRole = value;
                          selectedCity = null;
                          selectedTeam = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    if (selectedRole == "President")
                      DropdownButtonFormField<String>(
                        value: selectedCity,
                        decoration: const InputDecoration(
                          labelText: "Select City",
                          border: OutlineInputBorder(),
                        ),
                        items: cities.map((city) {
                          return DropdownMenuItem(
                              value: city, child: Text(city));
                        }).toList(),
                        onChanged: (value) {
                          setStateDialog(() => selectedCity = value);
                        },
                      ),
                    if (selectedRole == "Team Leader" ||
                        selectedRole == "Team Member")
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: DropdownButtonFormField<String>(
                          value: selectedTeam,
                          decoration: const InputDecoration(
                            labelText: "Select Team",
                            border: OutlineInputBorder(),
                          ),
                          items: teams.map((team) {
                            return DropdownMenuItem(
                                value: team, child: Text(team));
                          }).toList(),
                          onChanged: (value) {
                            setStateDialog(() => selectedTeam = value);
                          },
                        ),
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
                            if (selectedRole != null) {
                              setState(() {
                                // Find the index of the user in the main list
                                int userIndex = users
                                    .indexWhere((u) => u["id"] == user["id"]);
                                if (userIndex != -1) {
                                  users[userIndex]["role"] = selectedRole!;
                                }

                                // Also update filteredUsers to reflect the changes immediately
                                filteredUsers = List.from(users);
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Assign Role"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Access Control")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search User (By Name, Role, or ID)",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      "${filteredUsers[index]["name"]} (ID: ${filteredUsers[index]['id']})"),
                  subtitle: Text("Role: ${filteredUsers[index]['role']}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        _showRoleDialog(context, filteredUsers[index]),
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
