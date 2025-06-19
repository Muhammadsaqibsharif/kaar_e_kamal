import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionsScreen extends StatefulWidget {
  @override
  _PredictionsScreenState createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  // final String baseUrl = 'http://192.168.0.106:5000';
  final String baseUrl = 'http://192.168.0.106:8000';
  // final String baseUrl = 'http://10.0.2.2:5000';
  // final String baseUrl = 'http://127.0.0.1:5000/';

  String? selectedMember;
  List<dynamic> forecast = [];

  Future<List<String>> fetchMembers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/members'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print('Members fetched: ${data}');

        return List<String>.from(data['members']
            .where((e) => e != null && e.toString().trim().isNotEmpty)
            .map((e) => e.toString()));
      } else {
        print('HTTP error: ${response.statusCode}');
        throw Exception('Failed to load members');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to connect to server');
    }
  }

  Future<void> getForecast(String memberName) async {
    try {
      final url = Uri.parse('$baseUrl/forecast/$memberName');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          forecast = data['forecast'] ?? [];
        });
      } else {
        setState(() {
          forecast = [];
        });
        print('Error fetching forecast: ${response.body}');
      }
    } catch (e) {
      setState(() {
        forecast = [];
      });
      print('Error contacting server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<String>>(
              future: fetchMembers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Loading members...'),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text(
                    'Failed to load members',
                    style: TextStyle(color: Colors.red),
                  );
                } else if (snapshot.hasData) {
                  final members = snapshot.data!;
                  return DropdownSearch<String>(
                    items: members,
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Select Member',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedMember = value;
                          forecast.clear();
                        });
                        getForecast(value);
                      }
                    },
                    selectedItem: selectedMember,
                  );
                } else {
                  return const Text('No members available.');
                }
              },
            ),
            const SizedBox(height: 20),
            forecast.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: forecast.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          child: ListTile(
                            title: Text(
                              'Prediction of month ${index + 1}: ${double.tryParse(forecast[index].toString())?.toStringAsFixed(2) ?? forecast[index]}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : selectedMember == null
                    ? Container()
                    : const Text(
                        'No predictions available.',
                        style: TextStyle(fontSize: 16),
                      ),
          ],
        ),
      ),
    );
  }
}
