import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BloodDonationRegistrationScreen extends StatefulWidget {
  @override
  _BloodDonationRegistrationScreenState createState() =>
      _BloodDonationRegistrationScreenState();
}

class _BloodDonationRegistrationScreenState
    extends State<BloodDonationRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _healthInfoController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();

  String? _selectedBloodGroup;

  final List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Show blur with progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Navigator.pop(context); // dismiss loader
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User not logged in")),
          );
          return;
        }

        // Fetch user's name info (assuming stored in 'users' collection)
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        final firstName = userDoc['firstName'] ?? '';
        final lastName = userDoc['lastName'] ?? '';

        // Store data in 'blood_donors'
        await FirebaseFirestore.instance.collection('blood_donors').add({
          'submitted_by_uid': user.uid,
          'submitted_by_firstName': firstName,
          'submitted_by_lastName': lastName,
          'fullName': _nameController.text,
          'age': _ageController.text,
          'healthInfo': _healthInfoController.text,
          'bloodGroup': _selectedBloodGroup,
          'contactNumber': _contactNumberController.text,
          'createdAt': DateTime.now(),
        });

        await Future.delayed(Duration(milliseconds: 500)); // small delay

        Navigator.pop(context); // dismiss loader

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Successfully Registered as Blood Donor")),
        );

        // Navigate back to User Home
        await Future.delayed(Duration(milliseconds: 500));
        Navigator.pushReplacementNamed(context, RouteNames.UserHomeScreen2);
      } catch (e) {
        Navigator.pop(context); // dismiss loader
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Become Blood Donor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Added to prevent overflow on smaller screens
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomInputField(
                  label: "Full Name",
                  hint: "Enter your full name",
                  controller: _nameController,
                  onSaved: (value) {
                    // Handle saving name
                  },
                ),
                SizedBox(height: 20), // Added spacing between fields
                CustomInputField(
                  label: "Age",
                  hint: "Enter your age",
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  onSaved: (value) {
                    // Handle saving age
                  },
                ),
                SizedBox(height: 20), // Added spacing between fields
                CustomInputField(
                  label: "Health Info",
                  hint: "Provide your health information",
                  maxLines: 4,
                  controller: _healthInfoController,
                  onSaved: (value) {
                    // Handle saving health info
                  },
                ),
                SizedBox(height: 20), // Added spacing between fields
                // Blood Group Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  decoration: InputDecoration(
                    labelText: 'Blood Group',
                    hintText: 'Select your blood group',
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
                      _selectedBloodGroup = value;
                    });
                  },
                  items: _bloodGroups.map((String bloodGroup) {
                    return DropdownMenuItem<String>(
                      value: bloodGroup,
                      child: Text(
                        bloodGroup,
                        style:
                            TextStyle(color: Colors.white), // White text color
                      ),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select your blood group';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20), // Added spacing between fields
                // Contact Number Input
                CustomInputField(
                  label: "Contact Number",
                  hint: "Enter your contact number",
                  keyboardType: TextInputType.phone,
                  controller: _contactNumberController,
                  onSaved: (value) {
                    // Handle saving contact number
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    } else if (value.length < 10) {
                      return 'Contact number must be at least 10 digits';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30), // Increased spacing before the button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor:
                        Theme.of(context).primaryColor, // Full-width button
                    padding: EdgeInsets.symmetric(
                        vertical: 15), // Button color from theme
                  ),
                  child: Text(
                    "Register for Donation",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20), // Spacing between buttons
                //elevated button for BloodDonationHistoryScreen
                ElevatedButton(
                  onPressed: () {
                    // Navigate to BloodDonationHistoryScreen
                    Navigator.pushNamed(
                        context, RouteNames.BloodDonationHistoryScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Theme.of(context).primaryColor, // Text color white
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    padding: EdgeInsets.symmetric(
                        vertical: 15), // Better button padding
                  ),
                  child:
                      Text("Donation History", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
