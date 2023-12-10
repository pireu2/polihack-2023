import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';


class HomePage extends StatelessWidget {
  final DatabaseHelper dbHelper;

  const HomePage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home', style: kBoldTextStyle,));
  }
}


