import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          children: [
            // App Logo
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.pinkAccent,
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // App Info Card
            _infoCard(
              icon: Icons.app_registration,
              title: "Matrimony App",
              content:
              "Version 1.0\nThis app is developed as a student project for BCA/B.Sc. (IT) Semester 5 coursework.",
              color: Colors.pinkAccent,
            ),
            const SizedBox(height: 15),

            // Developer Info Card
            _infoCard(
              icon: Icons.person,
              title: "Developer",
              content: "Tirth Manek",
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(height: 15),

            // Contact Info Card
            _infoCard(
              icon: Icons.email,
              title: "Contact",
              content: "email@example.com",
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 15),

            // Mission Card
            _infoCard(
              icon: Icons.flag,
              title: "Our Mission",
              content:
              "To help people find their perfect life partner with ease and trust.",
              color: Colors.greenAccent.shade400,
            ),
            const SizedBox(height: 15),

            // Vision Card
            _infoCard(
              icon: Icons.visibility,
              title: "Our Vision",
              content:
              "To become the most reliable and user-friendly Matrimony platform.",
              color: Colors.blueAccent.shade400,
            ),
          ],
        ),
      ),
    );
  }

  // Widget for cards
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
