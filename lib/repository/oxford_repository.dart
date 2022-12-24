import 'dart:convert';

import 'package:backend_testing/repository/local_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../Models/Word.dart';

class OxfordRepository {
  static Future<Word> getData(String wordId) async {

    final Word? localResponse = await _searchLocalStorage(wordId);
    if(localResponse != null) {
      return localResponse;
    }

    final response = await _requestDataOxford(wordId);

    _checkForErrors(response.statusCode);

    await LocalRepository.instance.addWord(wordId, response.body);

    final json = jsonDecode(response.body);

    return Word.fromJson(json);
  }

  static Future<Word?> _searchLocalStorage(String wordId) async {
    final Word? possibleResponse = await LocalRepository.instance.readWord(wordId);
    if(possibleResponse != null) {
      return possibleResponse;
    }
    return null;
  }

  static _checkForErrors(int statusCode) {
    if(statusCode >= 500) {
      throw 'Error! Please try again later.';
    }
    if (statusCode >= 400) {
      throw 'Word not found!';
    }
  }

  static Future<Response> _requestDataOxford(String wordId) async {
    const String appId = 'b29f4536';
    const String appKey = '3e0777ec598ea613c7376a1caf0b7937';
    const String baseUrl = 'https://od-api.oxforddictionaries.com/api/v2';
    const String endpoint = 'entries';
    const String language = 'en-gb';

    final url = '$baseUrl/$endpoint/$language/$wordId';
    final headers = {'app_id': appId, 'app_key': appKey};
    final Uri uri = Uri.parse(url);

    return await http.get(uri, headers: headers);
  }

  // static Future<Word> getDataMerriam(String wordId) async {
  //   final response = await _requestDataMerriam(wordId);

  //   final json = jsonDecode(response.body);

  //   //stems:- json[0]['meta']['stems']
  //   //definition:- json[0]['def'][0]['sseq'][0][0][1]['dt'][0][1]

  //   // print(def.sseq.senses.first.dt.def);
  //   // print(def.sseq.senses.first.dt.exp);

  //   // final sseq = json[0]['def'][0]['sseq'];

  //   final Def def = Def.fromJson(json[0]['def']);
  //   final String fl = json[0]['fl'];

  //   print(json);

  //   return Word(id: wordId, fl: fl, def: def, stems: []);
  // }

  static Future<Response> _requestDataMerriam(String wordId) async {
    // final url = Uri.parse('https://dictionaryapi.com/api/v3/references/thesaurus/json/$wordId?key=a79c5a88-597d-45fc-abec-5c046076dab4');

    final url = Uri.parse(
        'https://dictionaryapi.com/api/v3/references/collegiate/json/$wordId?key=46f597e2-985b-44a1-9266-b592a16dd17d');
    return await http.get(url);
  }
}