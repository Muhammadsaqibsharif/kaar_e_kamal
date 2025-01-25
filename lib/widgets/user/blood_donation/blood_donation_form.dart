// lib/widgets/user/blood_donation/blood_donation_form.dart
import 'package:flutter/material.dart';

class BloodDonationForm extends StatefulWidget {
  @override
  _BloodDonationFormState createState() => _BloodDonationFormState();
}

class _BloodDonationFormState extends State<BloodDonationForm> {
  final _formKey = GlobalKey<FormState>();
  String? name, age, healthCondition;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            onSaved: (value) => name = value,
            validator: (value) => value!.isEmpty ? "Name is required" : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(labelText: "Age"),
            onSaved: (value) => age = value,
            validator: (value) =>
                value!.isEmpty ? "Age is required" : null,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(labelText: "Health Condition"),
            onSaved: (value) => healthCondition = value,
            validator: (value) =>
                value!.isEmpty ? "Health condition is required" : null,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Submit Donation"),
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Handle the form submission logic (send data to the server, etc.)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Donation Registered')));
    }
  }
}
