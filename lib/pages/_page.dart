// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

import 'Note.dart';
import '../shared/constants.dart';
import 'Todo.dart';
import 'Home.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 1);

  int maxCount = 3;

  /// widget list
  final List<Widget> bottomBarPages = [
    NotesPage(),
    Home(),
    const Todo(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      body: PageView(
        controller: _pageController,
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: Colors.white,
              showShadow: true,

              showLabel: true,
              // ignore: prefer_const_constructors
              itemLabelStyle: poppins,
              notchColor: Colors.white,
              // ignore: prefer_const_literals_to_create_immutables
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.note_alt,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.note_alt,
                    color: Colors.green,
                  ),
                  itemLabel: 'Notes',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.green,
                  ),
                  itemLabel: 'Home',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.list_alt,
                    color: Colors.black,
                  ),
                  activeItem: Icon(
                    Icons.list_alt,
                    color: Colors.green,
                  ),
                  itemLabel: 'Lists',
                ),
              ],
              onTap: (index) {
                /// control your animation using page controller
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
