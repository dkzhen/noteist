import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noteist/pages/Todo.dart';
import 'package:noteist/screen/allPlansPage.dart';
import 'package:noteist/screen/overduePage.dart';
import 'package:noteist/screen/setting.dart';
import 'package:noteist/screen/todayPage.dart';
import 'package:noteist/screen/upcomingPage.dart';
import 'package:noteist/shared/constants.dart';
import 'package:noteist/pages/Home.dart';

import 'database/database_helper.dart';
import 'models/userModel.dart';
import 'pages/_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noteist',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: "Poppins",
        backgroundColor: bgPrimary,
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const MyPage(),
        '/todo': (BuildContext context) => const Todo(),
        '/plan': (BuildContext context) => const Home(),
        '/upcoming': (BuildContext context) => const upcomingPage(),
        '/today': (BuildContext context) => const TodayPage(),
        '/over': (BuildContext context) => const OverduePage(),
        '/plans': (BuildContext context) => const AllPlansPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 100, 0, 20),
              child: Text(
                "Noteist",
                style: robotoMono.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 70, 0),
              child: const Text(
                "It's an absolute way to make your note-taking easier and make todolists or plans fun. Anything would be better.",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 190, 15, 0),
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    "assets/hero.png",
                    width: 350.0,
                    height: 370.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 450, 25, 0),
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          "Let's Start",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          // Icon
                          Icons.arrow_right_alt,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
