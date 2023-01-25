// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:noteist/models/userModel.dart';
import 'package:noteist/shared/constants.dart';

import '../database/database_helper.dart';

class Setting extends StatefulWidget {
  String? name;
  String? email;
  int? id;
  Setting({Key? key, this.name, this.email, this.id})
      : super(
          key: key,
        );

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
    nameController.text = widget.name!;
    emailController.text = widget.email!;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Settings",
          style: robotoMono,
        ),
        actions: [
          onAbout
              ? TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      onAbout = false;
                      buttonSave = false;
                      onTapped();
                    });
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
              : !buttonSave
                  ? TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home", (route) => false);
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(),
        ],
      ),
      body: !onSetting
          ? Container(
              margin: const EdgeInsets.fromLTRB(15, 25, 15, 15),
              height: 170.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              child: ListView(
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
                        onTapped();
                        setState(() {
                          onAccount = true;
                          buttonSave = true;
                        });
                      },
                      leading: Icon(
                        Icons.person,
                        color: primary,
                      ),
                      title: Text(
                        "Account",
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          onTapped();
                          setState(() {
                            onAccount = true;
                            buttonSave = true;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
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
                        onTapped();
                        setState(() {
                          onLanguage = true;
                          buttonSave = true;
                        });
                      },
                      leading: Icon(
                        Icons.language,
                        color: primary,
                      ),
                      title: Text(
                        "Language",
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          onTapped();
                          setState(() {
                            onLanguage = true;
                            buttonSave = true;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: primary,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      onTapped();
                      setState(() {
                        onAbout = true;
                        buttonSave = true;
                      });
                    },
                    leading: Icon(
                      Icons.info_outline,
                      color: primary,
                    ),
                    title: Text(
                      "About",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        onTapped();
                        setState(() {
                          onAbout = true;
                          buttonSave = true;
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ))
          : onAccount == true
              ? _buildAccount()
              : onLanguage == true
                  ? _buildLanguage()
                  : onAbout
                      ? _buildAbout()
                      : Container(),
    );
  }

  Container _buildAbout() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 25, 15, 15),
      decoration: const BoxDecoration(
        color: bgPrimary,
      ),
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    onAbout = false;
                    buttonSave = false;
                    onTapped();
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: primary,
                ),
              ),
              title: Text(
                "About",
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Noteist 1.0.0",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
                Text("(13012023)"),
                SizedBox(
                  height: 50,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Terms of Service",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                    "Last Modified January 13,2023 with an effective date of January 13,2023."),
                Divider(),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: terms,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "PLEASE READ THE FOLLOWING TERMS CAREFULLY.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: service,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _buildLanguage() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 25, 15, 15),
      decoration: const BoxDecoration(
        color: bgPrimary,
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    onLanguage = false;
                    buttonSave = false;
                    isLanguage = false;
                    onTapped();
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: primary,
                ),
              ),
              title: Text(
                "Language",
              ),
            ),
          ),
          ListTile(
            title: Text("Language"),
          ),
          Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              child: !isLanguage
                  ? ListTile(
                      onTap: () {
                        setState(() {
                          isLanguage = true;
                        });
                      },
                      title: Text("Language"),
                      trailing: Text("Set Automatically"),
                    )
                  : ListTile(
                      onTap: () {
                        setState(() {
                          isLanguage = false;
                        });
                      },
                      title: Text("Set Automatically"),
                      trailing: Text("English"),
                    )),
        ],
      ),
    );
  }

  var isLanguage = false;

  Container _buildAccount() {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 25, 15, 15),
      decoration: const BoxDecoration(
        color: bgPrimary,
      ),
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    onAccount = false;
                    buttonSave = false;
                    onTapped();
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: primary,
                ),
              ),
              title: Text(
                "Account",
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CircleAvatar(
            backgroundColor: primary,
            radius: 35.0,
            child: Icon(
              Icons.person,
              size: 28.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Full Name"),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'name',
                ),
                controller: nameController,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text("Email"),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10.0,
                ),
              ),
            ),
            child: ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'email',
                ),
                controller: emailController,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () async {
              if (widget.id == 0) {
                {
                  await DatabaseHelper.instance.addUser(
                    UserModel(
                      id: 1,
                      name: nameController.text,
                      email: emailController.text,
                    ),
                  );
                  setState(() {
                    onAccount = false;
                    buttonSave = false;
                  });
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (route) => false);
                }
              } else {
                await DatabaseHelper.instance.updateUser(
                  UserModel(
                    id: widget.id,
                    name: nameController.text,
                    email: emailController.text,
                  ),
                );
                setState(() {
                  onAccount = false;
                  buttonSave = false;
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home", (route) => false);
              }
            },
            child: const Text("Save",
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }

  var buttonSave = false;
  var onSetting = false;
  var onAccount = false;
  var onLanguage = false;
  var onAbout = false;
  onTapped() {
    setState(() {
      onSetting ? onSetting = false : onSetting = true;
    });
  }
}
