import 'package:backend_testing/globals/Constants.dart';
import 'package:backend_testing/globals/extension_methods.dart';
import 'package:flutter/material.dart';

import '../presentation/ui elements/colors.dart';
import '../presentation/ui elements/styles.dart';
import 'SubSense.dart';

class Sense {
  List<String>? definitions, domains, examples, synonyms;
  List<Subsense>? subsenses;

  Sense({
    required this.definitions,
    required this.examples,
    required this.domains,
    required this.synonyms,
    required this.subsenses,
  });

  factory Sense.fromJson(Map<String, dynamic> json) => Sense(
        definitions: _getDefinitions(json),
        examples: _getExamples(json),
        domains: _getDomains(json),
        synonyms: _getSynonyms(json),
        subsenses: _getSubsenses(json),
      );

  Widget get widget => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(blurRadius: 6.0, color: Colors.black45),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._textWidgets(domains, 'Domain:'),
            ..._textWidgets(definitions, 'Definitions:'),
            ..._textWidgets(examples, 'Examples:'),
            if (synonyms != null)
              ExpansionTile(
                title: const Text(
                  'Synonyms',
                ),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Wrap(
                      spacing: 6.0,
                      children: synonymWidgets,
                    ),
                  ),
                  space20v,
                ],
              ),
            space20v,
            ...childWidgets,
          ],
        ),
      );

  List<Widget> get childWidgets {
    if (subsenses == null) {
      return [];
    }
    List<Widget> result = [];
    for (Subsense ss in subsenses!) {
      result.addAll([space20v, ss.widget]);
    }
    return result;
  }

  List<Widget> get synonymWidgets {
    if (synonyms == null) {
      return [];
    }
    List<Widget> result = [];
    for (String syn in synonyms!) {
      result.add(
        Chip(
          label: Text(
            syn,
          ),
        ),
      );
    }
    return result;
  }

  static List<Widget> _textWidgets(List<String>? strings, String header) {
    if (strings == null) {
      return [];
    }
    List<Widget> result = [];
    result.addAll([
      //Header
      Text(
        header,
        style: Styles.b6(Colors.blueGrey.shade900),
      ),
      spacev(12),
    ]);
    for (String str in strings) {
      result.add(
        SelectableText(
          str.capitalize(),
        ),
      );
    }
    result.add(space30v);
    return result;
  }

  static List<String>? _getDefinitions(Map<String, dynamic> json) {
    if (json['definitions'] == null) {
      return null;
    }
    var rawDefs = json['definitions'];
    return List<String>.from(rawDefs);
  }

  static List<String>? _getExamples(Map<String, dynamic> json) {
    if (json['examples'] == null) {
      return null;
    }
    List<String> result = [];
    for (Map<String, dynamic> exp in json['examples']) {
      result.add(exp['text']);
    }
    return result;
  }

  static List<String>? _getDomains(Map<String, dynamic> json) {
    if (json['domainClasses'] == null) {
      return null;
    }
    List<String> result = [];
    for (Map<String, dynamic> dom in json['domainClasses']) {
      result.add(dom['text']);
    }
    return result;
  }

  static List<String>? _getSynonyms(Map<String, dynamic> json) {
    if (json['synonyms'] == null) {
      return null;
    }
    List<String> result = [];
    for (Map<String, dynamic> syn in json['synonyms']) {
      result.add(syn['text']);
    }
    return result;
  }

  static List<Subsense>? _getSubsenses(Map<String, dynamic> json) {
    if (json['subsenses'] == null) {
      return null;
    }
    List<Subsense> result = [];
    for (Map<String, dynamic> subsense in json['subsenses']) {
      result.add(Subsense.fromJson(subsense));
    }
    return result;
  }
}
