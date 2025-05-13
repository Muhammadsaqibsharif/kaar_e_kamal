import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamManagementScreen extends StatefulWidget {
  @override
  _TeamManagementScreenState createState() => _TeamManagementScreenState();
}

class _TeamManagementScreenState extends State<TeamManagementScreen> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];

  final TextEditingController searchController = TextEditingController();

  final List<String> teams = [
    "Media Team",
    "Induction Team",
    "Graphics Team",
    "Blood Donation Team",
    "Operational Team",
    "Finance Team",
    "Content Team",
    "Sponsorship Team",
    "Event Team",
    "Survey Team",
    "Verification Team",
    "Database Team",
    "PR Team",
    "Documentation Team",
    "Response Groups Team",
  ];

  String? selectedTeam;
  String? selectedRoleType;
  bool showLeadersOnly = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    searchController.addListener(_filterUsers);
  }

  Future<void> _fetchUsers() async {
    setState(() {
      isLoading = true;
    });

    final querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    users = querySnapshot.docs
        .where((doc) =>
            doc['Role'].toString().contains('Leader') ||
            doc['Role'].toString().contains('Volunteer'))
        .map((doc) {
      return {
        'id': doc.id,
        '_id': doc['_id'],
        'firstName': doc['firstName'],
        'lastName': doc['lastName'],
        'role': doc['Role'],
        'team': _extractTeamFromRole(doc['Role']),
      };
    }).toList();

    setState(() {
      filteredUsers = List.from(users);
      isLoading = false;
    });
  }

  String? _extractTeamFromRole(String role) {
    for (var team in teams) {
      if (role.contains(team)) {
        return team;
      }
    }
    return null;
  }

  void _filterUsers() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = users.where((user) {
        final fullName =
            "${user['firstName']} ${user['lastName']}".toLowerCase();
        return fullName.contains(query) ||
            user['_id'].toLowerCase().contains(query) ||
            user['role'].toLowerCase().contains(query) ||
            (user['team'] != null &&
                user['team']!.toLowerCase().contains(query));
      }).toList();
    });
  }

  void _assignRoleDialog(BuildContext context, Map<String, dynamic> user) {
    selectedTeam = user['team'];
    selectedRoleType = null;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Assign Role to ${user['firstName']} ${user['lastName']} (${user['_id']})",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedRoleType,
                      decoration: const InputDecoration(
                        labelText: "Select Role Type",
                        border: OutlineInputBorder(),
                      ),
                      items: ['Leader', 'Volunteer', 'General User']
                          .map((roleType) => DropdownMenuItem(
                                value: roleType,
                                child: Text(roleType),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setStateDialog(() {
                          selectedRoleType = value;
                          if (value == 'General User') selectedTeam = null;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    if (selectedRoleType == 'Leader' ||
                        selectedRoleType == 'Volunteer')
                      DropdownButtonFormField<String>(
                        value: selectedTeam,
                        decoration: const InputDecoration(
                          labelText: "Select Team",
                          border: OutlineInputBorder(),
                        ),
                        items: teams
                            .map((team) => DropdownMenuItem(
                                  value: team,
                                  child: Text(team),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setStateDialog(() {
                            selectedTeam = value;
                          });
                        },
                      ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (selectedRoleType != null) {
                              String finalRole = 'Team Member';

                              if (selectedRoleType == 'General User') {
                                finalRole = 'Team Member';
                              } else if (selectedTeam != null) {
                                finalRole = '$selectedTeam $selectedRoleType';
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please select a team.')),
                                );
                                return;
                              }

                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user['id'])
                                  .update({'Role': finalRole});

                              await _fetchUsers();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  void _removeRoleDialog(BuildContext context, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text("Remove Role from ${user['firstName']} ${user['lastName']}"),
          content: const Text("Are you sure you want to remove this role?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user['id'])
                    .update({'Role': 'Team Member'});

                await _fetchUsers();
                Navigator.pop(context);
              },
              child: const Text("Remove"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Management"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: "Search (name, _id, team, role)",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
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
                        _filterUsers();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredUsers.length,
                  itemBuilder: (context, index) {
                    final user = filteredUsers[index];
                    if (showLeadersOnly &&
                        !user['role'].toString().contains('Leader')) {
                      return const SizedBox.shrink();
                    }
                    return Card(
                      child: ListTile(
                        title: Text(
                            "${user['firstName']} ${user['lastName']} (${user['_id']})"),
                        subtitle: Text(
                          "Role: ${user['role']}${user['team'] != null ? ' - Team: ${user['team']}' : ''}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _assignRoleDialog(context, user),
                            ),
                            if (user['role'] != 'Team Member')
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () =>
                                    _removeRoleDialog(context, user),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Loader overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
