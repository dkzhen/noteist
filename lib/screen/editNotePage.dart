import 'package:flutter/material.dart';
import 'package:noteist/shared/constants.dart';
import '../database/database_helper.dart';
import '../models/noteModel.dart';
import '../widgets/noteFormWidget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: bgPrimary,
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: IconButton(
        onPressed: () {
          addOrUpdateNote();
        },
        icon: const Icon(
          Icons.save,
          size: 24.0,
        ),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      description: description,
    );

    await DatabaseHelper.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    await DatabaseHelper.instance.create(note);
  }
}
