import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import 'add_edit_user_screen.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late User user;
  final ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  void deleteUser() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Are you sure want to delete this user?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("No")),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("Yes")),
        ],
      ),
    );
    if (confirm == true) {
      await api.deleteUser(user.id!);
      Navigator.pop(context, true);
    }
  }

  void toggleFavorite() async {
    user.isFavorite = !user.isFavorite;
    await api.updateUser(user.id!, user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        actions: [
          IconButton(
            icon: Icon(user.isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedUser = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddEditUserScreen(user: user)),
              );
              if (updatedUser != null) {
                setState(() => user = updatedUser);
              }
            },
          ),
          IconButton(icon: const Icon(Icons.delete), onPressed: deleteUser),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            detailItem("Full Name", user.fullName),
            detailItem("Email", user.email),
            detailItem("Mobile", user.mobile),
            detailItem("Date of Birth", user.dob),
            detailItem("City", user.city),
            detailItem("Gender", user.gender),
            detailItem("Hobbies", user.hobbies),
          ],
        ),
      ),
    );
  }

  Widget detailItem(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(title: Text(label), subtitle: Text(value)),
    );
  }
}
