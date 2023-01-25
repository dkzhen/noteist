// ignore_for_file: file_names, prefer_const_constructors

import "package:flutter/material.dart";
import 'package:path/path.dart';

// colors
const Color bgPrimary = Color.fromARGB(255, 243, 240, 240);
const Color primary = Colors.orange;

// fonts
// const poppins = 'Poppins';
// const robotoMono = 'RobotoMono';

const TextStyle poppins = TextStyle(fontFamily: "Poppins");
const TextStyle robotoMono = TextStyle(fontFamily: "RobotoMono");

//text terms service
const Text terms = Text(
    "Welcome, and thank you for your interest in the Noteist and our website at zhen.biz.id. These Terms of Service are a legally binding contract between you and the Noteist regarding your use of the Service. We provide services so that we can assist you in your daily activities. we will make updates in the future. we hope this application can be useful");

const Text service = Text(
    "BY CLICKING “I ACCEPT,” OR BY DOWNLOADING, INSTALLING, OR OTHERWISE ACCESSING OR USING THE SERVICE, YOU AGREE THAT YOU HAVE READ AND UNDERSTOOD, AND, AS A CONDITION TO YOUR USE OF THE SERVICE, YOU AGREE TO BE BOUND BY, THE FOLLOWING TERMS AND CONDITIONS, INCLUDING DOIST’S PRIVACY POLICY (TOGETHER, THESE “TERMS”). If you are not eligible, or do not agree to the Terms, then you do not have our permission to use the Service. YOUR USE OF THE SERVICE, AND DOIST’S PROVISION OF THE SERVICE TO YOU, CONSTITUTES AN AGREEMENT BY DOIST AND BY YOU TO BE BOUND BY THESE TERMS.");
// appBar
AppBar appBar = AppBar(
  elevation: 0,
  backgroundColor: primary,
  title: const Text(
    "Noteist",
    style: robotoMono,
  ),
);

//Loading
Container loading = Container(
  color: bgPrimary,
  child: Center(
    heightFactor: 20,
    child: CircularProgressIndicator(),
  ),
);

Container noItem = Container(
  padding: EdgeInsets.only(top: 150),
  color: bgPrimary,
  child: Column(
    children: [
      Container(
        alignment: Alignment.center,
        child: Image.asset(
          "assets/nolist.png",
          width: 250.0,
          height: 250.0,
          fit: BoxFit.cover,
        ),
      ),
      Text(
        "Your peace of mind is priceless",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      Text(
        "Look like everything's organized in the right place.",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
      Text(
        "please add a new task for the next day",
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ],
  ),
);
