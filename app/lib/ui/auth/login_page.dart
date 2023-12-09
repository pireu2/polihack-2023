import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/ui/main_page.dart';
import '../../services/database_helper.dart';

class LoginPage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const LoginPage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              'Login',
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: () {
                // Handle login button click
                loginUser();
              },
              child: const Text(
                'Login',
                style: kSmallTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username == '') {
      setState(() {
        _errorMessage = 'Username cannot be empty';
      });
      return;
    }
    if (password == '') {
      setState(() {
        _errorMessage = 'Password cannot be empty';
      });
      return;
    }

    // Use the DatabaseHelper to execute queries
    final result = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$username\' AND password = \'$password\'',
    );

    if (result.isNotEmpty) {
      // Successful login, navigate to the next screen or perform any other action
      debugPrint('Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            dbHelper: widget.dbHelper,
          ), // Replace MainPage with the actual widget for your main page
        ),
      );
    } else {
      // Handle failed login (show an error message, etc.)
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }
}
