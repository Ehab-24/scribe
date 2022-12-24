part of 'stored_words_bloc.dart';

@immutable
abstract class StoredWordsEvent {}

@immutable
class GetAllWords extends StoredWordsEvent{}

@immutable
class RemoveWord extends StoredWordsEvent{
  final String wordId;

  RemoveWord(this.wordId);
}