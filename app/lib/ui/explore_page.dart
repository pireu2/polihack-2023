import 'package:app/user.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';
import 'package:app/user.dart';


class ExplorePage extends StatefulWidget {
  final DatabaseHelper dbHelper;

  const ExplorePage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<List<dynamic>>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data != null) {
              if(snapshot.data!.isEmpty){
                return const Center(
                  child: Text(
                    'No posts yet',
                    style: kSmallTextStyle,
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: kWhiteColor,
                    // child: ListTile(
                    //   title: Text(snapshot.data![index][1].toString()),
                    //   subtitle: Text(snapshot.data![index][2].toString()),
                    // ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                        radius: 20,
                        backgroundColor: Colors.transparent,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                snapshot.data![index][5].toString(),
                                style: kSmallMediumTextStyle,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.circle,
                                size: 2,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                formatDate(snapshot.data![index][3]),
                                style: kSmallGreyTextStyle,
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data![index][2].toString(),
                            style: kSmallTextStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FutureBuilder<Widget?>(
                              future: getHelpButton(int.parse(
                                  snapshot.data![index][0].toString())),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return snapshot.data!;
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ]),
                    ),
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const CircularProgressIndicator(); // Show a loading indicator
          }
        },
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

  Future<Widget?> getHelpButton(int postId) async {
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

  Future<List<List<dynamic>>> getPosts() async {
    final posts = await widget.dbHelper.executeQuery(
      '''SELECT posts.id,title,description,created_at,taken, u.username
         FROM posts
         JOIN users u on posts.author_id = u.id
         WHERE taken = false
         ORDER BY created_at DESC;
    ''',
    );
    return posts;
  }
}

