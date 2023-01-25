// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteist/shared/constants.dart';
import '../database/database_helper.dart';
import '../models/planModel.dart';

class AllPlansPage extends StatefulWidget {
  const AllPlansPage({Key? key}) : super(key: key);

  @override
  State<AllPlansPage> createState() => _AllPlansPageState();
}

class _AllPlansPageState extends State<AllPlansPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        title: const Text(
          "Plans",
          style: robotoMono,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: bgPrimary,
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0,
            ),
          ),
        ),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: _buildPlansItem(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlansItem() {
    return !onDeleted
        ? FutureBuilder<List<Plan>>(
            future: DatabaseHelper.instance.readAllPlan(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Plan>> snapshot) {
              if (!snapshot.hasData) {
                return loading;
              }
              return snapshot.data!.isEmpty
                  ? noItem
                  : ListView(
                      children: snapshot.data!.map((item) {
                        return _buildItem(item);
                      }).toList(),
                    );
            },
          )
        : loading;
  }

  Container _buildItem(Plan item) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      color: Colors.white,
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
              title: Text(
                item.title,
                style: poppins.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  int selectedId = item.id!;
                  Future removeItem() async {
                    await DatabaseHelper.instance.deletePlan(selectedId);
                  }

                  onDelete();
                  removeItem();
                },
                icon: const Icon(
                  Icons.delete_forever_outlined,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          ListTile(
            title: Container(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                item.description,
                style: poppins.copyWith(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15,
                ),
              ),
            ),
            trailing: Text(
              DateFormat.yMMMd().format(item.createdTime),
              style: robotoMono.copyWith(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  var onDeleted = false;
  void onDelete() {
    setState(() {
      onDeleted ? onDeleted = true : onDeleted = false;
    });
  }
}
