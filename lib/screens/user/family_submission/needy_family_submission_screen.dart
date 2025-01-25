import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';

class FamilySubmissionForm extends StatefulWidget {
  @override
  _FamilySubmissionFormState createState() => _FamilySubmissionFormState();
}

class _FamilySubmissionFormState extends State<FamilySubmissionForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each input field
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _caseTypeDetailsController = TextEditingController();
  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here, you can perform any action like saving the data to Firestore or calling an API
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Form Submitted Successfully!'),
      ));
    }
  }

  @override
  void dispose() {
    // Dispose the controllers to avoid memory leaks
    _fullNameController.dispose();
    _addressController.dispose();
    _caseTypeDetailsController.dispose();
    _idCardController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Family Submission Form'),
        backgroundColor: Color(0xFF31511E), // Dark Green from AppTheme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomInputField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _fullNameController, // Pass the controller here
                onSaved: (value) => _fullNameController.text = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomInputField(
                label: 'Address',
                hint: 'Enter your address',
                controller: _addressController, // Pass the controller here
                onSaved: (value) => _addressController.text = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomInputField(
                label: 'Case Type Details',
                hint: 'Describe why you need support',
                maxLines: 4,
                controller: _caseTypeDetailsController, // Pass the controller here
                onSaved: (value) => _caseTypeDetailsController.text = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide details about the case';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomInputField(
                label: 'ID Card Number',
                hint: 'Enter your ID card number',
                controller: _idCardController, // Pass the controller here
                onSaved: (value) => _idCardController.text = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              CustomInputField(
                label: 'Phone Number',
                hint: 'Enter your phone number',
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController, // Pass the controller here
                onSaved: (value) => _phoneNumberController.text = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor:
                      Color(0xFF859F3D), // Olive Green from AppTheme
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
