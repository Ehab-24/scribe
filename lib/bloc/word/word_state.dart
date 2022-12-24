part of 'word_bloc.dart';

@immutable
abstract class WordState {}

@immutable
class WordInitial extends WordState {}

@immutable
class WordError extends WordState {
  final String message;

  WordError(this.message);
}

@immutable
class WordLoading extends WordState {}

@immutable
class WordLoaded extends WordState {
  final Word word;

  WordLoaded(this.word);
}