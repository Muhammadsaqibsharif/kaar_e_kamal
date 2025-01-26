import 'package:flutter/material.dart';

Widget getBadgeIcon(String badgeName) {
  switch (badgeName) {
    case 'First-Time Donor Badge':
      return Icon(Icons.star_border, color: Colors.green);
    case 'Frequent Donor Badge':
      return Icon(Icons.star_half, color: Colors.yellow);
    case 'Top Donor Badge':
      return Icon(Icons.star, color: Colors.orange);
    default:
      return Icon(Icons.help, color: Colors.grey);
  }
}
