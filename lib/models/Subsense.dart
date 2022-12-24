import 'package:backend_testing/globals/extension_methods.dart';
import 'package:flutter/material.dart';

import '../globals/Constants.dart';
import '../presentation/ui elements/colors.dart';
import '../presentation/ui elements/styles.dart';

class Subsense {
  List<String>? definitions, domains, synonyms, examples;
  Subsense({
    required this.definitions,
    required this.examples,
    required this.domains,
    required this.synonyms,
  });

  factory Subsense.fromJson(Map<String, dynamic> json) => Subsense(
        definitions: _getDefinitions(json),
        examples: _getExamples(json),
        domains: _getDomains(json),
        synonyms: _getSynonyms(json),
      );

  Widget get widget => Container(
        padding: const EdgeInsets.only(left: 16.0, top: 16.0),
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
          ],
        ),
      );

  static List<Widget> _textWidgets(List<String>? strings, final String header) {
    if (strings == null) {
      return [];
    }
    List<Widget> result = [];
    result.addAll([
      Text(
        header,
        style: Styles.b6(primaryDark),
      ),
      spacev(8.0),
    ]);
    for (String str in strings) {
      result.add(
        SelectableText(
          str.capitalize(),
        ),
      );
    }
    result.add(space20v);
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
}
