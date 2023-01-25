// ignore_for_file: file_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:noteist/models/userModel.dart';
import 'package:noteist/screen/setting.dart';
import 'package:noteist/shared/constants.dart';
import 'package:noteist/widgets/addPlanWidget.dart';

import '../database/database_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      primary: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        title: const Text(
          "Noteist",
          style: robotoMono,
        ),
        actions: [
          FutureBuilder<List<UserModel>>(
            future: DatabaseHelper.instance.getAllUser(),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Text('Loading...'),
                );
              }
              return snapshot.data!.isEmpty
                  ? Center(
                      child: IconButton(
                        onPressed: () {
                          String name = "user";
                          String email = "user@zhen.biz.id";
                          int id = 0;
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (Setting(
                                  id: id,
                                  name: name,
                                  email: email,
                                )),
                              ),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.settings,
                          size: 24.0,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data!.map(
                        (user) {
                          return Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => (Setting(
                                        id: user.id,
                                        name: user.name,
                                        email: user.email,
                                      )),
                                    ),
                                    (route) => false);
                              },
                              icon: const Icon(
                                Icons.settings,
                                size: 24.0,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              onTapGesture();
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  height: 170.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 0.3,
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/upcoming");
                          },
                          leading: Icon(
                            Icons.more_time_outlined,
                            size: 30,
                            color: Colors.purple,
                          ),
                          title: Text(
                            "Upcoming",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 0.3),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, "/today");
                          },
                          leading: Icon(
                            Icons.today_outlined,
                            size: 30,
                            color: Colors.green,
                          ),
                          title: Text(
                            "Today",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "/over");
                        },
                        leading: Icon(
                          Icons.timelapse_outlined,
                          size: 30,
                          color: Colors.red,
                        ),
                        title: Text(
                          "Overdue",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Container(
                    margin: const EdgeInsets.all(15),
                    child: const Text(
                      "Plans",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                _buildPlanItem(),
              ],
            ),
          ),
          isTap
              ? Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        onTapGesture();
                      },
                      child: Container(
                        height: 300.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    addPlanWidget(
                      onSubmit: (value) {},
                    )
                  ],
                )
              : _buildButtonPlan(),
        ],
      ),
    );
  }

  Container _buildButtonPlan() {
    return Container(
      margin: EdgeInsets.only(bottom: 120, right: 25),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          onTapped();
        },
      ),
    );
  }

  Container _buildPlanItem() {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, "/plans");
            },
            leading: Icon(
              Icons.next_plan_sharp,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              "All Plans",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  var isTap = false;

  void onTapped() {
    setState(() {
      isTap ? isTap = false : isTap = true;
    });
  }

  void onTapGesture() {
    setState(() {
      isTap ? isTap = false : isTap = false;
    });
  }

  // void onTapSubmit() {
  //   setState(() {
  //     isTap ? isTap = true : isTap = true;
  //   });
  // }

}
