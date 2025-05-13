import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/widgets/common/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async'; // for Future.delayed

class FamilySubmissionForm extends StatefulWidget {
  @override
  _FamilySubmissionFormState createState() => _FamilySubmissionFormState();
}

class _FamilySubmissionFormState extends State<FamilySubmissionForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _caseTypeDetailsController =
      TextEditingController();
  final TextEditingController _idCardController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isSubmitting = true;
      });

      try {
        final currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not logged in.')),
          );
          setState(() {
            _isSubmitting = false;
          });
          return;
        }

        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (!userDoc.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User information not found.')),
          );
          setState(() {
            _isSubmitting = false;
          });
          return;
        }

        final firstName = userDoc['firstName'] ?? '';
        final lastName = userDoc['lastName'] ?? '';

        await FirebaseFirestore.instance.collection('family_cases').add({
          'submitted_by_uid': currentUser.uid,
          'submitted_by_first_name': firstName,
          'submitted_by_last_name': lastName,
          'full_name': _fullNameController.text.trim(),
          'address': _addressController.text.trim(),
          'case_type_details': _caseTypeDetailsController.text.trim(),
          'id_card_number': _idCardController.text.trim(),
          'phone_number': _phoneNumberController.text.trim(),
          'submitted_at': FieldValue.serverTimestamp(),
        });

        _formKey.currentState!.reset();
        _fullNameController.clear();
        _addressController.clear();
        _caseTypeDetailsController.clear();
        _idCardController.clear();
        _phoneNumberController.clear();

        await Future.delayed(Duration(
            milliseconds: 500)); // Little delay before showing snackbar

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form Submitted Successfully!')),
        );

        await Future.delayed(Duration(seconds: 1)); // Delay before navigating

        if (mounted) {
          Navigator.of(context)
              .pushReplacementNamed('UserHomeScreen2'); // your route
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
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
        title: Text('Family Submission Form '),
        backgroundColor: Color(0xFF31511E),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomInputField(
                    label: 'Full Name',
                    hint: 'Enter full name',
                    controller: _fullNameController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter full name'
                        : null,
                    onSaved: (String? newValue) {},
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    label: 'Address',
                    hint: 'Enter address',
                    controller: _addressController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter address'
                        : null,
                    onSaved: (String? newValue) {},
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    label: 'Case Type Details',
                    hint: 'Describe case',
                    controller: _caseTypeDetailsController,
                    maxLines: 4,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter case details'
                        : null,
                    onSaved: (String? newValue) {},
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    label: 'ID Card Number',
                    hint: 'Enter CNIC number',
                    keyboardType: TextInputType.number,
                    controller: _idCardController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter ID card number'
                        : null,
                    onSaved: (String? newValue) {},
                  ),
                  SizedBox(height: 16),
                  CustomInputField(
                    label: 'Phone Number',
                    hint: 'Enter phone number',
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumberController,
                    onSaved: (String? newValue) {},
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phone number';
                      } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                        return 'Enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitForm,
                    child: Text(_isSubmitting ? 'Submitting...' : 'Submit'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Color(0xFF859F3D),
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
          if (_isSubmitting)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
