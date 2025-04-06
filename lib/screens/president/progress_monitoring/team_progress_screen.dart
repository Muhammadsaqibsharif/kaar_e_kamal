import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/screens/president/progress_monitoring/feedback_screen.dart';

class TeamProgressScreen extends StatefulWidget {
  const TeamProgressScreen({Key? key}) : super(key: key);

  @override
  _TeamProgressScreenState createState() => _TeamProgressScreenState();
}

class _TeamProgressScreenState extends State<TeamProgressScreen> {
  // List of teams to select from
  final List<String> teams = [
    'Media Team',
    'Induction team',
    'Graphics team',
    'Blood Donation Team',
    'Operational Team',
    'Finance Team',
    'Content team',
    'Verification team',
    'Response Groups Team',
    'Sponsorship Team',
    'Event Team',
    'Survey Team',
    'Database Team',
    'PR Team',
    'Documentation Team',
  ];

  // Selected team
  String? selectedTeam;

  // Placeholder for team progress
  String teamProgress = "No progress available"; // Placeholder text

  // Function to fetch progress based on selected team
  void fetchTeamProgress(String team) {
    setState(() {
      teamProgress = "$team is making significant progress!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Team Progress Monitoring",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown to select a team with enhanced styling
            Text(
              "Select a Team:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).brightness == Brightness.light
                    ? Color(0xFF31511E) // Dark Green for light theme
                    : Colors.white, // White for dark theme
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedTeam,
              hint: Text(
                "Select a team",
                style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black45
                        : Colors.white70),
              ),
              onChanged: (newValue) {
                setState(() {
                  selectedTeam = newValue;
                  // Fetch progress when team is selected
                  fetchTeamProgress(newValue!);
                });
              },
              items: teams.map((team) {
                return DropdownMenuItem<String>(
                  value: team,
                  child: Text(
                    team,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                );
              }).toList(),
              isExpanded: true,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              dropdownColor: Theme.of(context).brightness == Brightness.light
                  ? Color(0xFFF6FCDF) // Light Cream for light theme
                  : Color(0xFF1A1A19), // Very Dark Shade for dark theme
            ),
            SizedBox(height: 20),
            // Display selected team progress
            if (selectedTeam != null) ...[
              Text(
                "Progress of ${selectedTeam ?? ''}:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Color(0xFF31511E) // Dark Green for light theme
                      : Colors.white, // White for dark theme
                ),
              ),
              SizedBox(height: 10),
              Text(
                teamProgress,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ],
            SizedBox(height: 30),
            // Button to give feedback
            ElevatedButton(
              onPressed: selectedTeam == null
                  ? null
                  : () {
                      // Navigate to feedback screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackScreen(
                            teamName: selectedTeam!,
                          ),
                        ),
                      );
                    },
              child: Text("Give Feedback"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ensure button text is always white
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
