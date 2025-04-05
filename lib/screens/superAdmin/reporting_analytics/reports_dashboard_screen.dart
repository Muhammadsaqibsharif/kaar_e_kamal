import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReportsDashboardScreen extends StatefulWidget {
  @override
  _ReportsDashboardScreenState createState() => _ReportsDashboardScreenState();
}

class _ReportsDashboardScreenState extends State<ReportsDashboardScreen> {
  final List<String> chapters = [
    'Overall',
    'Lahore',
    'Gujranwala',
    'Islamabad'
  ];
  final List<String> timeFilters = [
    '1 Day',
    '7 Days',
    '1 Month',
    '3 Months',
    '1 Year'
  ];

  final Map<String, Map<String, Map<String, double>>> chapterStats = {
    'Lahore': {
      '1 Day': {'Donations': 20000.0, 'Active Members': 20, 'Activities': 1},
      '7 Days': {'Donations': 140000.0, 'Active Members': 100, 'Activities': 5},
      '1 Month': {
        'Donations': 600000.0,
        'Active Members': 300,
        'Activities': 10
      },
      '3 Months': {
        'Donations': 900000.0,
        'Active Members': 400,
        'Activities': 12
      },
      '1 Year': {
        'Donations': 1200000.0,
        'Active Members': 450,
        'Activities': 15
      },
    },
    'Gujranwala': {
      '1 Day': {'Donations': 15000.0, 'Active Members': 10, 'Activities': 1},
      '7 Days': {'Donations': 90000.0, 'Active Members': 60, 'Activities': 3},
      '1 Month': {
        'Donations': 400000.0,
        'Active Members': 150,
        'Activities': 8
      },
      '3 Months': {
        'Donations': 700000.0,
        'Active Members': 200,
        'Activities': 9
      },
      '1 Year': {
        'Donations': 800000.0,
        'Active Members': 250,
        'Activities': 10
      },
    },
    'Islamabad': {
      '1 Day': {'Donations': 25000.0, 'Active Members': 15, 'Activities': 1},
      '7 Days': {'Donations': 120000.0, 'Active Members': 80, 'Activities': 4},
      '1 Month': {
        'Donations': 500000.0,
        'Active Members': 200,
        'Activities': 7
      },
      '3 Months': {
        'Donations': 900000.0,
        'Active Members': 300,
        'Activities': 10
      },
      '1 Year': {
        'Donations': 1000000.0,
        'Active Members': 350,
        'Activities': 12
      },
    },
  };

  String? selectedChapter;
  String? selectedTimeFilter;
  Map<String, double>? displayedStats;

  void showStats() {
    setState(() {
      if (selectedChapter != null && selectedTimeFilter != null) {
        if (selectedChapter == 'Overall') {
          displayedStats = _calculateOverallStats(selectedTimeFilter!);
        } else {
          displayedStats = chapterStats[selectedChapter!]?[selectedTimeFilter!];
        }
      } else {
        displayedStats = null;
      }
    });
  }

  Map<String, double> _calculateOverallStats(String timeFilter) {
    Map<String, double> overallStats = {
      'Donations': 0,
      'Active Members': 0,
      'Activities': 0
    };

    for (var chapter in chapterStats.values) {
      if (chapter.containsKey(timeFilter)) {
        chapter[timeFilter]!.forEach((key, value) {
          overallStats[key] = (overallStats[key] ?? 0) + value;
        });
      }
    }

    return overallStats;
  }

  Future<void> downloadStats() async {
    if (displayedStats != null) {
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/report.csv');

      // CSV header
      String content = 'Metric,Value\n';

      // Adding data
      displayedStats!.forEach((key, value) {
        content += '$key,$value\n';
      });

      await file.writeAsString(content);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report saved to ${file.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporting & Analytics'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Time Range',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedTimeFilter,
                hint: Text('Select time range'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTimeFilter = newValue;
                  });
                },
                items:
                    timeFilters.map<DropdownMenuItem<String>>((String filter) {
                  return DropdownMenuItem<String>(
                    value: filter,
                    child: Text(filter),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Chapter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedChapter,
                hint: Text('Select Chapter'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedChapter = newValue;
                  });
                },
                items: chapters.map<DropdownMenuItem<String>>((String chapter) {
                  return DropdownMenuItem<String>(
                    value: chapter,
                    child: Text(chapter),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: showStats,
                child: Text('Show'),
              ),
              const SizedBox(height: 16),
              if (displayedStats != null)
                ...displayedStats!.entries
                    .map(
                      (entry) => Text('${entry.key}: ${entry.value}'),
                    )
                    .toList(),
              const SizedBox(height: 16),
              if (displayedStats != null)
                ElevatedButton(
                  onPressed: downloadStats,
                  child: Text('Download Report'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
