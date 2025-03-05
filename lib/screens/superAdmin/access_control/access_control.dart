import 'package:flutter/material.dart';

class AccessControlScreen extends StatefulWidget {
  const AccessControlScreen({Key? key}) : super(key: key);

  @override
  _AccessControlScreenState createState() => _AccessControlScreenState();
}

class _AccessControlScreenState extends State<AccessControlScreen> {
  final List<Map<String, dynamic>> users = [
    {"id": "001", "name": "Ali Raza", "role": "Super Admin"},
    {"id": "002", "name": "Fatima Khan", "role": "City Admin"},
    {"id": "003", "name": "Hassan Ahmed", "role": "Moderator"},
    {"id": "004", "name": "Ayesha Siddiq", "role": "Team Member"},
    {"id": "005", "name": "Usman Tariq", "role": "Team Member"},
  ];

  final List<String> roles = [
    "Super Admin",
    "City Admin",
    "Moderator",
    "Team Member"
  ];

  void _showRoleDialog(BuildContext context, Map<String, dynamic> user) {
    String? selectedRole = user["role"];
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Manage Role for ${user["name"]}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: const InputDecoration(
                    labelText: "Select Role",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  ),
                  items: roles
                      .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        setState(() {
                          users.removeWhere((u) => u["id"] == user["id"]);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Delete"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          user["role"] = selectedRole!;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          foregroundColor: Colors.white),
                      child: const Text("Save Changes"),
                    ),
                  ],
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Access Control'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: ListView(
          children: users.map((user) {
            return Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(0.2),
                  child: Text(user["name"][0], style: TextStyle(color: theme.primaryColor)),
                ),
                title: Text(user["name"]),
                subtitle: Text("Role: ${user["role"]}"),
                trailing: Icon(Icons.edit, color: theme.primaryColor),
                onTap: () => _showRoleDialog(context, user),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
