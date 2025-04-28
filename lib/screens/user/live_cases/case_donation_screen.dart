import 'package:flutter/material.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class CaseDonationScreen extends StatelessWidget {
  final List<CaseModel> cases = [
    CaseModel(
      id: '1',
      title: 'Medical Aid for Ali',
      imagePath: 'assets/Images/1.jpg',
      details: 'Ali needs urgent surgery and requires PKR 500,000.',
      requiredAmount: 500000,
      collectedAmount: 150000,
    ),
    CaseModel(
      id: '2',
      title: 'Education Support for Sara',
      imagePath: 'assets/Images/2.jpg',
      details: 'Sara needs help for school tuition fee for the year.',
      requiredAmount: 200000,
      collectedAmount: 75000,
    ),
    CaseModel(
      id: '3',
      title: 'Flood Relief for Village',
      imagePath: 'assets/Images/3.jpg',
      details: 'Help provide food, shelter, and clothes to flood victims.',
      requiredAmount: 1000000,
      collectedAmount: 670000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate for a Case'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final caseItem = cases[index];
          double progress =
              (caseItem.collectedAmount / caseItem.requiredAmount).clamp(0, 1);
          double remainingAmount =
              caseItem.requiredAmount - caseItem.collectedAmount;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  GestureDetector(
                    onTap: () => _showCaseDetailsDialog(context, caseItem),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        caseItem.imagePath,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  // Title + Slider + Amounts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          caseItem.title,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: const Color(0xFF31511E),
                            inactiveTrackColor: Colors.grey[300],
                            thumbColor: const Color(0xFF859F3D),
                            overlayColor:
                                const Color(0xFF31511E).withOpacity(0.2),
                            trackHeight: 6,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 0),
                            overlayShape:
                                const RoundSliderOverlayShape(overlayRadius: 0),
                          ),
                          child: Slider(
                            value: progress,
                            onChanged: null,
                          ),
                        ),
                        Text(
                          'Collected: PKR ${caseItem.collectedAmount.toStringAsFixed(0)} / PKR ${caseItem.requiredAmount.toStringAsFixed(0)} (${(progress * 100).toStringAsFixed(1)}%)',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          'Remaining: PKR ${remainingAmount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Donate Button - Centered Vertically
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center button vertically
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.DonationManagementScreen,
                            arguments: caseItem,
                          );
                        },
                        child: const Text(
                          'Donate',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCaseDetailsDialog(BuildContext context, CaseModel caseItem) {
    double progress =
        (caseItem.collectedAmount / caseItem.requiredAmount).clamp(0, 1);
    double remainingAmount = caseItem.requiredAmount - caseItem.collectedAmount;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          caseItem.title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(caseItem.imagePath, fit: BoxFit.cover),
              ),
              const SizedBox(height: 16),
              Text(
                caseItem.details,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: const Color(0xFF31511E),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: const Color(0xFF859F3D),
                  overlayColor: const Color(0xFF31511E).withOpacity(0.2),
                  trackHeight: 6,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 12),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 24),
                ),
                child: Slider(
                  value: progress,
                  onChanged: null,
                ),
              ),
              Text(
                'Collected: PKR ${caseItem.collectedAmount.toStringAsFixed(0)} / PKR ${caseItem.requiredAmount.toStringAsFixed(0)} (${(progress * 100).toStringAsFixed(1)}%)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Remaining: PKR ${remainingAmount.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
            ),
            child: const Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class CaseModel {
  final String id;
  final String title;
  final String imagePath;
  final String details;
  final double requiredAmount;
  final double collectedAmount;

  CaseModel({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.details,
    required this.requiredAmount,
    required this.collectedAmount,
  });
}
