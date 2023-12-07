import "package:flutter/material.dart";

import "../components/custom_navigation_drawer.dart";
import "../home/home_screen.dart";

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Image.network(
          "https://hips.hearstapps.com/hmg-prod/images/mh-205-0031403r-1-1564520543.jpg?crop=0.553xw:1.00xh;0.328xw,0&resize=640:*"),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
