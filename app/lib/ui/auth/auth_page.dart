import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';

import '../auth/login_page.dart';
import '../auth/register_page.dart';

import '../../services/database_helper.dart';

class AuthScreen extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const AuthScreen({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int currentPage = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      LoginPage(dbHelper: widget.dbHelper),
      RegisterPage(dbHelper: widget.dbHelper),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        title: const Text(
          'User Authentication',
          style: kBoldTextStyle,
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: pages[currentPage],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: getPage(currentPage),
      ),
    );
  }

  Widget? getPage(int index){
    if(index == 0){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account? ',
            style: kSmallTextStyle,
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  currentPage = 1;
                });
              },
              child: const Text(
                'Register',
                style: kSmallBlueUnderlinedTextStyle,
              ))
        ],
      );
    }
    else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Have and account? ',
            style: kSmallTextStyle,
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  currentPage = 0;
                });
              },
              child: const Text(
                'Login',
                style: kSmallBlueUnderlinedTextStyle,
              ))
        ],
      );
    }
  }
}
