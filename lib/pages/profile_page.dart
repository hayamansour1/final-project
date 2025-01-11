import 'package:final_project/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  // get auth service
  final authService = AuthService();

  //logout button pressed 
  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {

    //get user email
    final currentEmail = authService.getCurrentUserEamil();

    return  Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          //logout button
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text(currentEmail.toString()),
      ),
    );
  }
}