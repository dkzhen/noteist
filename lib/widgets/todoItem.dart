// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, avoid_unnecessary_containers, prefer_const_constructors, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteist/database/database_helper.dart';
import 'package:noteist/models/todoModel.dart';
import 'package:noteist/shared/constants.dart';

class todoItem extends StatefulWidget {
  const todoItem({
    Key? key,
  }) : super(key: key);

  @override
  State<todoItem> createState() => _todoItemState();
}

class _todoItemState extends State<todoItem> {
  TextEditingController titleController = TextEditingController(text: "");
  int? selectedId;
  var onChanged;
  // ignore: prefer_final_fields

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TodoModel>>(
      future: DatabaseHelper.instance.getAllTodo(),
      builder: (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
        if (!snapshot.hasData) {
          return loading;
        }
        return snapshot.data!.isEmpty
            ? noItem
            : ListView(
                children: snapshot.data!.map(
                  (todo) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(15, 5, 15, 7.5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: ListTile(
                        onTap: () {},
                        leading: Icon(
                          Icons.join_full_rounded,
                          color: const Color.fromARGB(255, 19, 0, 226),
                        ),
                        // title:

                        title: !isEdited
                            ? Text(
                                todo.title!,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              )
                            : todo.id == selectedId
                                ? TextFormField(
                                    maxLength: 16,
                                    autofocus: true,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      counterStyle:
                                          TextStyle(height: double.minPositive),
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    controller: titleController,
                                    onChanged: (String value) {
                                      onChanged;
                                    },
                                  )
                                : Text(
                                    todo.title!,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                        // ignore: prefer_const_constructors
                        trailing: Wrap(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                alignment: Alignment.center,
                                color: Colors.white,
                                iconSize: 20,
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  Icons.edit,
                                ),
                                onPressed: () {
                                  selectedId = todo.id;
                                  var title = titleController.text;
                                  Future editItem() async {
                                    final item = TodoModel(
                                      id: selectedId,
                                      title: title,
                                    );
                                    await DatabaseHelper.instance
                                        .updateTodo(item);
                                  }

                                  selectedId == selectedId
                                      ? title == ""
                                          ? {
                                              editItemButton(),
                                              titleController.clear()
                                            }
                                          : {
                                              editItem(),
                                              editItemButton(),
                                              titleController.clear()
                                            }
                                      : print("gatau bukan id");
                                },
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                alignment: Alignment.center,
                                color: Colors.white,
                                iconSize: 20,
                                // ignore: prefer_const_constructors
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                ),
                                onPressed: () {
                                  selectedId = todo.id;
                                  Future removeItem() async {
                                    await DatabaseHelper.instance
                                        .remove(selectedId);
                                  }

                                  removeItem();
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
      },
    );
  }

  var isDone = false;
  var isEdited = false;

  void isDoneTask() {
    setState(() {
      isDone ? isDone = false : isDone = true;
    });
  }

  void editItemButton() {
    setState(() {
      isEdited ? isEdited = false : isEdited = true;
    });
  }
}
