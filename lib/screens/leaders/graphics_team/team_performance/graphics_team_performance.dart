import 'package:flutter/material.dart';

class GraphicsTeamLeaderPerformanceScreen extends StatefulWidget {
  @override
  _GraphicsTeamLeaderPerformanceScreenState createState() =>
      _GraphicsTeamLeaderPerformanceScreenState();
}

class _GraphicsTeamLeaderPerformanceScreenState
    extends State<GraphicsTeamLeaderPerformanceScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String filterBy = "Default";

  List<Map<String, dynamic>> volunteers = [
    {
      "id": "G001",
      "name": "Ali Raza",
      "image":
          "https://via.placeholder.com/150", // Replace with your real image URLs
      "tasksAssigned": 10,
      "tasksDone": 8,
      "chapter": "Lahore"
    },
    {
      "id": "G002",
      "name": "Usama",
      "image": "https://via.placeholder.com/150",
      "tasksAssigned": 12,
      "tasksDone": 11,
      "chapter": "Lahore"
    },
    {
      "id": "G003",
      "name": "Sara",
      "image": "https://via.placeholder.com/150",
      "tasksAssigned": 15,
      "tasksDone": 7,
      "chapter": "Lahore"
    },
  ];

  List<Map<String, dynamic>> get filteredVolunteers {
    List<Map<String, dynamic>> filtered = volunteers.where((volunteer) {
      return volunteer["name"]
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          volunteer["id"].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    if (filterBy == "Highest Performance") {
      filtered.sort((a, b) {
        double percentA = (a["tasksDone"] / a["tasksAssigned"]);
        double percentB = (b["tasksDone"] / b["tasksAssigned"]);
        return percentB.compareTo(percentA);
      });
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphics Team Performance"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search by Name or ID",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: filterBy,
                  items: [
                    "Default",
                    "Highest Performance",
                  ]
                      .map((item) =>
                          DropdownMenuItem(value: item, child: Text(item)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      filterBy = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVolunteers.length,
              itemBuilder: (context, index) {
                var volunteer = filteredVolunteers[index];
                double percentage = volunteer["tasksAssigned"] > 0
                    ? volunteer["tasksDone"] / volunteer["tasksAssigned"]
                    : 0;

                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(volunteer["image"]),
                    ),
                    title: Text(
                      "${volunteer["name"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID: ${volunteer["id"]}",
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color),
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: percentage,
                          color: Colors.green,
                          backgroundColor: Colors.grey[300],
                          minHeight: 8,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${volunteer["tasksDone"]}/${volunteer["tasksAssigned"]} tasks done (${(percentage * 100).toStringAsFixed(1)}%)",
                          style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
