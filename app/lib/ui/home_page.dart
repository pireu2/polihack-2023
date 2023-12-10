import 'package:flutter/material.dart';
import 'package:app/constants/strings.dart';
import 'package:app/constants/styles.dart';
import 'package:app/constants/colors.dart';
import 'package:app/services/database_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  final DatabaseHelper dbHelper;

  const HomePage({Key? key, required this.dbHelper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding:  EdgeInsets.only(left: 16.0, bottom: 10.0),
              child: Text(
                'Events',
                style: kMediumTextStyle,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2 / 1,
                  enlargeFactor: 0.5,
                ),
                items: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 400.0, // Specify the desired width
                            height: 300.0, // Specify the desired height
                            child: Image.asset(
                              'assets/images/events/1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 16.0, // Adjust the bottom distance as needed
                            left: 16.0, // Adjust the left distance as needed
                            child: Container(
                              padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
                              decoration: BoxDecoration(
                                color: kBlackColor.withOpacity(0.6), // Adjust the background color and opacity as needed
                                borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor.withOpacity(0.5), // Adjust the shadow color and opacity as needed
                                    spreadRadius: 1.0, // Adjust the spread radius as needed
                                    blurRadius: 5.0, // Adjust the blur radius as needed
                                    offset: const Offset(0, 2), // Adjust the shadow offset as needed
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Gathering of Speaking Hands',
                                style: kSmallWhiteTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 400.0, // Specify the desired width
                            height: 300.0, // Specify the desired height
                            child: Image.asset(
                              'assets/images/events/2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 16.0, // Adjust the bottom distance as needed
                            left: 16.0, // Adjust the left distance as needed
                            child: Container(
                              padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
                              decoration: BoxDecoration(
                                color: kBlackColor.withOpacity(0.6), // Adjust the background color and opacity as needed
                                borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor.withOpacity(0.5), // Adjust the shadow color and opacity as needed
                                    spreadRadius: 1.0, // Adjust the spread radius as needed
                                    blurRadius: 5.0, // Adjust the blur radius as needed
                                    offset: const Offset(0, 2), // Adjust the shadow offset as needed
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Association of Deaf-Mute Adolescents',
                                style: kSmallWhiteTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 400.0, // Specify the desired width
                            height: 300.0, // Specify the desired height
                            child: Image.asset(
                              'assets/images/events/3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 16.0, // Adjust the bottom distance as needed
                            left: 16.0, // Adjust the left distance as needed
                            child: Container(
                              padding: const EdgeInsets.all(8.0), // Adjust the padding as needed
                              decoration: BoxDecoration(
                                color: kBlackColor.withOpacity(0.6), // Adjust the background color and opacity as needed
                                borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor.withOpacity(0.5), // Adjust the shadow color and opacity as needed
                                    spreadRadius: 1.0, // Adjust the spread radius as needed
                                    blurRadius: 5.0, // Adjust the blur radius as needed
                                    offset: const Offset(0, 2), // Adjust the shadow offset as needed
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Protest for blind people',
                                style: kSmallWhiteTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent',
                      style: kMediumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 105.0, // Specify the desired width
                                  height: 160.0, // Specify the desired height
                                  child: Image.asset(
                                    'assets/images/disabled/5.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Alex',
                              style: kSmallTextStyle,
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kAccentColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.messenger,
                                  color: kAccentColor,
                                ),
                              ),
                            ])
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 105.0, // Specify the desired width
                                  height: 160.0, // Specify the desired height
                                  child: Image.asset(
                                    'assets/images/disabled/4.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Mihai',
                              style: kSmallTextStyle,
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kAccentColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.messenger,
                                  color: kAccentColor,
                                ),
                              ),
                            ])
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 105.0, // Specify the desired width
                                  height: 160.0, // Specify the desired height
                                  child: Image.asset(
                                    'assets/images/disabled/1.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Tudor',
                              style: kSmallTextStyle,
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kAccentColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.messenger,
                                  color: kAccentColor,
                                ),
                              ),
                            ])
                          ],
                        ),
                      ],
                    ),
                    const Text(
                      'Favourites',
                      style: kMediumTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 105.0, // Specify the desired width
                                  height: 160.0, // Specify the desired height
                                  child: Image.asset(
                                    'assets/images/volunteers/3.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Ana',
                              style: kSmallTextStyle,
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kAccentColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.messenger,
                                  color: kAccentColor,
                                ),
                              ),
                            ])
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 105.0, // Specify the desired width
                                  height: 160.0, // Specify the desired height
                                  child: Image.asset(
                                    'assets/images/volunteers/2.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Bebe',
                              style: kSmallTextStyle,
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kAccentColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.messenger,
                                  color: kAccentColor,
                                ),
                              ),
                            ])
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  width: 105.0, // Specify the desired width
                                  height: 160.0, // Specify the desired height
                                  child: Image.asset(
                                    'assets/images/volunteers/1.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Bianca',
                              style: kSmallTextStyle,
                            ),
                            Row(children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call,
                                  color: kAccentColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.messenger,
                                  color: kAccentColor,
                                ),
                              ),
                            ])
                          ],
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
