part of 'word_bloc.dart';

@immutable
abstract class WordEvent {}

@immutable
class GetWordData extends WordEvent {
  final String wordId;

  GetWordData(this.wordId);
}