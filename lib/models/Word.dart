import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:backend_testing/models/LexicalEntry.dart';

import '../globals/Constants.dart';


class Word {
  String id;
  HashSet<String> derivatives;
  List<LexicalEntry> lexicalEntries;
  DateTime dateTime;

  Word({
    required this.id,
    required this.derivatives,
    required this.lexicalEntries,
    required this.dateTime,
  });

  factory Word.fromJson(Map<String, dynamic> json, DateTime? dateTime) { 
    final wordData = jsonDecode(
      json[WordFeilds.jsonString] as String,
    );

    final DateTime dt = dateTime ?? DateTime.parse(json[WordFeilds.dateTime] as String);
    return Word(
        id: wordData['id'],
        dateTime: dt,
        derivatives: _getDerivatives(wordData),
        lexicalEntries: _getLexicalEntries(wordData),
      );
  }

  Widget get widget => Column(
        children: _childWidgets,
      ); 

  List<Widget> get _childWidgets {
    List<Widget> result = [];
    for (LexicalEntry le in lexicalEntries) {
      result.addAll([space40v, le.widget]);
    }
    return result;
  }

  static _getLexicalEntries(Map<String, dynamic> json) {
    List<LexicalEntry> result = [];
    for (Map<String, dynamic> le in json['results'][0]['lexicalEntries']) {
      result.add(LexicalEntry.fromJson(le));
    }
    return result;
  }

  static HashSet<String> _getDerivatives(Map<String, dynamic> json) {
    HashSet<String> result = HashSet<String>();
    for (Map<String, dynamic> le in json['results'][0]['lexicalEntries']) {
      if(le['derivatives'] == null) {
        continue;
      }
      for (Map<String, dynamic> der in le['derivatives']) {
        result.add(der['text']);
      }
    }
    return result;
  }
}
