import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/ui/main_page.dart';
import '../../services/database_helper.dart';

class RegisterPage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const RegisterPage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedRole = '';
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 36,
            ),
            const Text(
              'Register',
              style: kBigBoldTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _errorMessage,
              style: kSmallRedTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _usernameController,
              style: kSmallTextStyle,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: kSmallTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 5.0,
                      style: BorderStyle.solid,
                    )),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              style: kSmallTextStyle,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: kSmallTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 5.0,
                      style: BorderStyle.solid,
                    )),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: kSmallTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 5.0,
                      style: BorderStyle.solid,
                    )),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _confirmpasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm password',
                labelStyle: kSmallTextStyle,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 5.0,
                      style: BorderStyle.solid,
                    )),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                }
              },
              decoration: InputDecoration(
                labelText: 'Role',
                labelStyle: kSmallTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: kPrimaryColor,
                    width: 5.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              items: <String>['Volunteer', 'Disabled'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: kSmallTextStyle),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: () {
                // Handle login button click
                registerUser();
              },
              child: const Text(
                'Register',
                style: kSmallTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmpasswordController.text;
    final email = _emailController.text;

    if (username == '') {
      setState(() {
        _errorMessage = 'Username cannot be empty';
      });
      return;
    }
    if (email == '') {
      setState(() {
        _errorMessage = 'Email cannot be empty';
      });
      return;
    }
    if (password == '') {
      setState(() {
        _errorMessage = 'Password cannot be empty';
      });
      return;
    }
    if (confirmPassword == '') {
      setState(() {
        _errorMessage = 'Confirm password cannot be empty';
      });
      return;
    }
    if (password != confirmPassword) {
      setState(() {
        _errorMessage = 'Passwords do not match';
      });
      return;
    }
    if (!isValidEmail(email)) {
      setState(() {
        _errorMessage = 'Invalid email';
      });
      return;
    }
    if (_selectedRole == '') {
      setState(() {
        _errorMessage = 'Please select a role';
      });
      return;
    }

    int role;
    if (_selectedRole == 'Volunteer') {
      role = 0;
    } else {
      role = 1;
    }

    final checkUsername = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$username\'',
    );

    if (checkUsername.isNotEmpty) {
      setState(() {
        _errorMessage = 'Username already exists';
      });
      return;
    }

    String insertQuery =
        'INSERT INTO users (username, password, email, role) VALUES (@username, @password, @email, @role)';
    Map<String, dynamic> insertValues = {
      'username': username,
      'password': password,
      'email': email,
      'role': role
    };
    // Use the DatabaseHelper to execute an INSERT query
    final int result = await widget.dbHelper.executeInsert(
      insertQuery,
      insertValues,
    );

    if (result != -1) {
      // Successful registration, handle accordingly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            dbHelper: widget.dbHelper,
          ), // Replace MainPage with the actual widget for your main page
        ),
      );
    } else {
      // Handle failed registration (show an error message, etc.)
      setState(() {
        _errorMessage = 'Registration failed';
      });
    }
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
