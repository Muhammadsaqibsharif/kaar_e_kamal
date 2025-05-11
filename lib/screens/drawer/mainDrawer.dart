import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaar_e_kamal/routes/route_names.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          _buildListTile(
            context,
            icon: Icons.home,
            title: 'Home',
            routeName: RouteNames.home,
          ),
          _buildListTile(
            context,
            icon: Icons.settings,
            title: 'Theme Settings',
            routeName: RouteNames.themeSettings,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.teal),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  RouteNames.LoginScreen, (Route<dynamic> route) => false);
            },
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF31511E), Color(0xFF859F3D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: const [
          Icon(Icons.account_circle, size: 60, color: Colors.white),
          SizedBox(width: 10),
          Text(
            'Kaar e Kamal',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String routeName}) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, routeName);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
