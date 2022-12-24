import 'package:flutter/material.dart';

import 'Entry.dart';

class LexicalEntry {
  String lexicalCategory;
  List<Entry> entries;

  LexicalEntry({
    required this.lexicalCategory,
    required this.entries,
  });

  factory LexicalEntry.fromJson(Map<String, dynamic> json) => LexicalEntry(
        lexicalCategory: json['lexicalCategory']['text'],
        entries: _getEntries(json),
      );

  Widget get widget => Column(
        children: [
          Text(
            lexicalCategory,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 32,
              letterSpacing: 1.2,
            ),
          ),
          ...childWidgets,
        ],
      );

  List<Widget> get childWidgets {
    List<Widget> result = [];
    for (Entry en in entries) {
      result.add(en.widget);
    }
    return result;
  }

  static List<Entry> _getEntries(Map<String, dynamic> json) {
    List<Entry> result = [];
    for (Map<String, dynamic> entry in json['entries']) {
      result.add(Entry.fromJson(entry));
    }
    return result;
  }
}
