import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';
import 'package:app/ui/main_page.dart';
import 'package:app/user.dart';

class AddPostPage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const AddPostPage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  String _errorMessage = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
              'AddPost',
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
              controller: _titleController,
              style: kSmallTextStyle,
              decoration: InputDecoration(
                labelText: 'Title',
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
              maxLines: null,
              minLines: 4,
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: kSmallTextStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Customize the border color
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
              onPressed: () {
                // Handle login button click
                addPost();
              },
              child: const Text(
                'Add Post',
                style: kSmallTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addPost() async{
    final title = _titleController.text;
    final description = _descriptionController.text;


    if (title == '') {
      setState(() {
        _errorMessage = 'Title cannot be empty';
      });
      return;
    }
    if (description == '') {
      setState(() {
        _errorMessage = 'Description cannot be empty';
      });
      return;
    }

    final List<List<dynamic>> result = await widget.dbHelper.executeQuery(
      'SELECT * FROM users WHERE username = \'$loggedInUser\'',
    );

    if (result.isNotEmpty && result[0].isNotEmpty) {
      final userId = result[0][0];
      if (result[0][4] == 0){
        setState(() {
          _errorMessage = 'Volunteers cannot add post';
        });
        return;
      }

      // Now you can use the userId in your insertQuery
      String insertQuery =
          'INSERT INTO posts (title, description, author_id) VALUES (@title, @description, @author_id)';
      Map<String, dynamic> insertValues = {
        'title': title,
        'description': description,
        'author_id': userId
      };
      final int queryResult = await widget.dbHelper.executeInsert(
        insertQuery,
        insertValues,

      );

      if (queryResult != -1) {
        debugPrint('Added post');
        _titleController.clear();
        _descriptionController.clear();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(
              dbHelper: widget.dbHelper,
            ),
          ),
        );
      }

      // Perform your insert operation here
    } else {
      debugPrint('User not found');
    }

  }
}
