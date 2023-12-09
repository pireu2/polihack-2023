import 'package:app/ui/explore_page.dart';
import 'package:app/ui/home_page.dart';
import 'package:app/ui/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/ui/add_post_page.dart';
import 'package:app/services/database_helper.dart';
import 'package:app/user.dart';
import 'package:app/main.dart';

class MainPage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const MainPage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  late PageController _pageController;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
    pages = [
      const HomePage(),
      const ExplorePage(),
      const ProfilePage(),
      AddPostPage(
        dbHelper: widget.dbHelper,
      ),
    ];
  }

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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              loggedInUser = '';
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(
                    dbHelper: widget.dbHelper,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: kBlackColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<Widget?>(
        future: getAddButton(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kWhiteColor,
        onDestinationSelected: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: pages,
      ),
    );
  }

  Future<Widget?> getAddButton() async {
    final List<List<dynamic>> result = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$loggedInUser\'',
    );

    if (result.isNotEmpty && result[0].isNotEmpty) {
      if (result[0][4] == 0) {
        return null;
      }
    }
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      onPressed: () {
        debugPrint('floating action button');
        _pageController.animateToPage(
          3,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
