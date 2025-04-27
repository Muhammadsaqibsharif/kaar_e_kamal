import 'package:flutter/material.dart';

class GraphicsVolunteerLeaderboardScreen extends StatelessWidget {
  const GraphicsVolunteerLeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Leaderboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Leaderboard Overview",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Leaderboard list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: volunteerList.length,
                itemBuilder: (context, index) {
                  var volunteer = volunteerList[index];
                  double performancePercentage =
                      (volunteer["tasksDone"] / volunteer["tasksAssigned"]);

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Show stars for top 3 positions
                              if (index == 0) ...[
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 30),
                              ],
                              if (index == 1) ...[
                                const Icon(Icons.star,
                                    color: Colors.grey, size: 30),
                              ],
                              if (index == 2) ...[
                                const Icon(Icons.star,
                                    color: Color(0xFFCD7F32), size: 30),
                              ],
                              const SizedBox(width: 8),
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: performancePercentage,
                                  color: Colors.blue,
                                  backgroundColor: Colors.grey[300],
                                  minHeight: 8,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${volunteer["tasksDone"]}/${volunteer["tasksAssigned"]} tasks done (${(performancePercentage * 100).toStringAsFixed(1)}%)",
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
            ],
          ),
        ),
      ),
    );
  }
}

// Mock Data for Volunteers
List<Map<String, dynamic>> volunteerList = [
  {
    "id": "V001",
    "name": "Emaan Malik",
    "image": "https://via.placeholder.com/150",
    "tasksAssigned": 14,
    "tasksDone": 13,
  },
  {
    "id": "V002",
    "name": "Zain Raza",
    "image": "https://via.placeholder.com/150",
    "tasksAssigned": 10,
    "tasksDone": 9,
  },
  {
    "id": "V003",
    "name": "Noor Fatima",
    "image": "https://via.placeholder.com/150",
    "tasksAssigned": 12,
    "tasksDone": 10,
  },
  {
    "id": "V004",
    "name": "Ali Raza",
    "image": "https://via.placeholder.com/150",
    "tasksAssigned": 11,
    "tasksDone": 6,
  },
  {
    "id": "V005",
    "name": "Sarah Khan",
    "image": "https://via.placeholder.com/150",
    "tasksAssigned": 15,
    "tasksDone": 5,
  },
];
