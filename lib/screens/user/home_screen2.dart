import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';
import 'package:kaar_e_kamal/screens/drawer/mainDrawer.dart';

class UserHomeScreen2 extends StatelessWidget {
  const UserHomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'Home',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gradient Banner with Rounded Corners
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              child: Container(
                height: 250.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF31511E), // Dark Green
                      Color(0xFF859F3D), // Olive Green
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/logo/KK Urdu Golden.png",
                        height: 100,
                        width: 100,
                      ),
                      Text(
                        'Your kindness can change lives!',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Make a difference today with your generosity.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteNames.DonationManagementScreen);
                          // Navigate to Donation Management
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text('Donate Now'),
                          //   ),
                          // );
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              'Donate Now',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Grid Layout for Features
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                children: [
                  _buildFeatureTile(context,
                      title: 'Donation',
                      icon: Icons.volunteer_activism, onTap: () {
                    Navigator.pushNamed(
                        context, RouteNames.DonationManagementScreen);
                  }),
                  _buildFeatureTile(context,
                      title: 'History', icon: Icons.history, onTap: () {
                    Navigator.pushNamed(
                        context, RouteNames.DonationHistoryScreen);
                  }),
                  _buildFeatureTile(context,
                      title: 'Transparency', icon: Icons.fact_check, onTap: () {
                    Navigator.pushNamed(context, RouteNames.TransparencyScreen);
                  }),
                  _buildFeatureTile(context,
                      title: 'Rewards', icon: Icons.emoji_events, onTap: () {
                    Navigator.pushNamed(context, RouteNames.GamificationScreen);
                  }),
                  _buildFeatureTile(context, title: 'Social', icon: Icons.share,
                      onTap: () {
                    Navigator.pushNamed(context, RouteNames.PostSharingScreen);
                  }),
                  _buildFeatureTile(context,
                      title: 'Chatbot', icon: Icons.chat_bubble, onTap: () {
                    Navigator.pushNamed(
                        context, RouteNames.ChatbotInteractionScreen);
                  }),
                  _buildFeatureTile(context,
                      title: 'Families',
                      icon: Icons.family_restroom, onTap: () {
                    Navigator.pushNamed(
                        context, RouteNames.FamilySubmissionForm);
                  }),
                  _buildFeatureTile(context,
                      title: 'Blood', icon: Icons.bloodtype, onTap: () {
                    Navigator.pushNamed(context, RouteNames.BloodRequestScreen);
                  }),
                  _buildFeatureTile(context,
                      title: 'Profile', icon: Icons.person, onTap: () {
                    Navigator.pushNamed(context, RouteNames.UserProfileScreen);
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Posts',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            CarouselSlider(
              items: [
                _buildCarouselCard(
                  context,
                  title: 'Education Support',
                  description:
                      'Providing access to quality education for children.',
                  icon: Icons.school,
                ),
                _buildCarouselCard(
                  context,
                  title: 'Medical Aid',
                  description:
                      'Helping those in need with essential medical care.',
                  icon: Icons.local_hospital,
                ),
                _buildCarouselCard(
                  context,
                  title: 'Food Distribution',
                  description:
                      'Ensuring no one sleeps hungry in our community.',
                  icon: Icons.fastfood,
                ),
                _buildCarouselCard(
                  context,
                  title: 'Emergency Relief',
                  description:
                      'Providing quick support during crises and disasters.',
                  icon: Icons.warning,
                ),
              ],
              options: CarouselOptions(
                height: 250.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildFeatureTile(BuildContext context,
  //     {required String title, required IconData icon}) {
  //   final theme = Theme.of(context);
  //   return GestureDetector(
  //     onTap: () {
  //       // Add navigation logic here
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(12.0),
  //       decoration: BoxDecoration(
  //         color: Colors.white, // Background color changed to white
  //         borderRadius: BorderRadius.circular(12.0),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.black.withOpacity(0.1),
  //             blurRadius: 5.0,
  //             spreadRadius: 2.0,
  //           ),
  //         ],
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(icon, size: 30.0, color: theme.primaryColor),
  //           const SizedBox(height: 5.0),
  //           Text(
  //             title,
  //             style: theme.textTheme.bodySmall?.copyWith(
  //               fontWeight: FontWeight.bold,
  //               color: theme.primaryColor,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildFeatureTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    required void Function()? onTap, // Add onTap as a parameter
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap, // Use the passed onTap function
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white, // Background color changed to white
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30.0, color: theme.primaryColor),
            const SizedBox(height: 5.0),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.share, size: 20.0, color: Colors.white),
              ],
            ),
            Icon(icon, size: 40.0, color: Colors.white),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
