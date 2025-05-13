import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BloodRequestScreen extends StatefulWidget {
  @override
  _BloodRequestScreenState createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

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
      // Show blur loader
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
          Navigator.of(context).pop(); // Close loader
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

        // Save blood case to Firestore
        await FirebaseFirestore.instance.collection('blood_case').add({
          'fullName': _nameController.text.trim(),
          'address': _locationController.text.trim(),
          'bloodGroup': _selectedBloodGroup,
          'contactNumber': _contactController.text.trim(),
          'submitted_by_uid': user.uid,
          'submitted_by_firstName': firstName,
          'submitted_by_lastName': lastName,
          "status": "pending",
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.of(context).pop(); // Close loader

        // Show success Snackbar after slight delay
        Future.delayed(Duration(milliseconds: 300), () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Blood request submitted successfully")),
          );

          // Navigate back to UserHomeScreen2
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.UserHomeScreen2,
            (route) => false,
          );
        });
      } catch (e) {
        Navigator.of(context).pop(); // Close loader
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
        title: Text("Blood Request"),
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
                SizedBox(height: 20),
                // Name Input
                CustomInputField(
                  label: "Full Name",
                  hint: "Enter your full name",
                  controller: _nameController,
                  onSaved: (value) {
                    // Handle saving name
                  },
                ),
                SizedBox(height: 20), // Added spacing between fields

                // Location Input
                CustomInputField(
                  label: "Address",
                  hint: "Enter your Address",
                  controller: _locationController,
                  onSaved: (value) {
                    // Handle saving Address
                  },
                ),
                SizedBox(height: 20), // Added spacing between fields

                // Blood Group Dropdown (Required Blood Group)
                DropdownButtonFormField<String>(
                  value: _selectedBloodGroup,
                  decoration: InputDecoration(
                    labelText: 'Required Blood Group',
                    hintText: 'Select the required blood group',
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
                      return 'Please select the required blood group';
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
                  controller: _contactController,
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
                SizedBox(height: 30), // Increased spacing before the buttons

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Theme.of(context).primaryColor, // Text color white
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    padding: EdgeInsets.symmetric(
                        vertical: 15), // Better button padding
                  ),
                  child: Text("Request Blood", style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 20), // Spacing between buttons

                // Donate Blood Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to BloodDonationRegistrationScreen
                    Navigator.pushNamed(
                        context, RouteNames.BloodDonationRegistrationScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Theme.of(context).primaryColor, // Text color white
                    minimumSize: Size(double.infinity, 50), // Full-width button
                    padding: EdgeInsets.symmetric(
                        vertical: 15), // Better button padding
                  ),
                  child: Text("Donate Blood", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
