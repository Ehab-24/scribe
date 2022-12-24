import 'package:flutter/material.dart';
import '../globals/Constants.dart';
import 'Sense.dart';

class Entry {
  List<Sense> senses;

  Entry({required this.senses});

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        senses: _getSenses(json),
      );

  Widget get widget => Column(children: childWidgets);

  List<Widget> get childWidgets {
    List<Widget> result = [];
    for (Sense sense in senses) {
      result.addAll([space30v, sense.widget]);
    }
    return result;
  }

  static List<Sense> _getSenses(Map<String, dynamic> json) {
    List<Sense> result = [];
    for (Map<String, dynamic> sense in json['senses']) {
      result.add(Sense.fromJson(sense));
    }
    return result;
  }
}
