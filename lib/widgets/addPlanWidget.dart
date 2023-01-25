// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteist/shared/constants.dart';

import '../database/database_helper.dart';
import '../models/planModel.dart';

class addPlanWidget extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const addPlanWidget({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<addPlanWidget> createState() => _addPlanWidgetState();
}

class _addPlanWidgetState extends State<addPlanWidget> {
  DateTime? time = DateTime.now();
  var now = DateFormat.yMMMd().format(DateTime.now()).toString();
  var format;

  final _titleController = TextEditingController();

  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  String? get _errorTitle {
    final title = _titleController.value.text;

    if (title.isEmpty) {
      return "can't be empty";
    }
    return null;
  }

  String? get _errorDesc {
    final desc = _descController.value.text;

    if (desc.isEmpty) {
      return "can't be empty";
    }
    return null;
  }

  void _submit() {
    if (_errorDesc == null && _errorTitle == null) {
      widget.onSubmit(_descController.value.text);
      widget.onSubmit(_titleController.value.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 190),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      alignment: Alignment.bottomCenter,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),

      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            child: TextFormField(
              maxLength: 50,
              autofocus: true,
              controller: _titleController,
              decoration: InputDecoration(
                errorText: _errorTitle,
                hintText: "enter anything..",
                suffixIcon: IconButton(
                  onPressed: (() {
                    DateTime? jam = time!;
                    var title = _titleController.text;
                    var decs = _descController.text;

                    Future addPlan() async {
                      final plan = Plan(
                        title: title,
                        description: _descController.text,
                        createdTime: jam,
                      );
                      await DatabaseHelper.instance.createPlan(plan);
                    }

                    if (title != "" && decs != "") {
                      _submit();
                      addPlan();
                      _descController.clear();
                      _titleController.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/home", (route) => false);
                    }
                  }),
                  // ignore: prefer_const_constructors
                  icon: Icon(
                    Icons.save_outlined,
                    color: Colors.blue,
                  ),
                ),
                labelText: 'Add a plan',
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                helperText: "What's your plan today?",
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: TextFormField(
              controller: _descController,
              decoration: InputDecoration(
                errorText: _errorDesc,
                hintText: "enter anything..",
                labelText: 'Add a description',
                // ignore: prefer_const_constructors
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((value) => {
                    setState(
                      () {
                        time = value;
                        format = DateFormat.yMMMd().format(time!);
                      },
                    )
                  });
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  time != null
                      ? format != null
                          ? format!
                          : now
                      : now,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: kBottomNavigationBarHeight,
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
