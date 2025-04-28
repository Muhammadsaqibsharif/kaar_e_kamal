import 'package:flutter/material.dart';

class UserLeaderboard extends StatefulWidget {
  @override
  State<UserLeaderboard> createState() => _UserLeaderboardState();
}

class _UserLeaderboardState extends State<UserLeaderboard> {
  String selectedFilter = 'Overall Organization';

  List<Map<String, dynamic>> overallLeaderboard = [
    {
      "id": "D001",
      "name": "Emaan Malik",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 50000,
      "donationAchieved": 45000,
    },
    {
      "id": "D002",
      "name": "Zain Raza",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 40000,
      "donationAchieved": 38000,
    },
    {
      "id": "D003",
      "name": "Ayesha Khan",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 60000,
      "donationAchieved": 58000,
    },
    {
      "id": "D004",
      "name": "Bilal Iqbal",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 45000,
      "donationAchieved": 42000,
    },
    {
      "id": "D005",
      "name": "Hina Shah",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 70000,
      "donationAchieved": 68000,
    },
  ];

  List<Map<String, dynamic>> chapterLeaderboard = [
    {
      "id": "D006",
      "name": "Noor Fatima",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 30000,
      "donationAchieved": 28000,
    },
    {
      "id": "D007",
      "name": "Ali Raza",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 25000,
      "donationAchieved": 20000,
    },
    {
      "id": "D008",
      "name": "Taimoor Hassan",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 35000,
      "donationAchieved": 34000,
    },
    {
      "id": "D009",
      "name": "Sara Yousaf",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 27000,
      "donationAchieved": 25000,
    },
    {
      "id": "D010",
      "name": "Fahad Mirza",
      "image": "https://via.placeholder.com/150",
      "donationTarget": 40000,
      "donationAchieved": 39000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final theme = Theme.of(context);

    List<Map<String, dynamic>> leaderboardData =
        selectedFilter == 'Overall Organization'
            ? overallLeaderboard
            : chapterLeaderboard;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Donors',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Leaderboard',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: textColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: theme.brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.grey[200],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedFilter,
                        dropdownColor: theme.scaffoldBackgroundColor,
                        icon: Icon(Icons.arrow_drop_down, color: textColor),
                        onChanged: (newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                          });
                        },
                        items: ['Overall Organization', 'My Chapter']
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: TextStyle(color: textColor)),
                                    ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              /// Leaderboard Cards
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  var donor = leaderboardData[index];
                  double donationPercentage =
                      donor["donationAchieved"] / donor["donationTarget"];

                  Color badgeColor;
                  if (index == 0) {
                    badgeColor = Colors.amber;
                  } else if (index == 1) {
                    badgeColor = Colors.grey;
                  } else if (index == 2) {
                    badgeColor = Color(0xFFCD7F32);
                  } else {
                    badgeColor = Colors.transparent;
                  }

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: theme.cardColor,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(14),
                      leading: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(donor["image"]),
                          ),
                          if (index < 3)
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: badgeColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: badgeColor.withOpacity(0.6),
                                    blurRadius: 6,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(5),
                              child: Icon(Icons.star,
                                  size: 16, color: Colors.white),
                            ),
                        ],
                      ),
                      title: Text(
                        donor["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: textColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: donationPercentage,
                            minHeight: 10,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF31511E),

                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "PKR ${donor["donationAchieved"]} of PKR ${donor["donationTarget"]} donated (${(donationPercentage * 100).toStringAsFixed(1)}%)",
                            style: TextStyle(
                              fontSize: 13,
                              color: textColor?.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
