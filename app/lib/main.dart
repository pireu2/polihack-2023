import 'package:app/ui/auth/auth_page.dart';
import 'package:app/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();
  await dbHelper.connect();
  runApp(MyApp(
    dbHelper: dbHelper,
  ));
}

class MyApp extends StatefulWidget {
  final DatabaseHelper dbHelper;


  const MyApp({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController(initialPage: 0);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kPrimaryColor,
        ),
      ),
      home: PageView(
        controller: pageController,
        children: [
          AuthScreen(dbHelper: widget.dbHelper),
          MainPage(dbHelper: widget.dbHelper),
        ],
      ),

    );
  }
}

