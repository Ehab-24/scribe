import 'dart:convert';

import 'package:backend_testing/repository/constants.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/Word.dart';

class LocalRepository {
  LocalRepository._();

  static final LocalRepository instance = LocalRepository._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    return await openDatabase(
      fileName,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $wordsTable (
    ${WordFeilds.wordId} $textType,
    ${WordFeilds.jsonString} $textType
  )
  ''');
  }

  /*  ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ PUBLIC METHODS ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~*/

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> delete() async {
    final db = await instance.database;
    await db.delete(wordsTable);
  }

  Future<void> addWord(String wordId, String jsonString) async {
    final db = await instance.database;
    final values = {
      WordFeilds.wordId: wordId,
      WordFeilds.jsonString: jsonString,
    };

    await db.insert(
      wordsTable,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Word?> readWord(String wordId) async {
    final db = await instance.database;

    final response = await db.query(
      wordsTable,
      columns: WordFeilds.allFeilds,
      where: '${WordFeilds.wordId} = ?',
      whereArgs: [wordId],
    );

    if (response.isNotEmpty) {
      final jsonString = response.first[WordFeilds.jsonString] as String;
      return Word.fromJson(
        jsonDecode(jsonString),
      );
    }
    return null;
  }

  Future<List<Word>> readAllWords() async {
    final db = await instance.database;
    final response = await db.query(
      wordsTable,
    );

    List<Map<String, dynamic>> jsons = [];
    for (Map<String, Object?> item in response) {
      jsons.add(
        jsonDecode(
          item[WordFeilds.jsonString] as String,
        ),
      );
    }

    return jsons.map((json) => Word.fromJson(json)).toList();
  }

  Future<void> removeWord(String wordId) async {
    final db = await instance.database;

    await db.delete(
      wordsTable,
      where: '${WordFeilds.wordId} = ?',
      whereArgs: [wordId],
    );
  }
}
