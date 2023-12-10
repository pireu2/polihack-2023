import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';
import 'package:app/user.dart';
import 'package:app/ui/explore_page.dart';
import 'dart:math';

class ProfilePage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const ProfilePage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return
        FutureBuilder<Widget?>(
          future: getProfile(MediaQuery.of(context).size.width),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const SizedBox();
            }
          },
    );
  }

  Future<bool> isVolunteer() async {
    final user = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$loggedInUser\'',
    );
    if (user.isNotEmpty && user[0].isNotEmpty) {
      if (user[0][4] == 0) {
        return true;
      }
    }
    return false;
  }

  Future<Widget?> getProfile(double width) async {
    bool volunteer = await isVolunteer();
    if (volunteer) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: width - 20, // Specify the desired width
                      height: width - 20, // Specify the desired height
                      child: Image.asset(
                        'assets/images/volunteers/3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.0, // Adjust the bottom distance as needed
                    left: 8.0, // Adjust the left distance as needed
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      // Adjust the padding as needed
                      decoration: BoxDecoration(
                        color: kBlackColor.withOpacity(0.6),
                        // Adjust the background color and opacity as needed
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                      ),
                      child: const Text(
                        'Ana, 22 ani',
                        style: kBigWhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Information',
                style: kSmallMediumTextStyle,
                textAlign: TextAlign.start,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.person_add_rounded,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Student',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.add_box_rounded,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Empathy, Communication',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Cluj Napoca, Romania',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.star,
                    color: kAccentColor,
                  ),
                  Icon(
                    Icons.star,
                    color: kAccentColor,
                  ),
                  Icon(
                    Icons.star,
                    color: kAccentColor,
                  ),
                  Icon(
                    Icons.star,
                    color: kAccentColor,
                  ),
                  Icon(
                    Icons.star_half,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '4.5 (10 reviews)',
                    style: kSmallTextStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Recent Activity',
                style: kSmallMediumTextStyle,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/disabled/1.jpg').image,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Alex',
                        style: kSmallTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/disabled/2.jpg').image,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Mihai',
                        style: kSmallTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/disabled/5.jpg').image,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Andrei',
                        style: kSmallTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: width - 20, // Specify the desired width
                      height: width - 20, // Specify the desired height
                      child: Image.asset(
                        'assets/images/disabled/4.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.0, // Adjust the bottom distance as needed
                    left: 8.0, // Adjust the left distance as needed
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      // Adjust the padding as needed
                      decoration: BoxDecoration(
                        color: kBlackColor.withOpacity(0.6),
                        // Adjust the background color and opacity as needed
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                      ),
                      child: const Text(
                        'Alex, 24 ani',
                        style: kBigWhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Information',
                style: kSmallMediumTextStyle,
                textAlign: TextAlign.start,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.wheelchair_pickup,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Down Syndrome',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.add_box_rounded,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Affectionate, Friendly, Kind',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Cluj Napoca, Romania',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.post_add,
                    color: kAccentColor,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '12 posts',
                    style: kSmallTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Recent Activity',
                style: kSmallMediumTextStyle,
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        Image.asset('assets/images/volunteers/1.jpg').image,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Alexandra',
                        style: kSmallTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        Image.asset('assets/images/volunteers/2.jpg').image,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Mihai',
                        style: kSmallTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        Image.asset('assets/images/volunteers/5.jpg').image,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Andrei',
                        style: kSmallTextStyle,
                      )
                    ],
                  ),
                ],
              ),

            ],
          ),
        ),
      );
    }
  }

  Future<Widget?> getHelpedButton(int postId) async {
    final List<List<dynamic>> result = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$loggedInUser\'',
    );
    int loggedInUserId = result[0][0];

    if (result.isNotEmpty && result[0].isNotEmpty) {
      if (result[0][4] == 1) {
        return null;
      }
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kSecondaryColor,
        minimumSize: const Size(50, 30),
      ),
      onPressed: () {
        widget.dbHelper.executeQuery(
          'UPDATE posts SET taken = true, volunteer_id = $loggedInUserId WHERE id = $postId',
        );
        setState(() {});
      },
      child: const Text(
        'Help',
        style: kSmallTextStyle,
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    String month = dateTime.month.toString();
    String day = dateTime.day.toString();
    String year = dateTime.year.toString();
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');

    return '$year-$month-$day $hour:$minute:$second';
  }




  Future<List<List<dynamic>>> getPosts() async {
    final posts = await widget.dbHelper.executeQuery(
      '''SELECT posts.id,title,description,created_at,taken, u.username
         FROM posts
         JOIN users u on posts.author_id = u.id
         WHERE posts.author_id = (SELECT id FROM users WHERE username = '$loggedInUser')
         ORDER BY created_at DESC
         LIMIT 5;
    ''',
    );
    return posts;
  }
}
