import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BecomeVolunteerScreen extends StatefulWidget {
  @override
  _BecomeVolunteerScreenState createState() => _BecomeVolunteerScreenState();
}

class _BecomeVolunteerScreenState extends State<BecomeVolunteerScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reasonController = TextEditingController();
  String? _selectedTeam;

  final List<String> _teams = [
    'Graphics Team',
    'Documentation Team',
    'Media Team',
    'Blood Donation Team',
    'Operational Team',
    'Finance Team',
    'Induction Team',
    'PR Team',
    'Event Management Team',
    'Technical Team',
    'Survey Team',
    'Verification Team',
    'Sponsorship Team',
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Show loader
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(child: CircularProgressIndicator()),
          );
        },
      );

      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User not logged in")),
          );
          return;
        }

        // Fetch user data from Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        String firstName = userSnapshot['firstName'] ?? '';
        String lastName = userSnapshot['lastName'] ?? '';
        String email = user.email ?? '';

        // Save volunteer request to Firestore
        await FirebaseFirestore.instance.collection('volunteer_requests').add({
          'team': _selectedTeam,
          'reason': _reasonController.text.trim(),
          'submitted_by_uid': user.uid,
          'submitted_by_firstName': firstName,
          'submitted_by_lastName': lastName,
          'email': email,
          'status': 'pending',
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.of(context).pop();

        Future.delayed(Duration(milliseconds: 300), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Volunteer request submitted successfully")),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.UserHomeScreen2,
            (route) => false,
          );
        });
      } catch (e) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to submit request: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Become a Volunteer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Join the mission and be a hero for humanity. Select your desired team and tell us why you want to be part of Kaar-e-Kamal!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),

                // Team Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedTeam,
                  decoration: InputDecoration(
                    labelText: 'Select Team',
                    hintText: 'Select the team you wish to join',
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white70,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedTeam = value;
                    });
                  },
                  items: _teams.map((String team) {
                    return DropdownMenuItem<String>(
                      value: team,
                      child: Text(
                        team,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a team';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Reason Text Field
                CustomInputField(
                  label: "Why do you want to join this team?",
                  hint: "Write your reason here",
                  controller: _reasonController,
                  maxLines: 5,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a reason';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text("Submit Request", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
