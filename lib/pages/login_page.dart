import 'package:final_project/auth/auth_service.dart';
import 'package:flutter/material.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //get auth service
  final authService = AuthService();

  //text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //login button pressed
  void login() async {
    //prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    //attemp login
    try{
      await authService.signInWithEmailPassword(email, password);
    }

    //catch any errors
    catch(e) {
      if (mounted){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  //THE FUN PART (builD UI)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          //email
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),

          //password
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
          ),

          const SizedBox(height: 12),

          //button
          ElevatedButton(
            onPressed: login,
             child: const Text("Login"),
          ),

          const SizedBox(height: 12),

          //go to register page  to sign up
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage(),
            )),
            child: const Center(child: Text("Don't have an account? Sign Up"))),
        ],
      ),
    );
  }
}