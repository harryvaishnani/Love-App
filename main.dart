import 'package:flutter/material.dart';
import 'screens/about_us_screen.dart';
import 'screens/add_edit_user_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/favorite_user_screen.dart';
import 'screens/user_list_screen.dart';

void main() => runApp(MatrimonyApp());

class MatrimonyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matrimony App',
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/add_edit': (context) => AddEditUserScreen(),
        '/user_list': (context) => UserListScreen(),
        '/favorite': (context) => FavoriteUserScreen(favoriteUsers: []),
        '/about': (context) => AboutUsScreen(),
      },
    );
  }
}
