import 'package:flutter/material.dart';

Widget _buildCarouselCard(
  BuildContext context, {
  required String image,
  required String caption,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Stack(
        children: [
          // Full-size image
          Image.asset(
            image,
            width: 350,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          // Caption overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                caption,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          // Share button
          Positioned(
            top: 8.0,
            right: 8.0,
            child: GestureDetector(
              onTap: () {
                print('Share button clicked for: $caption');
              },
              child: const Icon(Icons.share, size: 20.0, color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildCarousel(BuildContext context) {
  final List<Map<String, String>> posts = [
    {
      'image': 'assets/Images/1.jpg',
      'caption': 'Join me in supporting this cause by donating today!',
    },
    {
      'image': 'assets/Images/2.jpg',
      'caption': 'Every little bit counts! Let\'s make a difference.',
    },
    {
      'image': 'assets/Images/3.jpg',
      'caption': 'I just made my donation. Will you join me?',
    },
  ];

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: posts.map((post) {
        return _buildCarouselCard(
          context,
          image: post['image']!,
          caption: post['caption']!,
        );
      }).toList(),
    ),
  );
}
