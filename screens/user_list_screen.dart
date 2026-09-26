import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'add_edit_user_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService api = ApiService();
  late Future<List<User>> _usersFuture;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  Future<List<User>> fetchUsers() async {
    final fetchedUsers = await api.getUsers();
    setState(() {
      users = fetchedUsers;
    });
    return fetchedUsers;
  }

  void toggleFavorite(User user) async {
    user.isFavorite = !user.isFavorite;
    await api.updateUser(user.id!, user);
    setState(() {});
  }

  void editUser(User user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddEditUserScreen(user: user),
      ),
    );
    fetchUsers();
  }

  void deleteUser(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete User"),
        content: Text("Are you sure you want to delete ${user.fullName}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("No")),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Yes")),
        ],
      ),
    );
    if (confirm == true) {
      await api.deleteUser(user.id!);
      fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found"));
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
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
                    trailing: Wrap(
                      spacing: 4,
                      children: [
                        IconButton(
                          icon: Icon(
                            user.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => toggleFavorite(user),
                          tooltip: "Favorite",
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => editUser(user),
                          tooltip: "Edit",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.grey),
                          onPressed: () => deleteUser(user),
                          tooltip: "Delete",
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
