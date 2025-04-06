import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class ActivityLevelReportScreen extends StatefulWidget {
  @override
  _ActivityLevelReportScreenState createState() =>
      _ActivityLevelReportScreenState();
}

class _ActivityLevelReportScreenState extends State<ActivityLevelReportScreen> {
  final List<TeamActivityData> teamActivityData = [
    TeamActivityData('Media', 60),
    TeamActivityData('Induction', 45),
    TeamActivityData('Graphics', 90),
    TeamActivityData('Blood Donation', 120),
  ];

  String selectedTeam = 'Media Team';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Level Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Team Activity Levels',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            DropdownButton<String>(
              value: selectedTeam,
              items: <String>[
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
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTeam = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildTeamActivityProgress(),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamActivityProgress() {
    return Column(
      children: teamActivityData.map((data) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          elevation: 5,
          child: ListTile(
            title: Text(data.team),
            subtitle: Text('Activity Level: ${data.activity} hours'),
            trailing: CircularProgressIndicator(
              value: data.activity / 120.0,
              strokeWidth: 5.0,
              backgroundColor: Colors.grey[300],
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ),
        );
      }).toList(),
    );
  }
}

// Data model classes
class TeamActivityData {
  final String team;
  final int activity;

  TeamActivityData(this.team, this.activity);
}
