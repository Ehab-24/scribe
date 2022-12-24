part of 'stored_words_bloc.dart';

@immutable
abstract class StoredWordsState {}

@immutable
class StoredWordsLoading extends StoredWordsState{}

@immutable
class StoredWordsLoaded extends StoredWordsState{
  final List<Word> words;

  StoredWordsLoaded(this.words);
}