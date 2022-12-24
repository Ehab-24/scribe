import 'dart:convert';

import 'package:backend_testing/repository/constants.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/Word.dart';
import '../globals/Constants.dart';

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
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $wordsTable (
    ${WordFeilds.wordId} $textType,
    ${WordFeilds.jsonString} $textType,
    ${WordFeilds.dateTime} $textType
  )
  ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      await db.execute(
        'ALTER TABLE $wordsTable ADD COLUMN ${WordFeilds.dateTime} $textType DEFAULT 12',
      );
    }
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
      WordFeilds.dateTime: DateTime.now().toIso8601String(),
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
      return Word.fromJson(
        response[0]
      );
    }
    return null;
  }

  Future<List<Word>> readAllWords() async {
    final db = await instance.database;
    final List<Map<String, Object?>> response = await db.query(
      wordsTable,
    );

    return response.map((map) => Word.fromJson(map)).toList();
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
