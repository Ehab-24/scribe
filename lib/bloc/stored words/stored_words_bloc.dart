import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/Word.dart';
import '../../repository/local_repository.dart';

part 'stored_words_event.dart';
part 'stored_words_state.dart';

class StoredWordsBloc extends Bloc<StoredWordsEvent, StoredWordsState> {
  List<Word> words = [];

  StoredWordsBloc() : super(StoredWordsLoading()) {
    on<StoredWordsEvent>((event, emit) async {
      if (event is GetAllWords) {
        emit(
          StoredWordsLoading(),
        );
        words = await LocalRepository.instance.readAllWords();
        emit(
          StoredWordsLoaded(words),
        );
      } else if (event is RemoveWord) {
        LocalRepository.instance.removeWord(event.wordId);
        words.removeWhere((word) => word.id == event.wordId);
        emit(
          StoredWordsLoaded(words),
        );
      }
    });
  }
}
