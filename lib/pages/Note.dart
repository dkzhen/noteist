// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:noteist/shared/constants.dart';

import '../database/database_helper.dart';
import '../models/noteModel.dart';
import '../screen/editNotePage.dart';
import '../screen/noteDetailPage.dart';
import '../widgets/noteCard.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    DatabaseHelper.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await DatabaseHelper.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: bgPrimary,
        appBar: appBar,
        body: Stack(
          children: [
            Container(
              child: isLoading
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Loading...",
                        style: poppins,
                      ),
                    )
                  : notes.isEmpty
                      ? noItem
                      : Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Expanded(
                                child: buildNotes(),
                              ),
                              SizedBox(
                                height: kBottomNavigationBarHeight,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10.0,
                  ),
                ),
              ),
              child: Text(
                "Notes",
                style: robotoMono.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 25, bottom: 120),
              child: FloatingActionButton(
                backgroundColor: primary,
                child: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEditNotePage()),
                  );

                  refreshNotes();
                },
              ),
            ),
          ],
        ),
      );

  Widget buildNotes() => ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
