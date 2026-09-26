import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';


class FavoriteUserScreen extends StatefulWidget {
  const FavoriteUserScreen({super.key, required List favoriteUsers});

  @override
  State<FavoriteUserScreen> createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavoriteUserScreen> {
  final ApiService api = ApiService();
  List<User> favoriteUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  // Fetch users from API and filter favorites
  Future<void> loadFavorites() async {
    setState(() {
      isLoading = true;
    });
    final users = await api.getUsers();
    setState(() {
      favoriteUsers = users.where((u) => u.isFavorite == true).toList();
      isLoading = false;
    });
  }

  // Toggle favorite status
  void toggleFavorite(User user) async {
    user.isFavorite = false; // Remove from favorite
    await api.updateUser(user.id!, user);
    loadFavorites(); // Refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Users")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favoriteUsers.isEmpty
          ? const Center(child: Text("No favorite users yet!"))
          : ListView.builder(
        itemCount: favoriteUsers.length,
        itemBuilder: (context, index) {
          final user = favoriteUsers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.fullName.isNotEmpty
                    ? user.fullName[0].toUpperCase()
                    : "?"),
              ),
              title: Text(user.fullName),
              subtitle: Text("${user.email}\n${user.mobile}"),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () => toggleFavorite(user),
                tooltip: "Remove from favorites",
              ),
            ),
          );
        },
      ),
    );
  }
}
