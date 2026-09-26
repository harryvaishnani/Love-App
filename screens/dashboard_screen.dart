import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Add User', 'icon': Icons.person_add_alt_1, 'route': '/add_edit'},
      {'title': 'User List', 'icon': Icons.people_alt, 'route': '/user_list'},
      {'title': 'Favorite Users', 'icon': Icons.favorite, 'route': '/favorite'},
      {'title': 'About Us', 'icon': Icons.info_outline, 'route': '/about'},
    ];

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text("Matrimony Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              color: Colors.grey[300],
              elevation: 4,
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, item['route']),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 50, color: Colors.black87),
                    const SizedBox(height: 12),
                    Text(item['title'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
