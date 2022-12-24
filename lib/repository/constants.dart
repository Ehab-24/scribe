const String wordsTable = 'words_table';
// const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const String textType = 'TEXT NOT NULL';

class WordFeilds {
  static const String wordId = 'word_id';
  static const String jsonString = 'json';

  static List<String> allFeilds = [
    wordId,
    jsonString,
  ];
}