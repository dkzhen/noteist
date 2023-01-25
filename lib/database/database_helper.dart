// ignore_for_file: unused_field

import 'package:noteist/models/todoModel.dart';
import 'package:noteist/models/userModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../models/noteModel.dart';
import '../models/planModel.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database = await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE todo(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT     
      )
      ''');
    await db.execute('''
      CREATE TABLE user(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT     
      )
      ''');
    await db.execute('''
      CREATE TABLE $tableNotes ( 
  ${NoteFields.id} $idType, 
  ${NoteFields.title} $textType,
  ${NoteFields.description} $textType,
  ${NoteFields.time} $textType
  )
      ''');
    await db.execute('''
      CREATE TABLE $tablePlans ( 
  ${PlanFields.id} $idType, 
  ${PlanFields.title} $textType,
  ${PlanFields.description} $textType,
  ${PlanFields.time} $textType
  )
      ''');
  }

//user
  Future<List<UserModel>> getAllUser() async {
    Database db = await instance.database;
    var user = await db.query('user', orderBy: 'id');
    List<UserModel> userList =
        user.isNotEmpty ? user.map((c) => UserModel.fromMap(c)).toList() : [];
    return userList;
  }

  Future<int> addUser(UserModel userItem) async {
    Database db = await instance.database;
    return await db.insert('user', userItem.toMap());
  }

  Future<int> updateUser(UserModel userItem) async {
    Database db = await instance.database;
    return await db.update('user', userItem.toMap(),
        where: "id = ?", whereArgs: [userItem.id]);
  }

// todo
  Future<List<TodoModel>> getAllTodo() async {
    Database db = await instance.database;
    var todoItem = await db.query('todo', orderBy: 'id');
    List<TodoModel> todoList = todoItem.isNotEmpty
        ? todoItem.map((c) => TodoModel.fromMap(c)).toList()
        : [];
    return todoList;
  }

  Future<List<TodoModel>> getTodoById(int id) async {
    Database db = await instance.database;
    var todoItem = await db.query('todo', where: 'id = ?', whereArgs: [id]);
    List<TodoModel> todoList = todoItem.isNotEmpty
        ? todoItem.map((c) => TodoModel.fromMap(c)).toList()
        : [];
    return todoList;
  }

  Future<int> add(TodoModel todoItem) async {
    Database db = await instance.database;
    return await db.insert('todo', todoItem.toMap());
  }

  Future<int> remove(int? id) async {
    Database db = await instance.database;
    return await db.delete('todo', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateTodo(TodoModel todoItem) async {
    Database db = await instance.database;
    return await db.update('todo', todoItem.toMap(),
        where: "id = ?", whereArgs: [todoItem.id]);
  }

// note
  Future<Note> create(Note note) async {
    Database db = await instance.database;
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    Database db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    Database db = await instance.database;

    final orderBy = '${NoteFields.time} ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }

  //plan
  Future<Plan> createPlan(Plan plan) async {
    Database db = await instance.database;
    final id = await db.insert(tablePlans, plan.toJson());
    return plan.copy(id: id);
  }

  Future<Plan> readPlan(int id) async {
    Database db = await instance.database;

    final maps = await db.query(
      tablePlans,
      columns: PlanFields.values,
      where: '${PlanFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Plan.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Plan>> readAllPlan() async {
    Database db = await instance.database;

    final orderBy = '${PlanFields.time} ASC';

    final result = await db.query(tablePlans, orderBy: orderBy);

    return result.map((json) => Plan.fromJson(json)).toList();
  }

  Future<List<Plan>> readAllPlanByOverdue() async {
    Database db = await instance.database;

    final orderBy = '${PlanFields.time} ASC';

    final result = await db.query(tablePlans,
        where: "${PlanFields.time} < date('now','localtime')",
        orderBy: orderBy);

    return result.map((json) => Plan.fromJson(json)).toList();
  }

  Future<List<Plan>> readAllPlanByToday() async {
    Database db = await instance.database;

    final result = await db.query(
      tablePlans,
      where:
          "${PlanFields.time} BETWEEN date('now','localtime') AND date('now','+1 day','localtime')",
    );

    return result.map((json) => Plan.fromJson(json)).toList();
  }

  Future<List<Plan>> readAllPlanByUpcoming() async {
    Database db = await instance.database;

    final orderBy = '${PlanFields.time} ASC';

    final result = await db.query(tablePlans,
        where: "${PlanFields.time} > date('now','+1 day','localtime')",
        orderBy: orderBy);

    return result.map((json) => Plan.fromJson(json)).toList();
  }

  Future<int> deletePlan(int id) async {
    final db = await instance.database;

    return await db.delete(
      tablePlans,
      where: '${PlanFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    Database db = await instance.database;

    db.close();
  }
}
