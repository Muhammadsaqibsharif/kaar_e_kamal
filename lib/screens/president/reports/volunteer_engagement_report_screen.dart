import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class VolunteerEngagementReportScreen extends StatefulWidget {
  @override
  _VolunteerEngagementReportScreenState createState() =>
      _VolunteerEngagementReportScreenState();
}

class _VolunteerEngagementReportScreenState
    extends State<VolunteerEngagementReportScreen> {
  final List<VolunteerEngagementData> volunteerEngagementData = [
    VolunteerEngagementData('Ali', 85),
    VolunteerEngagementData('Saqib', 70),
    VolunteerEngagementData('Usama', 90),
    VolunteerEngagementData('Mashood', 65),
  ];

  String selectedTeam = 'Media Team';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteer Engagement Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Volunteer Engagement Metrics',
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
            _buildVolunteerList(),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerList() {
    return Column(
      children: volunteerEngagementData.map((data) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          elevation: 5,
          child: ListTile(
            title: Text(data.volunteer),
            subtitle: Text('Engagement Level: ${data.engagement}%'),
          ),
        );
      }).toList(),
    );
  }
}

// Data model classes
class VolunteerEngagementData {
  final String volunteer;
  final int engagement;

  VolunteerEngagementData(this.volunteer, this.engagement);
}
