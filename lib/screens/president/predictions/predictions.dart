// import 'package:flutter/material.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PredictionsScreen extends StatefulWidget {
//   @override
//   _PredictionsScreenState createState() => _PredictionsScreenState();
// }

// class _PredictionsScreenState extends State<PredictionsScreen> {
//   // final String baseUrl = 'http://192.168.0.106:5000';
//   final String baseUrl = 'http://192.168.0.106:8000';
//   // final String baseUrl = 'http://10.0.2.2:5000';
//   // final String baseUrl = 'http://127.0.0.1:5000/';

//   String? selectedMember;
//   List<dynamic> forecast = [];

//   Future<List<String>> fetchMembers() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/members'));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         print('Members fetched: ${data}');

//         return List<String>.from(data['members']
//             .where((e) => e != null && e.toString().trim().isNotEmpty)
//             .map((e) => e.toString()));
//       } else {
//         print('HTTP error: ${response.statusCode}');
//         throw Exception('Failed to load members');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Failed to connect to server');
//     }
//   }

//   Future<void> getForecast(String memberName) async {
//     try {
//       final url = Uri.parse('$baseUrl/forecast/$memberName');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
//           forecast = data['forecast'] ?? [];
//         });
//       } else {
//         setState(() {
//           forecast = [];
//         });
//         print('Error fetching forecast: ${response.body}');
//       }
//     } catch (e) {
//       setState(() {
//         forecast = [];
//       });
//       print('Error contacting server: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Predictions'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             FutureBuilder<List<String>>(
//               future: fetchMembers(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Column(
//                     children: [
//                       CircularProgressIndicator(),
//                       SizedBox(height: 16),
//                       Text('Loading members...'),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return const Text(
//                     'Failed to load members',
//                     style: TextStyle(color: Colors.red),
//                   );
//                 } else if (snapshot.hasData) {
//                   final members = snapshot.data!;
//                   return DropdownSearch<String>(
//                     items: members,
//                     popupProps: const PopupProps.menu(
//                       showSearchBox: true,
//                     ),
//                     dropdownDecoratorProps: const DropDownDecoratorProps(
//                       dropdownSearchDecoration: InputDecoration(
//                         labelText: 'Select Member',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     onChanged: (value) {
//                       if (value != null) {
//                         setState(() {
//                           selectedMember = value;
//                           forecast.clear();
//                         });
//                         getForecast(value);
//                       }
//                     },
//                     selectedItem: selectedMember,
//                   );
//                 } else {
//                   return const Text('No members available.');
//                 }
//               },
//             ),
//             const SizedBox(height: 20),
//             forecast.isNotEmpty
//                 ? Expanded(
//                     child: ListView.builder(
//                       itemCount: forecast.length,
//                       itemBuilder: (context, index) {
//                         return Card(
//                           color:
//                               Theme.of(context).primaryColor.withOpacity(0.1),
//                           child: ListTile(
//                             title: Text(
//                               'Prediction of month ${index + 1}: ${double.tryParse(forecast[index].toString())?.toStringAsFixed(2) ?? forecast[index]}',
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 : selectedMember == null
//                     ? Container()
//                     : const Text(
//                         'No predictions available.',
//                         style: TextStyle(fontSize: 16),
//                       ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionsScreen extends StatefulWidget {
  @override
  _PredictionsScreenState createState() => _PredictionsScreenState();
}

class _PredictionsScreenState extends State<PredictionsScreen> {
  final String baseUrl = 'http://192.168.43.7:8000';
  double totalTargetSum = 0.0;
  bool isComputing = true;

  String? selectedMember;
  List<dynamic> forecast = [];

  @override
  void initState() {
    super.initState();
    updateAllUsersWithTargets();
  }

  /// Fetch list of members from the API
  Future<List<String>> fetchMembers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/members'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

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

  /// Fetch forecast for selected member and update UI + Firestore
  Future<void> getForecast(String memberName) async {
    try {
      final url = Uri.parse('$baseUrl/forecast/$memberName');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final predictions = data['forecast'] ?? [];

        setState(() {
          forecast = predictions;
        });

        if (predictions.isNotEmpty) {
          final firstPrediction =
              double.tryParse(predictions[0].toString()) ?? 0.0;
          await updateMonthlyTargetInFirestore(memberName, firstPrediction);
        }
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

  /// Update monthly_target in Firestore for a user matching fullName
  Future<void> updateMonthlyTargetInFirestore(
      String fullName, double target) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final nameParts = fullName.split(' ');
      if (nameParts.length < 2) return;

      final first = nameParts.first;
      final last = nameParts.sublist(1).join(' ');

      final snapshot = await firestore
          .collection('users')
          .where('firstName', isEqualTo: first)
          .where('lastName', isEqualTo: last)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          await doc.reference.update({'monthly_target': target});
          print('Target updated for ${doc.id}');
        }
      } else {
        print('No user found in Firestore for $fullName');
      }
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }

  /// Loop through all members and update Firestore
  Future<void> updateAllUsersWithTargets() async {
    try {
      setState(() => isComputing = true); // start loading

      final members = await fetchMembers();
      double runningTotal = 0.0;

      for (final member in members) {
        final url = Uri.parse('$baseUrl/forecast/$member');
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final predictions = data['forecast'] ?? [];

          if (predictions.isNotEmpty) {
            final firstPrediction =
                double.tryParse(predictions[0].toString()) ?? 0.0;
            runningTotal += firstPrediction;

            await updateMonthlyTargetInFirestore(
                normalizeName(member), firstPrediction);
          }
        } else {
          print('Failed forecast for $member');
        }
      }

      setState(() {
        totalTargetSum = runningTotal;
        isComputing = false; // stop loading
      });

      print('✅ All users updated with monthly targets.');
    } catch (e) {
      print('Error updating all users: $e');
      setState(() => isComputing = false);
    }
  }

  /// Capitalize and normalize member names from API
  String normalizeName(String name) {
    return name
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictions'),
      ),
      body: Stack(
        children: [
          Padding(
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Monthly Target Sum: ${totalTargetSum.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Select a member to view predictions:',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          DropdownSearch<String>(
                            items: members,
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                            ),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
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
                          ),
                        ],
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
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
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
          if (isComputing)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Computing total monthly donation target...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 6,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
