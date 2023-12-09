import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';

import '../../services/database_helper.dart';

class AuthScreen extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const AuthScreen({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late DatabaseHelper _databaseHelper; // Declare an instance of DatabaseHelper

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Handle login button click
                loginUser();
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Handle register button click
                registerUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    // Use the DatabaseHelper to execute queries
    final result = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$username\' AND password = \'$password\'',
    );

    if (result.isNotEmpty) {
      // Successful login, navigate to the next screen or perform any other action
      debugPrint('Login successful');
    } else {
      // Handle failed login (show an error message, etc.)
      debugPrint('Invalid credentials');
    }
  }

  Future<void> registerUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;

    String insertQuery =
        'INSERT INTO users (username, password, email) VALUES (@username, @password, @email)';
    Map<String, dynamic> insertValues = {
      'username': username,
      'password': password,
      'email': email,
    };
    // Use the DatabaseHelper to execute an INSERT query
    final int result = await widget.dbHelper.executeInsert(
      insertQuery,
      insertValues,
    );

    if (result != -1) {
      // Successful registration, handle accordingly
      debugPrint('Registration successful');
    } else {
      // Handle failed registration (show an error message, etc.)
      debugPrint('Registration failed');
    }
  }
}
