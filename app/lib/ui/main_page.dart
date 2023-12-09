import 'package:app/ui/explore_page.dart';
import 'package:app/ui/home_page.dart';
import 'package:app/ui/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/ui/add_post_page.dart';
import 'package:app/services/database_helper.dart';

class MainPage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const MainPage({Key? key, required this.dbHelper}) : super(key: key);


  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  List<Widget> pages = const [
    HomePage(),
    ExplorePage(),
    ProfilePage(),
    AddPostPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          kAppTitle,
          style: kMediumTextStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          debugPrint('floating action button');
          setState(() {
            currentPage = 3;
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kWhiteColor,
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage % 3,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: kPrimaryColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.explore,
              color: kPrimaryColor,
            ),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: kPrimaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: pages[currentPage],
    );
  }
}
