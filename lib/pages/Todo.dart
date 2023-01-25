// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:noteist/database/database_helper.dart';
import 'package:noteist/models/todoModel.dart';
import 'package:noteist/widgets/TodoItem.dart';
import '../shared/constants.dart';

class Todo extends StatefulWidget {
  const Todo({
    Key? key,
  }) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  String? title;

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: appBar,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 7.5),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    "Todo List",
                    style: robotoMono.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  trailing: !isAddItem
                      ? IconButton(
                          onPressed: (() {
                            addItemClosed();
                          }),
                          icon: Icon(
                            Icons.add,
                            size: 30,
                            color: primary,
                          ),
                        )
                      : IconButton(
                          onPressed: (() {
                            title = titleController.text;
                            Future addItem() async {
                              final item = TodoModel(
                                title: title,
                              );
                              await DatabaseHelper.instance.add(item);
                            }

                            title == ""
                                ? addItemClosed()
                                : {
                                    addItemClosed(),
                                    addItem(),
                                    // print(onChanged)
                                  };
                            titleController.clear();
                          }),
                          icon: Icon(
                            Icons.save,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                ),
                if (isAddItem) _addTodo(),
              ],
            ),
          ),
          if (!isAddItem)
            Expanded(
              child: todoItem(),
            ),
        ],
      ),
    );
  }

  Container _addTodo() {
    return Container(
      child: ListTile(
        title: TextFormField(
          maxLength: 16,
          decoration: const InputDecoration(
            labelText: 'add a task',
            hintText: "enter anything...",
            labelStyle: TextStyle(
              color: Colors.blueGrey,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
              ),
            ),
            helperText: "What's your plan for today?",
          ),
          controller: titleController,
        ),
        // ignore: prefer_const_constructors
      ),
    );
  }

  var isAddItem = false;
  void addItemClosed() {
    setState(() {
      isAddItem ? isAddItem = false : isAddItem = true;
    });
  }
}
