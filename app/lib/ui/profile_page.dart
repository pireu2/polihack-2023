import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';
import 'package:app/user.dart';
import 'package:app/main.dart';
import 'package:app/ui/home_page.dart';

// Placeholder for the Disabilities widget
class Disabilities extends StatelessWidget {
  final String text;

  const Disabilities({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue, // You can change the color as needed
        borderRadius: BorderRadius.circular(20), // Adjust the radius to get the pill shape
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Adjust text color as needed
      ),
    );
  }
}


class ProfilePage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const ProfilePage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kToolbarHeight),
          Center(
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
              radius: 50,
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'John Doe',
              style: kMediumTextStyle,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: kSmallTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: FutureBuilder<Widget?>(
              future: getDisabilities(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return snapshot.data!;
                  } else {
                    return SizedBox.shrink();
                  }
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Widget?> getDisabilities() async {
    final List<List<dynamic>> result = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$loggedInUser\'',
    );

    if (result.isNotEmpty && result[0].isNotEmpty) {
      if (result[0][4] == 0) {
        return null;
      }
    }

    return Disabilities(
      text: 'Disabilities placeholder text.',
    );
  }
}

